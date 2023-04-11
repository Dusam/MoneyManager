//
//  AddDetailViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import Foundation
import SwiftUI
import RealmSwift
import SamUtils

class AddDetailViewModel: ObservableObject {
    
    init() {
        selectedData = UserInfo.share.selectedData
        
        detailGroupId = selectedData.expensesGroupId
        detailTypeId = selectedData.expensesTypeId

        accountId = selectedData.accountId
        transferToAccountId = selectedData.transferToAccountId
    }
    
    private var selectedData = UserInfo.share.selectedData
    
    private var currentDate = UserInfo.share.selectedDate {
        didSet {
            UserInfo.share.selectedDate = currentDate
            currentDateString = currentDate.string(withFormat: "yyyy-MM-dd(EE)")
        }
    }
        
    @Published var currentDateString = UserInfo.share.selectedDate.string(withFormat: "yyyy-MM-dd(EE)")
    @Published var billingType: BillingType = .expenses {
        didSet {
            switch billingType {
            case .expenses:
                detailGroupId = selectedData.expensesGroupId
                detailTypeId = selectedData.expensesTypeId
            case .income:
                detailGroupId = selectedData.incomeGroupId
                detailTypeId = selectedData.incomeTypeId
            case .transfer:
                detailGroupId = selectedData.transferGroupId
                detailTypeId = selectedData.trnasferTypeId
            }
        }
    }
    
    // 計算機參數
    @Published var isHiddenCalculator = false
    @Published var isEditingTransferFee = false
    @Published var valueString = "0"
    @Published var transferFee = "0"
    
    // 新增頁面參數
    @Published var typeName: String = ""
    @Published var detailGroupId: String = "" {
        didSet {
            typeName = DBTools.detailTypeToString(billingType: billingType, detailGroupId: detailGroupId, detailTypeId: detailTypeId)
            
            detailTypeModels = RealmManager.share.getDetailType(detailGroupId)
        }
    }
    @Published var detailTypeId: String = "" {
        didSet {
            typeName = DBTools.detailTypeToString(billingType: billingType, detailGroupId: detailGroupId, detailTypeId: detailTypeId)
            storeSelectedType()
        }
    }
    @Published var detailTypeModels: [DetailTypeModel] = []
    
    // 新增列表參數
    @Published var accountName: String = ""
    @Published var accountId: String = "" {
        didSet {
            getAccountName()
        }
    }
    @Published var transferToAccountName: String = ""
    @Published var transferToAccountId: String = "" {
        didSet {
            getAccountName()
        }
    }
    
    // 備註參數
    @Published var needRefershMemo: Bool = true
    @Published var memo: String = "" {
        didSet {
            needRefershMemo = true
            // 延遲0.1秒以達成不會點擊常用備註後只顯示完全符合字串的選項
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.getCommonMemos()
            }
        }
    }
    @Published var commonMemos: [MemoModel] = []
    
    private var detailModel: DetailModel = DetailModel()
    
    private func storeSelectedType() {
        if self.detailModel.accountName.isEmpty {
            switch billingType {
            case .expenses:
                selectedData.expensesGroupId = detailGroupId
                selectedData.expensesTypeId = detailTypeId
            case .income:
                selectedData.incomeGroupId = detailGroupId
                selectedData.incomeTypeId = detailTypeId
            case .transfer:
                selectedData.transferGroupId = detailGroupId
                selectedData.trnasferTypeId = detailTypeId
            }
        }
        
        UserInfo.share.selectedData = selectedData
    }
}

extension AddDetailViewModel {
    func toNextDate() {
        currentDate = currentDate.adding(.day, value: 1)
    }
    
    func toPreviousDate() {
        currentDate = currentDate.adding(.day, value: -1)
    }
    
    func toCurrentDate() {
        currentDate = Date()
    }
    
    func setEditDetailModel(_ detailModel: DetailModel) {
        self.detailModel = detailModel
        
        if let billType = BillingType(rawValue: detailModel.billingType) {
            billingType = billType
            
            currentDate = detailModel.date.toDate()
            valueString = detailModel.amount.string
            detailGroupId = detailModel.detailGroup
            detailTypeId = detailModel.detailType
            accountId = detailModel.accountId.stringValue
            memo = detailModel.memo
            
            if billType == .transfer {
                transferToAccountId = detailModel.toAccountId.stringValue
            }
        }
        
    }
}

// MARK: 選項字串
extension AddDetailViewModel {
    func getAccountName() {
        if !accountId.isEmpty {
            if self.detailModel.accountName.isEmpty {
                // 空值代表正在新增，此時才儲存選擇過的帳戶
                selectedData.accountId = accountId
            }
            accountName = RealmManager.share.getAccount(accountId, userId: UserInfo.share.selectedUserId).first?.name ?? ""
        }
        
        if !transferToAccountId.isEmpty {
            if self.detailModel.toAccountName.isEmpty {
                // 空值代表正在新增，此時才儲存選擇過的帳戶
                selectedData.transferToAccountId = transferToAccountId
            }
            transferToAccountName = RealmManager.share.getAccount(transferToAccountId, userId: UserInfo.share.selectedUserId).first?.name ?? ""
        }
        
        UserInfo.share.selectedData = selectedData
    }
}

// MARK: DB Method
extension AddDetailViewModel {
    func createDetail() {
        let date = currentDate.string(withFormat: "yyyy-MM-dd")
        // 金額大於0才儲存
        if let amount = valueString.int, amount > 0, let accountId = try? ObjectId(string: accountId) {
            self.detailModel.userId = UserInfo.share.selectedUserId
            self.detailModel.billingType = self.billingType.rawValue
            self.detailModel.accountId = accountId
            self.detailModel.accountName = accountName
            self.detailModel.detailGroup = detailGroupId
            self.detailModel.detailType = detailTypeId
            self.detailModel.amount = amount
            self.detailModel.memo = memo
            self.detailModel.date = date
            self.detailModel.modifyDateTime = date
            
            if self.billingType == .transfer {
                
                if let toAccountId = try? ObjectId(string: transferToAccountId) {
                    self.detailModel.toAccountId = toAccountId
                    self.detailModel.toAccountName = transferToAccountName
                    
                    RealmManager.share.updateAccountMoney(billingType: self.billingType, amount: amount, accountId: accountId, toAccountId: toAccountId)
                } else {
                    return
                }
                
            } else {
                RealmManager.share.updateAccountMoney(billingType: self.billingType, amount: amount, accountId: accountId)
            }
            
            RealmManager.share.saveData(self.detailModel)
        }
        
        
        // 手續費金額大於0才儲存
        if let transferFee = transferFee.int, transferFee > 0, let accountId = try? ObjectId(string: accountId) {
            // 儲存手續費
            let transferFeeModel = DetailModel()
            transferFeeModel.userId = UserInfo.share.selectedUserId
            transferFeeModel.billingType = 0
            transferFeeModel.accountId = accountId
            transferFeeModel.accountName = accountName
            transferFeeModel.detailGroup = ExpensesGroup.fee.rawValue.string
            transferFeeModel.detailType = ExpensesFee.transfer.rawValue.string
            transferFeeModel.amount = transferFee
            transferFeeModel.memo = R.string.localizable.transferFee()
            transferFeeModel.date = date
            transferFeeModel.modifyDateTime = date
            RealmManager.share.saveData(transferFeeModel)
            
            RealmManager.share.updateAccountMoney(billingType: .expenses, amount: transferFee, accountId: accountId)
        }
        
        // 新增 Memo
        if !memo.isEmpty {
            getCommonMemos()
            if commonMemos.count > 0, let model = commonMemos.first {
                // 更新次數
                RealmManager.share.saveData(model, update: true)
            } else {
                let model = MemoModel()
                model.userId = UserInfo.share.selectedUserId
                model.billingType = billingType.rawValue
                model.detailGroup = detailGroupId
                model.memo = memo
                model.count = 1
                RealmManager.share.saveData(model)
            }
           
        }
    }
    
    func updateDetail() {
        let date = currentDate.string(withFormat: "yyyy-MM-dd")
        // 金額大於0才儲存
        if let amount = valueString.int, amount > 0, let accountId = try? ObjectId(string: accountId) {
            
            // if type change, reset status.
            resetDetailStatus()
            
            try! RealmManager.share.realm.write {
                self.detailModel.userId = UserInfo.share.selectedUserId
                self.detailModel.billingType = self.billingType.rawValue
                self.detailModel.accountId = accountId
                self.detailModel.accountName = accountName
                self.detailModel.detailGroup = detailGroupId
                self.detailModel.detailType = detailTypeId
                self.detailModel.amount = amount
                self.detailModel.memo = memo
                self.detailModel.date = date
                self.detailModel.modifyDateTime = date
                
                if self.billingType != .transfer {
                    self.detailModel.toAccountId = ObjectId.generate()
                    self.detailModel.toAccountName = ""
                }
            }
            
            if self.billingType == .transfer {
                
                if let toAccountId = try? ObjectId(string: transferToAccountId) {
                    try! RealmManager.share.realm.write {
                        self.detailModel.toAccountId = toAccountId
                        self.detailModel.toAccountName = transferToAccountName
                    }
                    
                    RealmManager.share.updateAccountMoney(billingType: self.billingType, amount: amount, accountId: accountId, toAccountId: toAccountId)
                } else {
                    return
                }
                
            } else {
                RealmManager.share.updateAccountMoney(billingType: self.billingType, amount: amount, accountId: accountId)
            }
            
        }
    }
    
    private func resetDetailStatus() {
        if let billingType = BillingType(rawValue: self.detailModel.billingType) {
            // expenses -> other
            if billingType == .expenses {
                RealmManager.share.updateAccountMoney(billingType: .income, amount: self.detailModel.amount, accountId: self.detailModel.accountId)
            }
            
            // income -> other
            if billingType == .income {
                RealmManager.share.updateAccountMoney(billingType: .expenses, amount: self.detailModel.amount, accountId: self.detailModel.accountId)
            }
            
            // transfer -> other
            if billingType == .transfer {
                RealmManager.share.updateAccountMoney(billingType: .transfer, amount: self.detailModel.amount, accountId: self.detailModel.toAccountId, toAccountId: self.detailModel.accountId)
            }
        }
    }
    
    func deleteDetail() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.resetDetailStatus()
            RealmManager.share.deleteDetail(self.detailModel.id)
        }
    }
    
    func getCommonMemos() {
        if needRefershMemo {
            commonMemos = RealmManager.share.getCommonMemos(UserInfo.share.selectedUserId, billingType: billingType.rawValue, groupId: detailGroupId, memo: memo)
        }
    }
}
