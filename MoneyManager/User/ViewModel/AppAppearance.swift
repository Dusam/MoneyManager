//
//  AppAppearance.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/4/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
class AppAppearance: ObservableObject {
    var colorScheme: ColorScheme = UserInfo.share.themeColor.isLight ? .light : .dark
    var themeColor: Color = UserInfo.share.themeColor
}
