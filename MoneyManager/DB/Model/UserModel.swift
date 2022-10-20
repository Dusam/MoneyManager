//
//  UserModel.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import Foundation
import RealmSwift


class UserModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id = ObjectId.generate()
    @Persisted var name: String = ""
}
