//
//  DetailViewModel.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/25.
//

import Foundation
import RealmSwift

class DetailViewModel: ObservableObject {
    
    private var currentDate = Date() {
        didSet {
            currentDateString = currentDate.string(withFormat: "yyyy-MM-dd(EE)")
        }
    }
        
    @Published var detailModels: [DetailModel] = [] {
        didSet {
            countTotal()
        }
    }
    @Published var currentDateString = Date().string(withFormat: "yyyy-MM-dd(EE)")
    @Published var totalAmount: Int = 0
    
}

extension DetailViewModel {
    func toNextDate() {
        currentDate = currentDate.adding(.day, value: 1)
        getDetail()
    }
    
    func toPreviousDate() {
        currentDate = currentDate.adding(.day, value: -1)
        getDetail()
    }
    
    func toCurrentDate() {
        currentDate = Date()
        getDetail()
    }
    
    func countTotal() {
        let total = detailModels.filter{ $0.billingType != 2 }.map{ $0.billingType == 0 ? -($0.amount) : $0.amount}.sum()
        
        if total > Int64.max || total < Int64.min {
            return
        }
        totalAmount = total
    }
}

// MARK: DB Method
extension DetailViewModel {
    func getDetail() {
        detailModels = RealmManager.share.readDetail(currentDate.string(withFormat: "yyyy-MM-dd"), userID: UserInfo.share.selectedUserId)
        
        let addCell = DetailModel()
        addCell.billingType = 3
        detailModels.append(addCell)
    }
}

extension DetailViewModel {
    func detailTypeToString(detailModel: DetailModel) -> String {
        guard let billingType = BillingType(rawValue: detailModel.billingType) else { return "" }
        var typeTitle = ""
        
        if let group = detailModel.detailGroup.int, let type = detailModel.detailType.int {
            // 預設內容
            switch billingType {
            case .expenses:
                if let group = ExpensesGroup(rawValue: group) {
                    typeTitle += group.name
                    
                    switch group {
                    case .food:
                        guard let type = ExpensesFood(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .clothing:
                        guard let type = ExpensesClothing(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .life:
                        guard let type = ExpensesLife(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .traffic:
                        guard let type = ExpensesTraffic(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .educate:
                        guard let type = ExpensesEducate(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .entertainment:
                        guard let type = ExpensesEntertainment(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .electronicProduct:
                        guard let type = ExpensesElectronicProduct(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .book:
                        guard let type = ExpensesBook(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .motor:
                        guard let type = ExpensesMotor(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .medical:
                        guard let type = ExpensesMedical(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .personalCommunication:
                        guard let type = ExpensesPersonalCommunication(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .invest:
                        guard let type = ExpensesInvest(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .other:
                        guard let type = ExpensesOther(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .fee:
                        guard let type = ExpensesFee(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    }
                }
            case .income:
                if let group = IncomeGroup(rawValue: group) {
                    typeTitle += group.name
                    
                    switch group {
                    case .general:
                        guard let type = IncomeGeneral(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    case .investment:
                        guard let type = IncomeInvestment(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    }
                }
            case .transfer:
                if let group = TransferGroup(rawValue: group) {
                    typeTitle += group.name
                    
                    switch group {
                    case .transferMoney:
                        guard let type = TransferGeneral(rawValue: type) else { return typeTitle }
                        typeTitle += " - \(type.name)"
                    }
                }
            }
        } else {
            switch billingType {
            case .expenses:
                typeTitle += RealmManager.share.getExpensesGroup(detailModel.detailGroup).first?.name ?? ""
                typeTitle += " - \(RealmManager.share.getExpensesType(detailModel.detailType).first?.name ?? "")"
            case .income:
                typeTitle += RealmManager.share.getIncomeGroup(detailModel.detailGroup).first?.name ?? ""
                typeTitle += " - \(RealmManager.share.getIncomeType(detailModel.detailType).first?.name ?? "")"
            case .transfer:
                typeTitle += RealmManager.share.getTransferGroup(detailModel.detailGroup).first?.name ?? ""
                typeTitle += " - \(RealmManager.share.getTransferType(detailModel.detailType).first?.name ?? "")"
            }
        }
        
        return typeTitle
    }
}
