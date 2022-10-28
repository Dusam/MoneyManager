//
//  AddDetailViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import Foundation
import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "÷"
    case ok = "OK"
    case clear = "AC"
    case del = "DEL"
    case decimal = "."
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .ok:
            return .orange
        case .del:
            return .red
        case .clear:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
    
    var operation: Operation {
        switch self {
        case .add:
            return .add
        case .subtract:
            return .subtract
        case .multiply:
            return .multiply
        case .divide:
            return .divide
        default:
            return .none
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

class AddDetailViewModel: ObservableObject {
    private var currentDate = Date() {
        didSet {
            currentDateString = currentDate.string(withFormat: "yyyy-MM-dd(EE)")
        }
    }
        
    @Published var currentDateString = Date().string(withFormat: "yyyy-MM-dd(EE)")
    
    // 計算機參數
    @Published var isHiddenCalculator = false
    @Published var valueString = "0"
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
