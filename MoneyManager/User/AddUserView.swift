//
//  AddUserView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import SwiftUI

struct AddUserView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var registerVM: UserViewModel
    
    var body: some View {
        VStack {
            TextField(R.string.localizable.name(), text: $registerVM.userName)
                .textFieldStyle(.roundedBorder)
                .font(.title2)
            
            Button {
                registerVM.addUser()
                registerVM.userName = ""
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text(R.string.localizable.add())
                    .font(.title2)
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .padding()
        .navigationTitle(R.string.localizable.addUser())
        
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
            .environmentObject(UserViewModel())
    }
}
