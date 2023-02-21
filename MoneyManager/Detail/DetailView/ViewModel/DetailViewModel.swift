//
//  DetailViewModel.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/25.
//

import Foundation
import RealmSwift

class DetailViewModel: ObservableObject {
    
    private var currentDate = UserInfo.share.selectedDate {
        didSet {
            UserInfo.share.selectedDate = currentDate
            currentDateString = currentDate.string(withFormat: "yyyy-MM-dd(EE)")
        }
    }
        
    @Published var detailModels: [DetailModel] = [] {
        didSet {
            countTotal()
        }
    }
    @Published var currentDateString = UserInfo.share.selectedDate.string(withFormat: "yyyy-MM-dd(EE)")
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
    func getDetail() {
        detailModels = RealmManager.share.readDetail(currentDate.string(withFormat: "yyyy-MM-dd"), userID: UserInfo.share.selectedUserId)
        
        let addCell = DetailModel()
        addCell.billingType = 3
        detailModels.append(addCell)
    }
}

extension DetailViewModel {
    func detailTypeToString(detailModel: DetailModel) -> String {
        guard let billingType = BillingType(rawValue: detailModel.billingType) else { return "" }
        var typeTitle = ""
        
        typeTitle += RealmManager.share.getDetailGroup(billType: billingType, groupId: detailModel.detailGroup).first?.name ?? ""
        typeTitle += " - \(RealmManager.share.getDetailType(typeId: detailModel.detailType).first?.name ?? "")"
        
        return typeTitle
    }
}
