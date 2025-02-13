//
//  AccountDetailViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/25.
//

import Foundation
import Observation

@Observable
class AccountDetailViewModel: ObservableObject {
    var totalAssets: Int = 0
    var totalLiability: Int = 0
    var balance: Int = 0
    
    var includeTotalAccounts: [AccountModel] = []
    var notIncludeTotalAccounts: [AccountModel] = []
}

extension AccountDetailViewModel {
    func getAccounts() {
        includeTotalAccounts.removeAll()
        notIncludeTotalAccounts.removeAll()
        totalAssets = 0
        totalLiability = 0
        balance = 0
        
        let accounts = RealmManager.share.getAccount(userId: UserInfo.share.selectedUserId)
        
        includeTotalAccounts = accounts.filter { $0.includTotal }
        notIncludeTotalAccounts = accounts.filter { !$0.includTotal}
        
        includeTotalAccounts.forEach { account in
            if account.money >= 0 {
                totalAssets += account.money
            } else {
                totalLiability += account.money
            }
            
            balance = totalAssets + totalLiability
            
        }
    }
}
