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
            AccountHeaderView(title: R.string.localizable.totalAssets(), money: $accountDetailVM.totalAssets)
            AccountHeaderView(title: R.string.localizable.totalLiability(), money: $accountDetailVM.totalLiability)
            AccountHeaderView(title: R.string.localizable.theBalance(), money: $accountDetailVM.balance)
                        
            ScrollView {
                AccountCellView(sectionHeader: R.string.localizable.joinTotal(),
                                datas: $accountDetailVM.includeTotalAccounts)
                // 不計入總計
                if accountDetailVM.notIncludeTotalAccounts.count > 0 {
                    AccountCellView(sectionHeader: R.string.localizable.notJoinTotal(),
                                    datas: $accountDetailVM.notIncludeTotalAccounts)
                }
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(R.string.localizable.add(), destination: AddAccountView())
            }
        }
        .navigationTitle(R.string.localizable.account())
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
