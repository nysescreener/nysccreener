
import SwiftUI

struct StockListView: View {
    @StateObject var stockListViewModel = stockListVM()
    @StateObject var topGainersViewModel = topMoversVM()
    @StateObject var topLosersViewModel = topMoversVM()
    
    @State var tickers = ["aapl", "twtr", "msft", "tsla","goog","s","f", "rivn","fsr"]
    
    var body: some View {
        VStack{
            Text("WatchList Stocks")
            Button{
                Task{
                    let searchText = tickers.joined(separator: ",")
                    await stockListViewModel.refresh(ticker: searchText)
                }
            } label: {
                Text("Refresh")
            }
            
            List(topGainersViewModel.moversData, id: \.self) { item in
                HStack{
                    Text(item.symbol)
                    Spacer()
                    Text("Change : ")
                    Spacer()
                    Text("\(String(item.changesPercentage))%" )
                        .foregroundColor(Color.green)
                }
            }
            List(topLosersViewModel.moversData, id: \.self) { item in
                HStack{
                    Text(item.symbol)
                    Spacer()
                    Text("Change : ")
                    Spacer()
                    Text("\(String(item.changesPercentage))%" )
                        .foregroundColor(Color.red)
                }
            }
            
            
            NavigationView{
                
                List(stockListViewModel.stockData, id: \.self){ item in
      
                    NavigationLink(destination: StockDetailView(tckr:item.ticker!)){
                        HStack{
                            Text(String(item.ticker ?? "Nan"))
                            Spacer()
                            Text("$"+String(item.tngoLast ?? 0.0))
                            Spacer()
                        }}
                    
                }
                .animation(.default, value: stockListViewModel.stockData)
                
            }
        }
        
        .overlay{
            if stockListViewModel.fetching {
                ProgressView("Data Fetching in progress")
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            }
        }
        .task {
            let searchText = tickers.joined(separator: ",")
            await stockListViewModel.refresh(ticker: searchText)
            await topGainersViewModel.refresh(ticker: "gainers")
            await topLosersViewModel.refresh(ticker: "losers")
                
            
        }
        .refreshable{
            let searchText = tickers.joined(separator: ",")
            await stockListViewModel.refresh(ticker: searchText)
            await topGainersViewModel.refresh(ticker: "gainers")
            await topLosersViewModel.refresh(ticker: "losers")
            
        }
        
        
    }
    
}

struct StockListView_Previews: PreviewProvider {
    static var previews: some View {
        StockListView().preferredColorScheme(.dark)
    }
}

