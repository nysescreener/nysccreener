
import SwiftUI
import Marquee

struct StockListView: View {
    @StateObject var stockListViewModel = stockListVM()
    @StateObject var topGainersViewModel = topMoversVM()
    @StateObject var topLosersViewModel = topMoversVM()
    @StateObject var IndexListViewModel = stockListVM()
    
    @State var marquee: String = ""
    @State var indexTickers = ["index", "nasdx", "aapl", "msft" ]
    
//    @State var tickers = ["aapl", "twtr", "msft", "tsla","goog","s","f", "rivn","fsr"]
    @ObservedObject var vm = Mainview()
    var body: some View {
//        VStack(alignment: .leading, spacing: nil){
        NavigationView{
            VStack(alignment: .leading,spacing: nil){
                Marquee {
                    Text(marquee)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(0)
                }
                .marqueeDuration(5)
                HStack{
                    Text("WatchList Stocks")
                    Spacer()
                    Button{
                        Task{
                            let searchText = vm.watchList.joined(separator: ",")
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
                let searchText = vm.watchList.joined(separator: ",")
                await stockListViewModel.refresh(ticker: searchText)
                await topGainersViewModel.refresh(ticker: "gainers")
                await topLosersViewModel.refresh(ticker: "losers")
                let indexText = indexTickers.joined(separator: ",")
                await IndexListViewModel.refresh(ticker: indexText)
                retrieveFlowPrices()
                
                
            }
            .refreshable{
                let searchText = vm.watchList.joined(separator: ",")
                await stockListViewModel.refresh(ticker: searchText)
                await topGainersViewModel.refresh(ticker: "gainers")
                await topLosersViewModel.refresh(ticker: "losers")
                let indexText = indexTickers.joined(separator: ",")
                await IndexListViewModel.refresh(ticker: indexText)
                retrieveFlowPrices()
                
            }
            
        }
//        }
        
    }
    func retrieveFlowPrices() {
        marquee = ""
        //        print(IndexListViewModel.stockData)
        IndexListViewModel.stockData.forEach{item in
            let ele = " " + String(item.ticker ?? "") + " " + String(item.tngoLast ?? 0.0) + " "
            //            print(ele)
            marquee.append(String(ele))
            //            print(marquee)
        }
    }
}

    
struct StockListView_Previews: PreviewProvider {
    static var previews: some View {
        StockListView().preferredColorScheme(.dark)
    }
}



