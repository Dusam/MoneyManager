//
//  DetailTools.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/12/23.
//

import Foundation

class DetailTools {
    static func detailTypeToString(billingType: Int, detailGroup: String, detailType: String) -> String {
        guard let billingType = BillingType(rawValue: billingType) else { return "" }
        var typeTitle = ""
        
        if let group = detailGroup.int, let type = detailType.int {
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
                typeTitle += RealmManager.share.getExpensesGroup(detailGroup).first?.name ?? ""
                typeTitle += " - \(RealmManager.share.getExpensesType(detailType).first?.name ?? "")"
            case .income:
                typeTitle += RealmManager.share.getIncomeGroup(detailGroup).first?.name ?? ""
                typeTitle += " - \(RealmManager.share.getIncomeType(detailType).first?.name ?? "")"
            case .transfer:
                typeTitle += RealmManager.share.getTransferGroup(detailGroup).first?.name ?? ""
                typeTitle += " - \(RealmManager.share.getTransferType(detailType).first?.name ?? "")"
            }
        }
        
        return typeTitle
    }
}
