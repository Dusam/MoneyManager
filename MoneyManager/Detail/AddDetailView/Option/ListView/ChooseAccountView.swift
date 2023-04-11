//
//  AccountListView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/8.
//

import SwiftUI

struct ChooseAccountView: View {
    enum AccountMode {
        case standard, transfer
    }
    
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var accountDatas: [AccountModel] = []
    
    var mode: AccountMode = .standard
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(accountDatas, id: \.id) { account in
                Button {
                    if mode == .transfer {
                        addDetailVM.transferToAccountId = account.id.stringValue
                        addDetailVM.transferToAccountName = account.name
                    } else {
                        addDetailVM.accountId = account.id.stringValue
                        addDetailVM.accountName = account.name
                    }
                    
                    dismiss()
                } label: {
                    Text(account.name)
                        .foregroundColor(.black)
                        .font(.system(size: 22))
                        .padding([.top, .bottom, .leading], 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .overlay(
                            VStack {
                                Divider().offset(x: 0, y: 29)
                            }
                        )
                }
            }
            
        }
        .navigationTitle(R.string.localizable.account() )
        .hideBackButtonTitle()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(R.string.localizable.add(), destination: AddAccountView())
            }
        }
        .onAppear {
            accountDatas = RealmManager.share.getAccount(userId: UserInfo.share.selectedUserId)
        }
    }
}

struct ChooseAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseAccountView()
    }
}
