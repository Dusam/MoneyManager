//
//  MoneyManagerApp.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import SwiftUI
import SwifterSwift
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager

@main
struct MoneyManagerApp: App {
    @StateObject var appearance = AppAppearance()

    
    init() {
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
        IQKeyboardManager.shared.keyboardDistance = 150
        
        IQKeyboardToolbarManager.shared.isEnabled = true
        
        if UserDefaults.isFirstLaunch() {
            // TODO: 新增預設選項
        }
    }
    
    var body: some Scene {
        WindowGroup {
            UserListView()
                .environmentObject(appearance)
        }
    }
}
