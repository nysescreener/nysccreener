
import SwiftUI

struct StockListView: View {
    @StateObject var stockListViewModel = stockListVM()
    @State var tickers = ["aapl", "twtr", "msft", "tsla","goog"]
    
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
//
//            Text(String(stockListViewModel.stockData.items[0].adjClose))
            NavigationView {
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
        }

    }
}

struct StockListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

