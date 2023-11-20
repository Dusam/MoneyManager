//
//  AccountHeaderView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/25.
//

import SwiftUI

struct AccountHeaderView: View {
    
    var title = ""
    @Binding var money: Int
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 22))
                .lineLimit(1)
                .multilineTextAlignment(.leading)
            Spacer()
            Text("$ \(money)")
                .foregroundColor(money >= 0 ? .green : .red)
                .font(.system(size: 22))
                .lineLimit(1)
                .multilineTextAlignment(.trailing)
            
        }
        .padding(10)
    }
}

struct AccountHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AccountHeaderView(title: "", money: .constant(200))
    }
}
