//
//  AddDetailViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import Foundation

class AddDetailViewModel: ObservableObject {
    private var currentDate = Date() {
        didSet {
            currentDateString = currentDate.string(withFormat: "yyyy-MM-dd(EE)")
        }
    }
        
    @Published var currentDateString = Date().string(withFormat: "yyyy-MM-dd(EE)")
    
    // 計算機參數
    @Published var isHiddenCalculator = false
//    @Published var runningNumber = 0.0
    @Published var valueString = "0"
//    @Published var currentOperation: Operation = .none
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
