//
//  StockDetailView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/1/22.
//

import SwiftUI
import FirebaseFirestore
struct StockDetailView: View {
    @State var tckr: String
    @StateObject var stockDetailViewModel = stockDetailVM()
    @ObservedObject var vm = Mainview()
    
    var body: some View {
        VStack{
            HStack{
                Text("\(tckr) Details").padding()
                Spacer()
                VStack{
                HStack{
                    HStack{
                    Text("WatchList")
                Button{
                    addwatchlist(tcker: tckr)
                }label: {
                    Text("+")
                }
                Button{
                    removewatchlist(tcker: tckr)
                }label:{
                    Text("-")
                }.padding()
                    }
                    
            }.padding()
                    
                    
            }
                
                
            }
            
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
            VStack{
                    HStack{
                        HStack{
                        Text("Add To Flow Bar")
                    Button{
                        addflowbar(tcker: tckr)
                    }label: {
                        Text("Add")
                    }
                    Button{
                        removeflowbar(tcker: tckr)
                    }label:{
                        Text("Remove")
                    }.padding()
                        }
            
                }.padding()
            
            
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

//func addwatchlist(watchlist : String){
//
//    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
////    print(watchlist)
//
//
//    var watch :[String] = watch.append(watchlist)
//    print(watch)
//
//    let userData1 = ["whatchlist" : ["hello1","hel","hi","hello12134"]]
//
//    FirebaseManager.shared.firestore.collection("users").document(uid).updateData(userData1) { err in
//        if let err = err {
//            print(err)
////            self.Loginstatus1 = "Failed to Update"
//            return
//        }
//    }
//
//}

func addwatchlist(tcker : String){
       var db = Firestore.firestore()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    db.collection("users").firestore.collection("users").document(uid).updateData(["watchlist" : FieldValue.arrayUnion([tcker])])
    
}

func removewatchlist(tcker : String){
       var db = Firestore.firestore()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    db.collection("users").firestore.collection("users").document(uid).updateData(["watchlist" : FieldValue.arrayRemove([tcker])])
    
}

func addflowbar(tcker : String){
       var db = Firestore.firestore()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    db.collection("users").firestore.collection("users").document(uid).updateData(["flowbar" : FieldValue.arrayUnion([tcker])])
    
}

func removeflowbar(tcker : String){
       var db = Firestore.firestore()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
    db.collection("users").firestore.collection("users").document(uid).updateData(["flowbar" : FieldValue.arrayRemove([tcker])])
    
}



struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(tckr: "aapl")
    }
}

//func fetchWatchList(wat) {
//    
////    @Published var watchList = [String]()
//    var db = Firestore.firestore()
//    guard let uid = FirebaseManager.shared.auth.currentUser?.uid else{return}
//
//    db.collection("users").firestore.collection("users").document(uid).updateData(["watchlist" : FieldValue.arrayUnion(watchList)])
//}

