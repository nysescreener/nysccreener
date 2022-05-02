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
                    VStack{
                        
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
                        }
                        ///
                        Button{
                        let email = EmailData(recipient: "georgekj1998@gmail.com", subject: "WatchList", messageHeader: "Here is my watchlist", body: tickers.joined(separator: ","))
                                        email.send(openURL: openURL)

                                    } label:{
                                        Text("Share Watchlist")
                                    }
                        
                        
                        
                    }
                    Spacer()
                    
                }
                
            }
        }
    }
    
    func deleteaccount() {
        let user = FirebaseManager.shared.auth.currentUser
        
//        let uid = FirebaseManager.shared.auth.currentUser?.uid
        user?.delete{ error in
            if error != nil {
              // An error happened.
            } else {
              print("deleted")
                exit(0)
            }
          }
//        print(uid as Any)
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
