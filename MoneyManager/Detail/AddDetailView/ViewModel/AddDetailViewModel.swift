//
//  AddDetailViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import Foundation
import SwiftUI
import RealmSwift

class AddDetailViewModel: ObservableObject {
    
    init() {
        detailTypeToString()
        getAccountName()
        
        detailGroupId = UserInfo.share.expensesGroupId
        detailTypeId = UserInfo.share.expensesTypeId
        
        accountId = UserInfo.share.accountId
        transferToAccountId = UserInfo.share.transferToAccountId
    }
    
    private var currentDate = Date() {
        didSet {
            currentDateString = currentDate.string(withFormat: "yyyy-MM-dd(EE)")
        }
    }
        
    @Published var currentDateString = Date().string(withFormat: "yyyy-MM-dd(EE)")
    @Published var billingTypeSelection: BillingType = .expenses {
        didSet {
            switch billingTypeSelection {
            case .expenses:
                detailGroupId = UserInfo.share.expensesGroupId
                detailTypeId = UserInfo.share.expensesTypeId
            case .income:
                detailGroupId = UserInfo.share.incomeGroupId
                detailTypeId = UserInfo.share.incomeTypeId
            case .transfer:
                detailGroupId = UserInfo.share.transferGroupId
                detailTypeId = UserInfo.share.trnasferTypeId
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
    @Published var detailGroupId: String = "0" {
        didSet {
            detailTypeToString()
        }
    }
    @Published var detailTypeId: String = "0" {
        didSet {
            detailTypeToString()
            storeSelectedType()
        }
    }
    
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
    @Published var memo: String = ""
    @Published var commonMemos: [MemoModel] = []
    
    private var detailModel: DetailModel = DetailModel()
    
    private func storeSelectedType() {
        switch billingTypeSelection {
        case .expenses:
            UserInfo.share.expensesGroupId = detailGroupId
            UserInfo.share.expensesTypeId = detailTypeId
        case .income:
            UserInfo.share.incomeGroupId = detailGroupId
            UserInfo.share.incomeTypeId = detailTypeId
        case .transfer:
            UserInfo.share.transferGroupId = detailGroupId
            UserInfo.share.trnasferTypeId = detailTypeId
        }
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
}

// 選項字串
extension AddDetailViewModel {
    func getAccountName() {
        if accountId.isEmpty {
            accountName = RealmManager.share.getAccount(userId: UserInfo.share.selectedUserId).first?.name ?? ""
        } else {
            accountName = RealmManager.share.getAccount(accountId, userId: UserInfo.share.selectedUserId).first?.name ?? ""
        }
        
        if transferToAccountId.isEmpty {
            transferToAccountName = RealmManager.share.getAccount(userId: UserInfo.share.selectedUserId).first?.name ?? ""
        } else {
            transferToAccountName = RealmManager.share.getAccount(transferToAccountId, userId: UserInfo.share.selectedUserId).first?.name ?? ""
        }
    }
    
    private func detailTypeToString() {
        typeName = ""
        
        if let group = detailGroupId.int, let type = detailTypeId.int {
            // 預設內容
            switch billingTypeSelection {
            case .expenses:
                if let group = ExpensesGroup(rawValue: group) {
                    typeName += group.name
                    
                    switch group {
                    case .food:
                        guard let type = ExpensesFood(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .clothing:
                        guard let type = ExpensesClothing(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .life:
                        guard let type = ExpensesLife(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .traffic:
                        guard let type = ExpensesTraffic(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .educate:
                        guard let type = ExpensesEducate(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .entertainment:
                        guard let type = ExpensesEntertainment(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .electronicProduct:
                        guard let type = ExpensesElectronicProduct(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .book:
                        guard let type = ExpensesBook(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .motor:
                        guard let type = ExpensesMotor(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .medical:
                        guard let type = ExpensesMedical(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .personalCommunication:
                        guard let type = ExpensesPersonalCommunication(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .invest:
                        guard let type = ExpensesInvest(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .other:
                        guard let type = ExpensesOther(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .fee:
                        guard let type = ExpensesFee(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    }
                }
            case .income:
                if let group = IncomeGroup(rawValue: group) {
                    typeName += group.name
                    
                    switch group {
                    case .general:
                        guard let type = IncomeGeneral(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    case .investment:
                        guard let type = IncomeInvestment(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    }
                }
            case .transfer:
                if let group = TransferGroup(rawValue: group) {
                    typeName += group.name
                    
                    switch group {
                    case .transferMoney:
                        guard let type = TransferGeneral(rawValue: type) else { return }
                        typeName += " - \(type.name)"
                    }
                }
            }
            
        } else {
            switch billingTypeSelection {
            case .expenses:
                typeName += RealmManager.share.getExpensesGroup(detailGroupId).first?.name ?? ""
                typeName += " - \(RealmManager.share.getExpensesType(detailTypeId).first?.name ?? "")"
            case .income:
                typeName += RealmManager.share.getIncomeGroup(detailGroupId).first?.name ?? ""
                typeName += " - \(RealmManager.share.getIncomeType(detailTypeId).first?.name ?? "")"
            case .transfer:
                typeName += RealmManager.share.getTransferGroup(detailGroupId).first?.name ?? ""
                typeName += " - \(RealmManager.share.getTransferType(detailTypeId).first?.name ?? "")"
            }
        }
    }
}

// MARK: DB Method
extension AddDetailViewModel {
    func createDetail() {
        let date = Date().string(withFormat: "yyyy-MM-dd")
        
        // 金額大於0才儲存
        if let amount = valueString.int, amount > 0 {
            self.detailModel = DetailModel()
            self.detailModel.userId = UserInfo.share.selectedUserId
            self.detailModel.billingType = self.billingTypeSelection.rawValue
            self.detailModel.accountType = try! ObjectId(string: accountId)
            self.detailModel.accountName = accountName
            self.detailModel.detailGroup = detailGroupId
            self.detailModel.detailType = detailTypeId
            self.detailModel.amount = amount
            self.detailModel.memo = memo
            self.detailModel.date = date
            self.detailModel.modifyDateTime = date
            
            if self.billingTypeSelection == .transfer {
                self.detailModel.toAccountType = try! ObjectId(string: transferToAccountId)
                self.detailModel.toAccountName = transferToAccountName
            }
        }
        
        RealmManager.share.saveDetail(self.detailModel)
        
        // 手續費金額大於0才儲存
        if let transferFee = transferFee.int, transferFee > 0 {
            // 儲存手續費
            let transferFeeModel = DetailModel()
            transferFeeModel.userId = UserInfo.share.selectedUserId
            transferFeeModel.billingType = self.billingTypeSelection.rawValue
            transferFeeModel.accountType = try! ObjectId(string: accountId)
            transferFeeModel.accountName = accountName
            transferFeeModel.detailGroup = ExpensesGroup.fee.rawValue.string
            transferFeeModel.detailType = ExpensesFee.transfer.name
            transferFeeModel.amount = transferFee
            transferFeeModel.memo = "轉帳手續費"
            transferFeeModel.date = date
            transferFeeModel.modifyDateTime = date
        }
        
        // 新增 Memo
        if !memo.isEmpty {
            getCommonMemos()
            if commonMemos.count > 0, let model = commonMemos.first {
                // 更新次數
                model.count += 1
                RealmManager.share.saveCommonMemo(memoModel: model)
            } else {
                let model = MemoModel()
                model.userId = UserInfo.share.selectedUserId
                model.detailGroup = detailGroupId
                model.detailType = detailTypeId
                model.memo = memo
                model.count = 1
                RealmManager.share.saveCommonMemo(memoModel: model)
            }
           
        }
    }
    
    func getCommonMemos() {
        commonMemos = RealmManager.share.getCommonMemos(UserInfo.share.selectedUserId, groupId: detailGroupId, typeId: detailTypeId, memo: memo)
    }
}
