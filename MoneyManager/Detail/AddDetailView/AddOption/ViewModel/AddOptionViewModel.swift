//
//  AddOptionViewModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/8.
//

import Foundation
import RealmSwift

enum AddOptionType {
    case addGroup
    case addType
    
    var title: String {
        switch self {
        case .addGroup:
            return "新增群組"
        case .addType:
            return "新增類型"
        }
    }
}

class AddOptionViewModel: ObservableObject {
    
    @Published var optionType: AddOptionType = .addGroup
    @Published var name: String = ""
    @Published var billType: BillingType = .expenses
    @Published var groupId: String = ""
    
    
    func createGroupType() {
        guard !name.isEmpty else { return }
        
        if optionType == .addGroup {
            
            let detailGroupModel = DetailGroupModel()
            detailGroupModel.name = name
            detailGroupModel.userId = UserInfo.share.selectedUserId
            detailGroupModel.billType = billType.rawValue
            
        } else {
            
            let detailTypeModel = DetailTypeModel()
            detailTypeModel.name = name
            detailTypeModel.userId = UserInfo.share.selectedUserId
            detailTypeModel.groupId = groupId
            
            RealmManager.share.saveData(detailTypeModel)
            
        }
    }
}
