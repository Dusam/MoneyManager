//
//  BillingType.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import Foundation
import SwiftUI

enum BillingType: Int, CaseIterable {
    case expenses = 0
    case income
    case transfer
    
    var name: String {
        switch self {
        case .expenses:
            return R.string.localizable.spend()
        case .income:
            return R.string.localizable.income()
        case .transfer:
            return R.string.localizable.transfer()
        }
    }
    
    var forgroundColor: Color {
        switch self {
        case .expenses:
            return Color(uiColor: R.color.expensesColor()!)
        case .income:
            return Color(uiColor: R.color.incomeColor()!)
        case .transfer:
            return Color(uiColor: R.color.transferColor()!)
        }
    }
}
