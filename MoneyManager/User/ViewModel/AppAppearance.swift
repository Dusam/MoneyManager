//
//  AppAppearance.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/4/26.
//

import Foundation
import SwiftUI

class AppAppearance: ObservableObject {
    @Published var colorScheme: ColorScheme = UserInfo.share.themeColor.isLight ? .light : .dark
    @Published var themeColor: Color = UserInfo.share.themeColor
}
