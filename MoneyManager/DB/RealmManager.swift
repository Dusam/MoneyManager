//
//  RealmMigration.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import Foundation
import RealmSwift



class RealmManager {
    static let share = RealmManager()
    
    private(set) var realm: Realm?
        
    private init() {
        openRealm()
    }
    
    func openRealm() {
        do {
            // Setting the schema version
            var config = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in
//                練習範例
//                if oldSchemaVersion < 8 {
//                    migration.enumerateObjects(ofType: "RLM_Account") { oldObject, newObject in
//                        newObject?["enable"] = true
//                    }
//                }
//
//                if oldSchemaVersion < 10 {
//                    migration.enumerateObjects(ofType: "RLM_Account") { oldObject, newObject in
//                        newObject?["disable2"] = true
//                    }
//                }
//
//                if oldSchemaVersion < 11 {
//                    migration.renameProperty(onType: RLM_Account.className(), from: "disable", to: "disable3")
//                }
                
            }
            
            config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("MoneyManager.realm")
            
            #if DEBUG
            print("realm url: \(config.fileURL!.path)")
            #endif
            
            Realm.Configuration.defaultConfiguration = config
            
            realm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
}

// MARK: User Method
extension RealmManager {
    func createUser(_ userName: String) {
        if let realm = realm {
            let user = UserModel()
            user.name = userName
            
            realm.beginWrite()
            realm.add(user)
            
            try! realm.commitWrite()
        }
    }
    
    func readUsers(_ searchText: String = "") -> [UserModel] {
        if let realm = realm {
            var results: Results<UserModel>
            
            if searchText.isEmpty {
                results = realm.objects(UserModel.self)
            } else {
                results = realm.objects(UserModel.self).filter("name CONTAINS '\(searchText)'")
            }
            return Array(results)
        }
        return []
    }
    
    func deleteUser(_ deleteUser: UserModel) {
        if let realm = realm {
            realm.beginWrite()
            realm.delete(deleteUser)
            try! realm.commitWrite()
        }
    }
}

// MARK: Detail Method
extension RealmManager {
    func createDetail(_ detailModel: DetailModel) {
        if let realm = realm {
            realm.add(detailModel, update: .modified)
            try! realm.commitWrite()
        }
    }
    
    func readDetail(_ date: String, userID: ObjectId) -> [DetailModel] {
        if let realm = realm {
            return Array(realm.objects(DetailModel.self).filter("date == %@ AND userId == %@", date, userID))
//            return Array(realm.objects(DetailModel.self).filter("date == '\(date)'").filter("userId == %@", userID))
        }
        return []
    }
    
    func deleteDetail(_ userId: ObjectId) {
        if let realm = realm {
            let delete = realm.objects(DetailModel.self).filter("userId == %@", userId)
            
            realm.beginWrite()
            realm.delete(delete)
            try! realm.commitWrite()
        }
    }
}
