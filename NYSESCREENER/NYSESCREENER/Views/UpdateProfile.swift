//
//  UpdateProfile.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/1/22.
//

import SwiftUI

struct UpdateProfile: View {
//    @State var first : String
    @ObservedObject private var vm = Mainview()
    var body: some View {
        VStack(alignment: .leading, spacing: nil){
            Text("First Name : \(vm.first)").padding(.trailing,250).padding()
            Text("Last Name : \(vm.last)").padding(.trailing,250).padding()
            Text("Phone : \(vm.phone)").padding(.trailing,250).padding()
            Text("Email : \(vm.Email)").padding(.trailing,250).padding()
                Spacer()

            
            }
        
        }
    }

struct UpdateProfile_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfile()
    }
}
