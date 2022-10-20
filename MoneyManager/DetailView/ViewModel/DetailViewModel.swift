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
            currentDateString = currentDate.string(withFormat: "yyyy-MM-dd")
        }
    }
        
    private var detailModel: DetailModel = DetailModel() {
        didSet {
            breakfastAmount = detailModel.breakfastAmount
            lunchAmount = detailModel.lunchAmount
            dinnerAmount = detailModel.dinnerAmount
            otherAmount = detailModel.otherAmount
        }
    }

    @Published var currentDateString = Date().string(withFormat: "yyyy-MM-dd")

    @Published var breakfastAmount: Int = 0 {
        didSet {
            countTotal()
        }
    }
    @Published var lunchAmount: Int = 0 {
        didSet {
            countTotal()
        }
    }
    @Published var dinnerAmount: Int = 0 {
        didSet {
            countTotal()
        }
    }
    @Published var otherAmount: Int = 0 {
        didSet {
            countTotal()
        }
    }
    
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
        let total = (-breakfastAmount) + (-lunchAmount) + (-dinnerAmount) + (-otherAmount)
        
        if total > Int64.max || total < Int64.min {
            return
        }
        totalAmount = total
    }
}

// MARK: DB Method
extension DetailViewModel {
    func createDetail(_ userId: ObjectId) {
        // 因新增與更新共用 method
        // 修改原有 Realm 物件須先宣告開始寫入
        RealmManager.share.realm?.beginWrite()
        
        detailModel.userId = userId
        detailModel.date = currentDateString
        detailModel.modifyDateTime = Date().string(withFormat: "yyyy-MM-dd HH:mm:ss")
        
        detailModel.breakfastAmount = breakfastAmount
        detailModel.lunchAmount = lunchAmount
        detailModel.dinnerAmount = dinnerAmount
        detailModel.otherAmount = otherAmount
        
        RealmManager.share.createDetail(detailModel)
    }
    
    func getDetail() {
        detailModel = RealmManager.share.readDetail(currentDateString, userID: UserInfo.share.selectedUserId).first ?? DetailModel()
    }
}
