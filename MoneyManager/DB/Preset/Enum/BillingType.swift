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
            return "支出"
        case .income:
            return "收入"
        case .transfer:
            return "轉帳"
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
