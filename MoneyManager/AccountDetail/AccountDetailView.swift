//
//  AccountDetailView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/25.
//

import SwiftUI

struct AccountDetailView: View {
    
    @ObservedObject var accountDetailVM: AccountDetailViewModel = AccountDetailViewModel()
    
    var body: some View {
        VStack {
            AccountHeaderView(title: "總資產", money: $accountDetailVM.totalAssets)
            AccountHeaderView(title: "總負債", money: $accountDetailVM.totalLiability)
            AccountHeaderView(title: "結餘", money: $accountDetailVM.balance)
                        
            ScrollView {
                AccountCellView(sectionHeader: "計入總計",
                                datas: $accountDetailVM.includeTotalAccounts)
                // 不計入總計
                if accountDetailVM.notIncludeTotalAccounts.count > 0 {
                    AccountCellView(sectionHeader: "不計入總計",
                                    datas: $accountDetailVM.notIncludeTotalAccounts)
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("新增", destination: AddAccountView())
            }
        }
        .navigationTitle("帳戶")
        .hideBackButtonTitle()
        .onAppear {
            accountDetailVM.getAccounts()
        }
    }
}


struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailView()
    }
}
