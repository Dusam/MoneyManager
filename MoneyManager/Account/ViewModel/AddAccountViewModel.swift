//
//  AddAccountViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/9.
//

import Foundation

class AddAccountViewModel: ObservableObject {
    
    @Published var accountType: AccountType = .cash
    @Published var accountName: String = ""
    @Published var initMoney: String = "0"
    @Published var isHiddenCalculator: Bool = true
    @Published var includTotal: Bool = true
    
    private var accountModel: AccountModel = AccountModel()
    
    
    func saveAccount() {
        self.accountModel.userId = UserInfo.share.selectedUserId
        self.accountModel.type = accountType.typeInt
        self.accountModel.name = accountName
        self.accountModel.includTotal = includTotal
        self.accountModel.initMoney = initMoney.int ?? 0
        self.accountModel.money = initMoney.int ?? 0
        
        RealmManager.share.saveAccount(self.accountModel)
    }
}
