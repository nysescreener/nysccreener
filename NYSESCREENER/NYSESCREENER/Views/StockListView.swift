
import SwiftUI

struct StockListView: View {
    @StateObject var stockListViewModel = stockListVM()
    @StateObject var topGainersViewModel = topMoversVM()
    @StateObject var topLosersViewModel = topMoversVM()
    
    @State var tickers = ["aapl", "twtr", "msft", "tsla","goog","s","f", "rivn","fsr"]
    
    var body: some View {
        NavigationView{
        VStack(alignment: .leading){
            HStack{
                Text("WatchList Stocks")
            Spacer()
            Button{
                Task{
                    let searchText = tickers.joined(separator: ",")
                    await stockListViewModel.refresh(ticker: searchText)
                }
            } label: {
                Text("Refresh")
            }
            }.padding()
//            NavigationView{
                List(stockListViewModel.stockData, id: \.self){ item in
                    NavigationLink{
                        StockDetailView(tckr:item.ticker!)

                    }label: {
                        HStack{
                            Text(String(item.ticker ?? "Nan"))
                            Spacer()
                            Text("$"+String(item.tngoLast ?? 0.0))
                            Spacer()
                        }
                    }
                    
                }
                .animation(.default, value: stockListViewModel.stockData)
                
//            }
            HStack{
                VStack{
                    Text("TOP GAINERS")
            List(topGainersViewModel.moversData, id: \.self) { item in
                HStack{
                    Text(item.symbol).font(.system(size:10))
                    Spacer()
//                    Text("Change : ").font(.system(size:10))
                    Spacer()
                    Text(": \(String(item.changesPercentage))%" )
                        .foregroundColor(Color.green).font(.system(size:10))
                }
            }
                }
                VStack{
                    Text("TOP LOSERS")
            List(topLosersViewModel.moversData, id: \.self) { item in
                HStack{
                    Text(item.symbol).font(.system(size:10))
                    Spacer()
//                    Text("Change : ").font(.system(size:6))
                    Spacer()
                    Text(": \(String(item.changesPercentage))%" )
                        .foregroundColor(Color.red).font(.system(size:10))
                }
            }
                }
            }
            
            
            Spacer()
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
}

struct StockListView_Previews: PreviewProvider {
    static var previews: some View {
        StockListView().preferredColorScheme(.dark)
    }
}



