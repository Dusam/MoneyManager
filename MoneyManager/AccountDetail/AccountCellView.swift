//
//  AccountCellView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/25.
//

import SwiftUI

struct AccountCellView: View {
    
    var sectionHeader: String = ""
    @Binding var datas: [AccountModel]
    
    var body: some View {
        Section {
            ForEach(datas, id: \.self) { account in
                HStack {
                    Text(account.name)
                        .font(.system(size: 22))
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text("$ \(account.money)")
                        .foregroundColor(account.money >= 0 ? .green : .red)
                        .font(.system(size: 22))
                        .lineLimit(1)
                        .multilineTextAlignment(.trailing)
                    
                }
                .padding(10)
            }
        } header: {
            VStack(alignment: .leading) {
                Text(sectionHeader)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
            }
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .lightGray))
        }
    }
}

struct AccountCellView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCellView(sectionHeader: "", datas: .constant([]))
    }
}
