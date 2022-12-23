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
    
    let ud = UserDefaults.standard
    @objc dynamic var selectedDate: Date = Date()
    
    private init() {
        
    }
    
    
    var selectedUserId: ObjectId = ObjectId.generate()
    
    var expensesGroupId: String {
        set {
            ud.set(newValue, forKey: "expensesGroupId")
        }
        get {
            return ud.string(forKey: "expensesGroupId") ?? "0"
        }
    }
    
    var expensesTypeId: String {
        set {
            ud.set(newValue, forKey: "expensesTypeId")
        }
        get {
            return ud.string(forKey: "expensesTypeId") ?? "0"
        }
    }
    
    var incomeGroupId: String {
        set {
            ud.set(newValue, forKey: "incomeGroupId")
        }
        get {
            return ud.string(forKey: "incomeGroupId") ?? "0"
        }
    }
    
    var incomeTypeId: String {
        set {
            ud.set(newValue, forKey: "incomeTypeId")
        }
        get {
            return ud.string(forKey: "incomeTypeId") ?? "0"
        }
    }
    
    var transferGroupId: String {
        set {
            ud.set(newValue, forKey: "transferGroupId")
        }
        get {
            return ud.string(forKey: "transferGroupId") ?? "0"
        }
    }
    
    var trnasferTypeId: String {
        set {
            ud.set(newValue, forKey: "trnasferTypeId")
        }
        get {
            return ud.string(forKey: "trnasferTypeId") ?? "0"
        }
    }
    
    var accountId: String {
        set {
            ud.set(newValue, forKey: "accountId")
        }
        get {
            if let id = ud.string(forKey: "accountId") {
                return id
            } else if let dbId = RealmManager.share.getAccount(userId: UserInfo.share.selectedUserId).first?.id.stringValue {
                return dbId
            } else {
                return ""
            }
        }
    }
    
    var transferToAccountId: String {
        set {
            ud.set(newValue, forKey: "transferToAccountId")
        }
        get {
            if let id = ud.string(forKey: "transferToAccountId") {
                return id
            } else if let dbId = RealmManager.share.getAccount(userId: UserInfo.share.selectedUserId).first?.id.stringValue {
                return dbId
            } else {
                return ""
            }
        }
    }
}
