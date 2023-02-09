//
//  SwiftUIViewExtension.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/9.
//

import Foundation
import SwiftUI
import Introspect

extension View {
    func hideBackButtonTitle() -> some View {
        self
            .introspectNavigationController(customize: { navigation in
                navigation.navigationBar.topItem?.backButtonDisplayMode = .minimal
            })
    }
}
