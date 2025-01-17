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
    
    private(set) var realm: Realm!
    
    internal var selectedData = SelectedData()
        
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
//                if oldSchemaVersion < 3 {
//                    migration.renameProperty(onType: DetailModel.className(), from: "accountType", to: "accountId")
//                    migration.renameProperty(onType: DetailModel.className(), from: "toAccountType", to: "toAccountId")
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
    
    func saveData(_ data: Object, update: Bool = false) {
        if let realm = realm {
            realm.beginWrite()
            
            if update, let memoModel = data as? MemoModel {
                memoModel.count += 1
            }
            
            realm.add(data, update: .modified)
            try! realm.commitWrite()
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
            
            UserInfo.share.selectedUserId = user.id
            
            self.setUpPresetOptions(realm: realm, user.id)
            
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
            
            let delete = realm.objects(DetailModel.self).filter("userId == %@", deleteUser.id)
            let group = realm.objects(DetailGroupModel.self).filter("userId == %@", deleteUser.id)
            let type = realm.objects(DetailTypeModel.self).filter("userId == %@", deleteUser.id)
            let account = realm.objects(AccountModel.self).filter("userId == %@", deleteUser.id)
            
            UserInfo.share.removeInfo(userId: deleteUser.id.stringValue)
            realm.delete(delete)
            realm.delete(group)
            realm.delete(type)
            realm.delete(account)
            realm.delete(deleteUser)

            try! realm.commitWrite()
        }
    }
}

// MARK: Detail Method
extension RealmManager {
    func readDetail(_ date: String, userID: ObjectId) -> [DetailModel] {
        if let realm = realm {
            let results = realm.objects(DetailModel.self).filter("date == %@ AND userId == %@", date, userID)
            return Array(DBTools.detachedObjects(results))
        }
        return []
    }
    
    func deleteDetail(_ id: ObjectId) {
        if let realm = realm {
            let delete = realm.objects(DetailModel.self).filter("id == %@", id)
            
            realm.beginWrite()
            realm.delete(delete)
            try! realm.commitWrite()
        }
    }
    
    func searchDeatilWithDateRange(_ startDate: Date, _ endDate: Date) -> [DetailModel] {
        if let realm = realm {
            let datas = Array(realm.objects(DetailModel.self)
                .where {
                    $0.userId == UserInfo.share.selectedUserId
                })
            
            return datas.filter {
                if let date = $0.date.date(withFormat: "yyyy-MM-dd"), date.isBetween(startDate, endDate) {
                    return true
                }
                return false
            }
        }
                              
        return []
    }
    
    func getCommonMemos(_ userId: ObjectId, billingType: Int, groupId: String, memo: String) -> [MemoModel] {
        if memo.isEmpty {
            return Array(realm.objects(MemoModel.self)
                .filter("userId == %@ AND billingType == %@ AND detailGroup == %@", userId, billingType, groupId))
                .sorted{ $0.count > $1.count}
        } else {
            return Array(realm.objects(MemoModel.self)
                .filter("userId == %@ AND billingType == %@ AND detailGroup == %@", userId, billingType, groupId))
                .filter {$0.memo.contains(memo)}
                .sorted{ $0.count > $1.count}
        }
        
    }
}

// MARK: Account Method
extension RealmManager {
    func updateAccountMoney(billingType: BillingType, amount: Int, accountId: ObjectId, toAccountId: ObjectId = ObjectId()) {
                
        switch billingType {
        case .expenses:
            let account = realm.objects(AccountModel.self).where {
                $0.id == accountId
            }.first
            
            try! realm.write {
                account?.money -= amount
            }
            
            
        case .income:
            let account = realm.objects(AccountModel.self).where {
                $0.id == accountId
            }.first
            
            try! realm.write {
                account?.money += amount
            }
            
        case .transfer:
            let account = realm.objects(AccountModel.self).where {
                $0.id == accountId
            }.first
            
            let toAccount = realm.objects(AccountModel.self).where {
                $0.id == toAccountId
            }.first
            
            try! realm.write {
                account?.money -= amount
                toAccount?.money += amount
            }
        }
    }
}

// MARK: 使用者自訂的帳戶、群組及類型
extension RealmManager {
    func getAccount(_ id: String = "", userId: ObjectId) -> [AccountModel] {
        if let realm = realm {
            
            if id.isEmpty {
                return Array(realm.objects(AccountModel.self).filter("userId == %@", userId))
            } else if let id = try? ObjectId(string: id) {
                return Array(realm.objects(AccountModel.self).filter("id == %@ AND userId == %@", id, userId))
            }
        }
        return []
    }
    
    func getDetailGroup(billType: BillingType, groupId: String = "") -> [DetailGroupModel] {
        if let realm = realm {
            
            if groupId.isEmpty {
                return Array(realm.objects(DetailGroupModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.billType == billType.rawValue
                }
            } else if let id = try? ObjectId(string: groupId) {
                return Array(realm.objects(DetailGroupModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.id == id && $0.billType == billType.rawValue
                }
            }
            
        }
        
        return []
    }
    
    func getDetailType(_ groupId: String = "", typeId: String = "") -> [DetailTypeModel] {
        if let realm = realm {
            
            if !groupId.isEmpty {
                return Array(realm.objects(DetailTypeModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.groupId == groupId
                }
            } else if typeId.isEmpty {
                return Array(realm.objects(DetailTypeModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId
                }
            } else {
                return Array(realm.objects(DetailTypeModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.id.stringValue == typeId
                }
            }
            
        }
        
        return []
    }
    
    func getExpensesGroup(_ groupId: String = "") -> [ExpensesGroupModel] {
        if let realm = realm {
            
            if groupId.isEmpty {
                return Array(realm.objects(ExpensesGroupModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId
                }
            } else if let id = try? ObjectId(string: groupId) {
                return Array(realm.objects(ExpensesGroupModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.id == id
                }
            }
            
        }
        return []
    }
    
    func getExpensesType(_ groupId: String = "") -> [ExpensesTypeModel] {
        if let realm = realm {
            
            if groupId.isEmpty {
                return Array(realm.objects(ExpensesTypeModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId
                }
            } else {
                return Array(realm.objects(ExpensesTypeModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.expensesGroup == groupId
                }
            }
            
        }
        return []
    }
    
    func getIncomeGroup(_ groupId: String = "") -> [IncomeGroupModel] {
        if let realm = realm {
            
            if groupId.isEmpty {
                return Array(realm.objects(IncomeGroupModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId
                }
            } else if let id = try? ObjectId(string: groupId) {
                return Array(realm.objects(IncomeGroupModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.id == id
                }
            }
            
        }
        return []
    }
    
    func getIncomeType(_ groupId: String = "") -> [IncomeTypeModel] {
        if let realm = realm {
            
            if groupId.isEmpty {
                return Array(realm.objects(IncomeTypeModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId
                }
            } else {
                return Array(realm.objects(IncomeTypeModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.incomeGroup == groupId
                }
            }
            
        }
        return []
    }
    
    func getTransferGroup(_ groupId: String = "") -> [TransferGroupModel] {
        if let realm = realm {
            
            if groupId.isEmpty {
                return Array(realm.objects(TransferGroupModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId
                }
            } else if let id = try? ObjectId(string: groupId) {
                return Array(realm.objects(TransferGroupModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.id == id
                }
            }
            
        }
        return []
    }
    
    func getTransferType(_ groupId: String = "") -> [TransferTypeModel] {
        if let realm = realm {
            
            if groupId.isEmpty {
                return Array(realm.objects(TransferTypeModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId
                }
            } else {
                return Array(realm.objects(TransferTypeModel.self)).filter {
                    $0.userId == UserInfo.share.selectedUserId && $0.transferGroup == groupId
                }
            }
            
        }
        return []
    }
    
    func deleteGroup(_ groupId: String) {
        if let realm = realm {
            let delete = realm.objects(DetailGroupModel.self).filter {
                $0.id.stringValue == groupId
            }
            
            let deleteTypes = realm.objects(DetailTypeModel.self).filter{
                $0.groupId == groupId
            }
            
            let deleteDetails = realm.objects(DetailModel.self).filter{
                $0.detailGroup == groupId
            }
            
            realm.beginWrite()
            realm.delete(delete)
            realm.delete(deleteTypes)
            realm.delete(deleteDetails)
            try! realm.commitWrite()
        }
    }
    
    func deleteType(_ groupId: String, typeId: String) {
        if let realm = realm {
            let delete = realm.objects(DetailTypeModel.self).filter{
                $0.groupId == groupId && $0.id.stringValue == typeId
            }
            
            let deleteDetails = realm.objects(DetailModel.self).filter{
                $0.detailGroup == groupId && $0.detailType == typeId
            }
            
            realm.beginWrite()
            realm.delete(delete)
            realm.delete(deleteDetails)
            try! realm.commitWrite()
        }
    }
}
