//
//  InitialDB.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/24.
//

import Foundation
import RealmSwift


extension RealmManager {
    // MARK: 建立預設選項
    internal func setUpPresetOptions(realm: Realm, _ userId: ObjectId) {
//        self.presetAccount(realm, userId)
        self.presetExpensesGroup(realm, userId)
        self.presetIncomeGroup(realm, userId)
        self.presetTransferGroup(realm, userId)
    }
    
    private func presetAccount(_ realm: Realm, _ userId: ObjectId) {
        let accountModel = AccountModel()
        accountModel.userId = userId
        accountModel.type = 0
        accountModel.name = "現金"
        accountModel.money = 0
        accountModel.includTotal = true
        
        realm.add(accountModel)
    }
}

// MARK: 支出類型
extension RealmManager {
    private func presetExpensesGroup(_ realm: Realm, _ userId: ObjectId) {
        let expensesGroups = ExpensesGroup.allCases
        
        for expensesGroup in expensesGroups {
//            let expensesGroupModel = ExpensesGroupModel()
            let expensesGroupModel = DetailGroupModel()
            expensesGroupModel.userId = userId
            expensesGroupModel.name = expensesGroup.name
            expensesGroupModel.billType = 0
            
            realm.add(expensesGroupModel)
            
            // 根據各群組建立該群組的支出類型
            switch expensesGroup {
            case .food:
                self.presetFoodType(realm, userId, expensesGroupModel.id)
            case .clothing:
                self.presetClothingType(realm, userId, expensesGroupModel.id)
            case .life:
                self.presetLifeType(realm, userId, expensesGroupModel.id)
            case .traffic:
                self.presetTrafficType(realm, userId, expensesGroupModel.id)
            case .educate:
                self.presetEducateType(realm, userId, expensesGroupModel.id)
            case .entertainment:
                self.presetEntertainmentType(realm, userId, expensesGroupModel.id)
            case .electronicProduct:
                self.presetElectronicProductType(realm, userId, expensesGroupModel.id)
            case .book:
                self.presetBookType(realm, userId, expensesGroupModel.id)
            case .motor:
                self.presetMotorType(realm, userId, expensesGroupModel.id)
            case .medical:
                self.presetMedicalType(realm,userId, expensesGroupModel.id)
            case .personalCommunication:
                self.presetPersonalCommunicationType(realm, userId, expensesGroupModel.id)
            case .invest:
                self.presetInvestType(realm, userId, expensesGroupModel.id)
            case .other:
                self.presetOtherType(realm, userId, expensesGroupModel.id)
            case .fee:
                self.presetFeeType(realm, userId, expensesGroupModel.id)
            }
        }
    }
    
    private func presetFoodType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let foods = ExpensesFood.allCases
        
        selectedData.expensesGroupId = groupId.stringValue
        
        for food in foods {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = food.name
            
            if food.name == ExpensesFood.lunch.name {
                selectedData.expensesTypeId = model.id.stringValue
            }
            
            realm.add(model)
        }
    }
    
    private func presetClothingType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let clothings = ExpensesClothing.allCases
        
        for clothing in clothings {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = clothing.name
            
            realm.add(model)
        }
    }
    
    private func presetLifeType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let lifes = ExpensesLife.allCases
        
        for life in lifes {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = life.name
            
            realm.add(model)
        }
    }
    
    private func presetTrafficType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let traffics = ExpensesTraffic.allCases
        
        for traffic in traffics {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = traffic.name
            
            realm.add(model)
        }
    }
    
    private func presetEducateType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let educates = ExpensesEducate.allCases
        
        for educate in educates {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = educate.name
            
            realm.add(model)
        }
    }
    
    private func presetEntertainmentType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let entertainments = ExpensesEntertainment.allCases
        
        for entertainment in entertainments {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = entertainment.name
            
            realm.add(model)
        }
    }
    
    private func presetElectronicProductType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let electronicProducts = ExpensesElectronicProduct.allCases
        
        for electronicProduct in electronicProducts {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = electronicProduct.name
            
            realm.add(model)
        }
    }
    
    private func presetBookType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let books = ExpensesBook.allCases
        
        for book in books {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = book.name
            
            realm.add(model)
        }
    }
    
    private func presetMotorType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let motors = ExpensesMotor.allCases
        
        for motor in motors {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = motor.name
            
            realm.add(model)
        }
    }
    
    private func presetMedicalType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let medicals = ExpensesMedical.allCases
        
        for medical in medicals {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = medical.name
            
            realm.add(model)
        }
    }
    
    private func presetPersonalCommunicationType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let personalCommunications = ExpensesPersonalCommunication.allCases
        
        for personalCommunication in personalCommunications {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = personalCommunication.name
            
            realm.add(model)
        }
    }
    
    private func presetInvestType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let invests = ExpensesInvest.allCases
        
        for invest in invests {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = invest.name
            
            realm.add(model)
        }
    }
    
    private func presetOtherType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let others = ExpensesOther.allCases
        
        for other in others {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = other.name
            
            realm.add(model)
        }
    }
    
    private func presetFeeType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let fees = ExpensesFee.allCases
        
        for fee in fees {
//            let model = ExpensesTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = fee.name
            
            realm.add(model)
        }
    }
    
}

// MARK: 收入類型
extension RealmManager {
    private func presetIncomeGroup(_ realm: Realm, _ userId: ObjectId) {
        let incomeGroups = IncomeGroup.allCases
        
        for incomeGroup in incomeGroups {
//            let incomeGroupModel = IncomeGroupModel()
            let incomeGroupModel = DetailGroupModel()
            incomeGroupModel.userId = userId
            incomeGroupModel.name = incomeGroup.name
            incomeGroupModel.billType = 1
            
            realm.add(incomeGroupModel)
            
            // 根據各群組建立該群組的支出類型
            switch incomeGroup {
            case .general:
                self.presetGeneralType(realm, userId, incomeGroupModel.id)
            case .investment:
                self.presetInvestmentType(realm, userId, incomeGroupModel.id)
            }
        }
    }
    
    private func presetGeneralType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let generals = IncomeGeneral.allCases
        
        selectedData.incomeGroupId = groupId.stringValue
        
        for general in generals {
//            let model = IncomeTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = general.name
            
            if general.name == IncomeGeneral.other.name {
                selectedData.incomeTypeId = model.id.stringValue
            }
            
            realm.add(model)
        }
    }
    
    private func presetInvestmentType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let investments = IncomeInvestment.allCases
        
        for investment in investments {
//            let model = IncomeTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = investment.name
            
            realm.add(model)
        }
    }
}

// MARK: 轉帳類型
extension RealmManager {
    private func presetTransferGroup(_ realm: Realm, _ userId: ObjectId) {
        let transferGroups = TransferGroup.allCases
        
        for transferGroup in transferGroups {
//            let transferGroupModel = TransferGroupModel()
            let transferGroupModel = DetailGroupModel()
            transferGroupModel.userId = userId
            transferGroupModel.name = transferGroup.name
            transferGroupModel.billType = 2
            
            realm.add(transferGroupModel)
            
            // 根據各群組建立該群組的轉帳類型
            switch transferGroup {
            case .transferMoney:
                self.presetTransferType(realm, userId, transferGroupModel.id)
            }
        }
    }
    
    private func presetTransferType(_ realm: Realm, _ userId: ObjectId, _ groupId: ObjectId) {
        let generals = TransferGeneral.allCases
        
        selectedData.transferGroupId = groupId.stringValue
        
        for general in generals {
//            let model = TransferTypeModel()
            let model = DetailTypeModel()
            model.groupId = groupId.stringValue
            model.userId = userId
            model.name = general.name
            
            
            if general.name == TransferGeneral.general.name {
                selectedData.trnasferTypeId = model.id.stringValue
            }
            
            realm.add(model)
        }
        
        setPresetSelectedData()
    }
    
    
    private func setPresetSelectedData() {
        selectedData.accountId = RealmManager.share.getAccount(userId: UserInfo.share.selectedUserId).first?.id.stringValue ?? ""
        selectedData.transferToAccountId = RealmManager.share.getAccount(userId: UserInfo.share.selectedUserId).first?.id.stringValue ?? ""
        
        UserInfo.share.selectedData = selectedData
    }
}
