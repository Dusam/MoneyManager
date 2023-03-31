//
//  SingleAccountViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/3/30.
//

import Foundation
import SwiftUI

struct SingleAccountModel: Hashable {
    var date: String = ""
    var details: [DetailModel] = []
}


class SingleAccountViewModel: ObservableObject {
 
    @Published var singleAccounts: [SingleAccountModel] = []
    
    private var currentDate: Date = Date().adding(.hour, value: 8) {
        didSet {
            setDateString()
        }
    }
    
    @Published var currentDateString = Date().string(withFormat: "yyyy-MM")
    
    private var startDate = Date()
    private var endDate = Date()
    
    func getAccountDetail(accountId: String) {
        singleAccounts.removeAll(
        )
        if let startDate = Date().beginning(of: .month)?.adding(.hour, value: 8),
           let endDate = Date().end(of: .month)?.adding(.hour, value: 8) {
            self.startDate = startDate
            self.endDate = endDate
        }
        
        var data = RealmManager.share.searchDeatilWithDateRange(startDate, endDate).filter {
            $0.accountId.stringValue == accountId
        }
        
        var date = ""
        var dateDetails: [DetailModel] = []
        
        data.reverse()
        data.forEach { detail in
            if date != detail.date {
                if !date.isEmpty {
                    singleAccounts.append(SingleAccountModel(date: date, details: dateDetails))
                }
                dateDetails.removeAll()
                date = detail.date
            }
            dateDetails.append(detail)
            
            if let last = data.last, last == detail {
                singleAccounts.append(SingleAccountModel(date: date, details: dateDetails))
            }
        }
        
    }
    
    private func setDateString() {
        let start = startDate.string(withFormat: "yyyy-MM-dd")
        let end = endDate.string(withFormat: "yyyy-MM-dd")
        currentDateString = "\(start) ~ \(end)"
    }
}
