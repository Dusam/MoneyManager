//
//  AccountType.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/24.
//

import Foundation

enum AccountType: Int, CaseIterable {
    case money = 0
    case card
    case bank
    
    var typeInt: Int {
        switch self {
        case .money:
            return 0
        case .card:
            return 1
        case .bank:
            return 2
        }
    }
    
    var typeName: String {
        switch self {
        case .money:
            return "現金"
        case .card:
            return "信用卡"
        case .bank:
            return "銀行"
        }
    }
}
