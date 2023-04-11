//
//  MoneyManagerApp.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import SwiftUI
import SwifterSwift
import IQKeyboardManagerSwift

@main
struct MoneyManagerApp: App {
    
    init() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 150
        
        if UserDefaults.isFirstLaunch() {
            // TODO: 新增預設選項
        }
    }
    
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
}
