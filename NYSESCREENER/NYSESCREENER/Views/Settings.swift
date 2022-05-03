//
//  Settings.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 4/26/22.
//

import SwiftUI

struct Settings: View {
    @Environment(\.openURL) var openURL
    @State var tickers = ["aapl", "twtr", "msft", "tsla","goog","s","f", "rivn","fsr"]
    @ObservedObject var m = Mainview()
    @State private var showingAlert2 = false
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            NavigationView{
                VStack(alignment: .leading, spacing: nil){
                    VStack(alignment: .leading){
                        
                        NavigationLink{
                            UpdateProfile(firstname: $m.first, lastname:$m.last, phonenumber: $m.phone, email: $m.Email)
                        }label: {
                            Text("Update Profile")
                        }.padding()
                        ///
                        Button {
                            showingAlert2 = true
                        }label: {
                            Text ("Delete Account")
                        }.alert("Conform To Delete Account", isPresented: $showingAlert2){
                            Button("Conform", role: .destructive){
                                deleteaccount()
                               
                            }
                            Button("Cancle", role: .cancel){}
                        }.padding()
                        ///
                        Button{
                        let email = EmailData(recipient: "georgekj1998@gmail.com", subject: "WatchList", messageHeader: "Here is my watchlist", body: tickers.joined(separator: ","))
                                        email.send(openURL: openURL)

                                    } label:{
                                        Text("Share Watchlist")
                                    }.padding()
                        ///
                        Button{
                            
                        }label: {
                            Text("FeedBack")
                        }.padding()
                        
                        ZStack{
                        Button{
                            
                        }label: {
                            Text("Review App")
                        }.padding()
                        
                        }
                        
                    }
                    Spacer()
                    
                }.padding(.trailing,235)
                
            }
        }
    }
    

}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

struct Feedback : View{
    var body: some View{
        VStack{
            HStack{
                Text("Please Rate The Quality of the product").fontWeight(.bold).foregroundColor(.white)
                Spacer()
                
            }.padding().background(Color.white).cornerRadius(10)
            
        }
    }
}
