//
//  Settings.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 4/26/22.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
        NavigationView{
        VStack(alignment: .leading, spacing: nil){
        HStack{
            
                NavigationLink{
                    UpdateProfile()
                }label: {
                    Text("Update Profile")
                }.padding()
            Spacer()
                
            }
            Spacer()
     
            }
            
        }
        }
    }
    }

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
