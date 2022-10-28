//
//  DetailViewModel.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/25.
//

import Foundation
import RealmSwift

class DetailViewModel: ObservableObject {
    
    private var currentDate = Date() {
        didSet {
            currentDateString = currentDate.string(withFormat: "yyyy-MM-dd(EE)")
        }
    }
        
    @Published var detailModels: [DetailModel] = [] {
        didSet {
            countTotal()
        }
    }
    @Published var currentDateString = Date().string(withFormat: "yyyy-MM-dd(EE)")
    @Published var totalAmount: Int = 0
    
}

extension DetailViewModel {
    func toNextDate() {
        currentDate = currentDate.adding(.day, value: 1)
        getDetail()
    }
    
    func toPreviousDate() {
        currentDate = currentDate.adding(.day, value: -1)
        getDetail()
    }
    
    func toCurrentDate() {
        currentDate = Date()
        getDetail()
    }
    
    func countTotal() {
        let total = detailModels.filter{ $0.billingType != 2 }.map{ $0.billingType == 0 ? -($0.amount) : $0.amount}.sum()
        
        if total > Int64.max || total < Int64.min {
            return
        }
        totalAmount = total
    }
}

// MARK: DB Method
extension DetailViewModel {
    func createDetail(_ detailModel: DetailModel) {
        // 因新增與更新共用 method
        // 修改原有 Realm 物件須先宣告開始寫入
        RealmManager.share.realm?.beginWrite()
        
        
        RealmManager.share.createDetail(detailModel)
    }
    
    func getDetail() {
        detailModels = RealmManager.share.readDetail(currentDateString, userID: UserInfo.share.selectedUserId)
        
        let addCell = DetailModel()
        addCell.billingType = 3
        detailModels.append(addCell)
    }
}
