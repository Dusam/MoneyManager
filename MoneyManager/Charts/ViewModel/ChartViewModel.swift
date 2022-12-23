//
//  ChartViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/12/20.
//

import Foundation
import Charts

class ChartViewModel: ObservableObject {
    
    struct ChartListData: Hashable {
        var billingType: BillingType
        var datas: [DetailModel]
        var total: Int
        var percent: Double
    }
    
    @Published var chartDatas: [PieChartDataEntry] = [PieChartDataEntry(value: 20, label: "收入"),
                                                 PieChartDataEntry(value: 70, label: "支出"),
                                                 PieChartDataEntry(value: 10, label: "轉帳")]
    @Published var listDatas: [ChartListData] = []
    
    @Published var chartType: ChartType = .month {
        didSet {
            getDatas()
            setDateString()
        }
    }
    // +8 小時以符合台灣時區
    private var currentDate: Date = Date().adding(.hour, value: 8) {
        didSet {
            setDateString()
        }
    }
    
    @Published var currentDateString = Date().string(withFormat: "yyyy-MM")
    
    private var startDate = Date()
    private var endDate = Date()
    
    // 數據參數
    @Published var total: Int = 0
    @Published var incomeTotal: Int = 0
    @Published var expensesTotal: Int = 0
    @Published var transferTotal: Int = 0
    
    @Published var incomePercent: Double = 0
    @Published var expensesPercent: Double = 0
    @Published var transferPercent: Double = 0
    
    
    init() {
        getDatas()
    }
    
    func test1() {
        chartDatas = [PieChartDataEntry(value: 20, label: "收入"),
                 PieChartDataEntry(value: 70, label: "支出"),
                 PieChartDataEntry(value: 10, label: "轉帳")]
    }

    func test2() {
        chartDatas = [PieChartDataEntry(value: 10, label: "收入"),
                 PieChartDataEntry(value: 60, label: "支出"),
                 PieChartDataEntry(value: 30, label: "轉帳")]
    }
    
    func test3() {
        chartDatas = [PieChartDataEntry(value: 1, label: "")]
    }
    
    func setDateString() {
        switch chartType {
        case .week:
            currentDateString = currentDate.string(withFormat: "yyyy") + "(\(currentDate.weekOfYear))"
        case .month:
            currentDateString = currentDate.string(withFormat: "yyyy-MM")
        case .year:
            currentDateString = currentDate.string(withFormat: "yyyy")
        }
    }
    
    func getDatas() {
        countDate()
        
        let data = RealmManager.share.searchDeatilWithDateRange(self.startDate, self.endDate)
        
        let totalAmount = data.reduce(0) { partialResult, model in
            partialResult + abs(model.amount)
        }
        
        let incomeDatas = data.filter {BillingType(rawValue: $0.billingType) == .income}
        let expensesDatas = data.filter {BillingType(rawValue: $0.billingType) == .expenses}
        let transferDatas = data.filter {BillingType(rawValue: $0.billingType) == .transfer}
        
        incomeTotal = incomeDatas.reduce(0) { partialResult, model in
            partialResult + abs(model.amount)
        }
        
        expensesTotal = expensesDatas.reduce(0) { partialResult, model in
            partialResult + abs(model.amount)
        }
        
        transferTotal = transferDatas.reduce(0) { partialResult, model in
            partialResult + abs(model.amount)
        }
        
        total = incomeTotal - expensesTotal
        incomePercent = String(format: "%.2f", (incomeTotal.double / totalAmount.double) * 100).double() ?? 0.0
        expensesPercent = String(format: "%.2f", (expensesTotal.double / totalAmount.double) * 100).double() ?? 0.0
        transferPercent = String(format: "%.2f", (transferTotal.double / totalAmount.double) * 100).double() ?? 0.0
        
        listDatas = [ChartListData(billingType: .income, datas: incomeDatas, total: incomeTotal, percent: incomePercent),
                     ChartListData(billingType: .expenses, datas: expensesDatas, total: expensesTotal, percent: expensesPercent),
                     ChartListData(billingType: .transfer, datas: transferDatas, total: transferTotal, percent: transferPercent)]
        
        if incomePercent > 0 || expensesPercent > 0 || transferPercent > 0 {
            chartDatas = [PieChartDataEntry(value: incomePercent, label: "\(incomePercent)%"),
                     PieChartDataEntry(value: expensesPercent, label: "\(expensesPercent)%"),
                     PieChartDataEntry(value: transferPercent, label: "\(transferPercent)%")]
        } else {
            chartDatas = [PieChartDataEntry(value: 1, label: "")]
        }
        
    }
}

// MARK: 切換月份
extension ChartViewModel {
    func toNext() {
        switch chartType {
        case .week:
            currentDate = currentDate.adding(.weekOfMonth, value: 1)
        case .month:
            currentDate = currentDate.adding(.month, value: 1)
        case .year:
            currentDate = currentDate.adding(.year, value: 1)
        }
        
        getDatas()
    }
    
    func toPrevious() {
        switch chartType {
        case .week:
            currentDate = currentDate.adding(.weekOfMonth, value: -1)
        case .month:
            currentDate = currentDate.adding(.month, value: -1)
        case .year:
            currentDate = currentDate.adding(.year, value: -1)
        }
        
        getDatas()
    }
    
    func toCurrentDate() {
        currentDate = Date()
        
        getDatas()
    }
    
    func countDate() {
        var type: Calendar.Component = .month
        
        switch chartType {
        case .week:
            type = .weekOfMonth
        case .month:
            type = .month
        case .year:
            type = .year
        }
        
        if let startDate = currentDate.beginning(of: type)?.adding(.hour, value: 8),
           let endDate = currentDate.end(of: type)?.adding(.hour, value: 8) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }
   
}

