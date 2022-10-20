//
//  UserViewModel.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import Foundation
import RealmSwift
import UIKit

class UserViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []

    @Published var userName: String = ""
    @Published var searchText: String = "" {
        didSet {
            getUsers()
        }
    }
}

// MARK: DB Method
extension UserViewModel {
    func addUser() {
        RealmManager.share.createUser(userName)
    }
    
    func getUsers() {
        users = RealmManager.share.readUsers(searchText)
    }
    
    func removeUser(_ deleteUserModel: UserModel) {
        users.removeAll(deleteUserModel)

        // Realm 的刪除要慢一點，先將物件從陣列移除，才不會閃退
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            RealmManager.share.deleteDetail(deleteUserModel.id)
            RealmManager.share.deleteUser(deleteUserModel)
        }
    }
}
