//
//  DBTools.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/3/30.
//

import Foundation
import RealmSwift

class DBTools {
    static func detailTypeToString(detailModel: DetailModel) -> String {
        guard let billingType = BillingType(rawValue: detailModel.billingType) else { return "" }
        var typeTitle = ""
        
        typeTitle += RealmManager.share.getDetailGroup(billType: billingType, groupId: detailModel.detailGroup).first?.name ?? ""
        typeTitle += " - \(RealmManager.share.getDetailType(typeId: detailModel.detailType).first?.name ?? "")"
        
        return typeTitle
    }
    
    static func detailTypeToString(billingType: BillingType, detailGroupId: String, detailTypeId: String) -> String {
        var typeTitle = ""
        
        typeTitle += RealmManager.share.getDetailGroup(billType: billingType, groupId: detailGroupId).first?.name ?? ""
        typeTitle += " - \(RealmManager.share.getDetailType(typeId: detailTypeId).first?.name ?? "")"
        
        return typeTitle
    }
    
    static func detachedObjects<T: Object>(_ results: Results<T>) -> [T] {
        return results.map { original in
            let copy = T()
            for property in original.objectSchema.properties {
                copy.setValue(original.value(forKey: property.name), forKey: property.name)
            }
            return copy
        }
    }
}
