//
//  ChartType.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/12/20.
//

import Foundation

enum ChartType: Int, CaseIterable {
    case week = 0
    case month
    case year
    
    var name: String {
        switch self {
        case .week:
            return R.string.localizable.week()
        case .month:
            return R.string.localizable.month()
        case .year:
            return R.string.localizable.year()
        }
    }
    
    var calendarType: Calendar.Component {
        switch self {
        case .week:
            return .weekOfMonth
        case .month:
            return .month
        case .year:
            return .year
        }
    }
}
