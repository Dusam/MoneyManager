//
//  AddAccountViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/9.
//

import Foundation
import Observation

@Observable
class AddAccountViewModel: ObservableObject {
    
    var accountType: AccountType = .cash
    var accountName: String = ""
    var initMoney: String = "0"
    var isHiddenCalculator: Bool = true
    var includTotal: Bool = true
    
    @ObservationIgnored
    private var accountModel: AccountModel = AccountModel()
    
    
    func saveAccount() {
        self.accountModel.userId = UserInfo.share.selectedUserId
        self.accountModel.type = accountType.typeInt
        self.accountModel.name = accountName
        self.accountModel.includTotal = includTotal
        self.accountModel.initMoney = initMoney.int ?? 0
        self.accountModel.money = initMoney.int ?? 0
        
        RealmManager.share.saveData(self.accountModel)
        
        let selectedData = UserInfo.share.selectedData
        selectedData.accountId = self.accountModel.id.stringValue
        selectedData.transferToAccountId = self.accountModel.id.stringValue
        UserInfo.share.selectedData = selectedData
    }
}
