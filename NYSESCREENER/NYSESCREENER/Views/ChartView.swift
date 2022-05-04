//
//  ChartView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/3/22.
//

import SwiftUI
import SwiftUICharts


import SwiftUI

struct chartView: View {
    @StateObject var chartViewModel = chartPriceVM()
    @Binding var ticker: String
    @State var points: [DataPoint] = [DataPoint]()
    @State private var isBar = true
    
    func generatePoints() {

        for (index, item) in chartViewModel.priceData.enumerated() {
            let point: DataPoint = .init(value: item, label: "\(ticker)", legend: Legend(color: .green, label: "\(ticker)"))
            points.append(point)
//            print(ticker)
        }
    }
    
    
    var body: some View {
//        NavigationView {
            VStack{
                Section(header: Text("6 Months")){
                LineChartView(dataPoints: points)
                }
            }
            
        
        .overlay{
            if chartViewModel.fetching {
                ProgressView("Data Fetching in progress")
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
            }
        }
        .task {
            await chartViewModel.refresh(ticker: ticker)
            generatePoints()
//            print(points)
            
        }
        .refreshable {
            await chartViewModel.refresh(ticker: ticker)
            generatePoints()
        }
//    }
}
}
