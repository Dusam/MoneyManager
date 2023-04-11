//
//  SingleAccountViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/3/30.
//

import Foundation
import SwiftUI
import RealmSwift

struct SectionDetailModel: Hashable {
    var date: String = ""
    var details: [DetailModel] = []
}


class SingleAccountViewModel: ObservableObject {
 
    @Published var singleAccounts: [SectionDetailModel] = []
    
    private var currentDate: Date = Date().adding(.hour, value: 8) {
        didSet {
            setDateString()
        }
    }
    
    @Published var currentDateString = Date().string(withFormat: "yyyy-MM")
    
    @Published var incomeTotal: Int = 0
    @Published var spendTotal: Int = 0
    @Published var totalAmount: Int = 0
    
    private var startDate = Date()
    private var endDate = Date()
    private var accountId: String = ""
    
    init() {
        setDateString()
    }
    
    func setAccountId(accountId: String) {
        self.accountId = accountId
        getAccountDetail(accountId: accountId)
    }
    
}

extension SingleAccountViewModel {
    func toNextDate() {
        currentDate = currentDate.adding(.month, value: 1).adding(.hour, value: 8)
        getAccountDetail(accountId: accountId)
    }
    
    func toPreviousDate() {
        currentDate = currentDate.adding(.month, value: -1).adding(.hour, value: 8)
        getAccountDetail(accountId: accountId)
    }
    
    func toCurrentDate() {
        currentDate = Date()
        getAccountDetail(accountId: accountId)
    }
    
    private func setDateString() {
        if let startDate = currentDate.beginning(of: .month),
           let endDate = currentDate.end(of: .month) {
            self.startDate = startDate
            self.endDate = endDate
        }
        
        let start = startDate.string(withFormat: "yyyy-MM-dd")
        let end = endDate.string(withFormat: "yyyy-MM-dd")
        currentDateString = "\(start) ~ \(end)"
    }
    
    private func getAccountDetail(accountId: String) {
        singleAccounts.removeAll()
        
        var data = RealmManager.share.searchDeatilWithDateRange(startDate, endDate).filter {
            $0.accountId.stringValue == accountId || $0.toAccountId.stringValue == accountId
        }
        
        var date = ""
        var dateDetails: [DetailModel] = []
        
        data.reverse()
        data.forEach { detail in
            if date != detail.date {
                if !date.isEmpty {
                    singleAccounts.append(SectionDetailModel(date: date, details: dateDetails))
                }
                dateDetails.removeAll()
                date = detail.date
            }
            dateDetails.append(detail)
            
            if let last = data.last, last == detail {
                singleAccounts.append(SectionDetailModel(date: date, details: dateDetails))
            }
        }
        
        calculateAmount(data: data)
    }
    
    private func calculateAmount(data: [DetailModel]) {
        let filterData = data.filter{ $0.billingType != 2 }
        let transferData = data.filter{ $0.billingType == 2 }

        let incomeFilter = transferData.filter{ $0.toAccountId.stringValue == accountId }.map{ $0.amount }.sum()
        incomeTotal = filterData.map{ $0.billingType == 1 ? $0.amount : 0 }.sum() + incomeFilter
        
        let spendFilter = transferData.filter{ $0.accountId.stringValue == accountId }.map{ -($0.amount) }.sum()
        spendTotal = filterData.map{ $0.billingType == 0 ? -($0.amount) : 0 }.sum() + spendFilter
        
        totalAmount = incomeTotal + spendTotal
    }
}
