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
            TextField("名稱", text: $registerVM.userName)
                .textFieldStyle(.roundedBorder)
                .font(.title2)
            
            Button {
                registerVM.addUser()
                registerVM.userName = ""
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("新增")
                    .font(.title2)
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .padding()
        .navigationTitle("新增用戶")
        
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
            .environmentObject(UserViewModel())
    }
}
