//
//  SwiftUIViewExtension.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/9.
//

import Foundation
import SwiftUI
import Introspect
import UIKit


// MARK: View
extension View {
    func setNavigationBar(_ color: Color = UserInfo.share.themeColor) -> some View {
        self
            .introspectNavigationController(customize: { navigation in
                var titleColor:UIColor = .white
                
                if color.isLight {
                    titleColor = .darkGray
                }

                navigation.navigationBar.topItem?.backButtonDisplayMode = .minimal
                
                let navBarAppearance = UINavigationBarAppearance()
                let backImage = UIImage(systemName: "chevron.backward.circle.fill")?.withTintColor(color.isLight ? .darkGray : .white, renderingMode: .alwaysOriginal)
                navBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
                
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
                navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor]
                navBarAppearance.backgroundColor = UIColor(color)
                
                let buttonAppearance = UIBarButtonItemAppearance()
                buttonAppearance.normal.titleTextAttributes = [.foregroundColor: titleColor]
                 
                navBarAppearance.buttonAppearance = buttonAppearance
                navBarAppearance.backButtonAppearance = buttonAppearance
                navBarAppearance.doneButtonAppearance = buttonAppearance
                
                navigation.navigationBar.standardAppearance = navBarAppearance
                navigation.navigationBar.scrollEdgeAppearance = navBarAppearance
                navigation.navigationBar.compactAppearance = navBarAppearance
                
                navigation.overrideUserInterfaceStyle = .light
                
                // segment control
                setSegmentColor()
            })
    }
    
    func setSegmentColor(isShowColorPicker: Bool = false) {
        let segmentAppearance = UISegmentedControl.appearance()
        if isShowColorPicker {
            segmentAppearance.backgroundColor = .white
            segmentAppearance.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            segmentAppearance.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        } else {
            segmentAppearance.backgroundColor = UserInfo.share.themeColor.uiColor
            segmentAppearance.setTitleTextAttributes([.foregroundColor: UserInfo.share.themeColor.isLight ? UIColor.black : UserInfo.share.themeColor.uiColor], for: .selected)
            segmentAppearance.setTitleTextAttributes([.foregroundColor: UserInfo.share.themeColor.isLight ? UIColor.darkGray : UIColor.white], for: .normal)
        }
    }
    
    func hideBackTitle() -> some View {
        self
            .introspectNavigationController(customize: { navigation in
                navigation.navigationBar.topItem?.backButtonDisplayMode = .minimal
            })
    }
}

// MARK: Color
extension Color {
    var isLight: Bool {
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        UIColor(self).getWhite(&brightness, alpha: &alpha)
        
        return brightness > 0.6 ? true : false
    }
    
    var uiColor: UIColor {
        return UIColor(self)
    }
}

// MARK: Binding
extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
