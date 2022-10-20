//
//  UserCellView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import SwiftUI
import Introspect

struct UserCellView: View {
    var user: UserModel!
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationLink("") {
                DetailView(userModel: user)
            }
            .opacity(0)
            
            Text(user.name)
                .font(.system(.title2))
            
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 1)
        )
        
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserCellView(user: UserModel())
    }
}
