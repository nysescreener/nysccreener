//
//  StockDetailView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/1/22.
//

import SwiftUI

struct StockDetailView: View {
    @State var tckr: String
    @StateObject var stockDetailViewModel = stockDetailVM()
    
    var body: some View {
        VStack{
            Text("\(tckr) Details")
        
            List(stockDetailViewModel.stockData, id: \.self){ item in
                VStack(alignment: .leading, spacing: nil){
                    HStack{
                        Spacer()
                        Text("Open")
                        Spacer()
                        Text(String(item.open))
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Text("Close")
                        Spacer()
                        Text(String(item.close))
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Text("High")
                        Spacer()
                        Text(String(item.high))
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Text("Low")
                        Spacer()
                        Text(String(item.low))
                        Spacer()
                    }
                }
                }
                
                
            }
            .animation(.default, value: stockDetailViewModel.stockData)
        
        .overlay{
            if stockDetailViewModel.fetching {
                ProgressView("Data Fetching in progress")
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            }
        }
        .task {
            await stockDetailViewModel.refresh(ticker: tckr)
        }
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(tckr: "aapl")
    }
}
