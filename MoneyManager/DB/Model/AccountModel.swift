//
//  AccountModel.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/24.
//

import Foundation
import RealmSwift

class AccountModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = ObjectId.generate()
    @Persisted var userId: ObjectId
    @Persisted var type: Int = 0
    @Persisted var name: String = ""
    @Persisted var includTotal: Bool = false
    @Persisted var initMoney: Int = 0
    @Persisted var money: Int = 0
}
