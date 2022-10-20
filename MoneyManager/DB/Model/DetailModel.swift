//
//  DetailModel.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/26.
//

import Foundation
import RealmSwift

enum DetailType: Int {
    case breakfast = 0
    case lunch
    case dinner
    case other
    
    var typeInt: Int {
        switch self {
        case .breakfast:
            return 0
        case .lunch:
            return 1
        case .dinner:
            return 2
        case .other:
            return 3
        }
    }
    
    var string: String {
        switch self {
        case .breakfast:
            return "早餐"
        case .lunch:
            return "午餐"
        case .dinner:
            return "晚餐"
        case .other:
            return "雜支"
        }
    }
}

class DetailModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = ObjectId.generate()
    @Persisted var userId: ObjectId
//    @Persisted var type: Int = 0 {
//        didSet {
//            if let detailType = DetailType(rawValue: type) {
//                typeName = detailType.string
//            }
//        }
//    }
//    @Persisted private var typeName: String = ""
    @Persisted var breakfastAmount: Int = 0
    @Persisted var lunchAmount: Int = 0
    @Persisted var dinnerAmount: Int = 0
    @Persisted var otherAmount: Int = 0
    @Persisted var date: String = ""
    @Persisted var modifyDateTime: String = ""
}
