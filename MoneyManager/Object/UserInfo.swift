//
//  UserInfo.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/6/1.
//

import Foundation
import RealmSwift

class UserInfo {
    static let share = UserInfo()
    
    private init() {
        
    }
    
    
    var selectedUserId: ObjectId = ObjectId.generate()
}
