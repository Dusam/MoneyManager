//
//  ChangeThemeView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/4/25.
//

import SwiftUI

struct ChangeThemeView: View {
    @EnvironmentObject var appearance: AppAppearance
    
    var body: some View {
        VStack {
            HStack {
                Text("選擇主題顏色")
                    .font(.system(size: 20))
                Spacer()
                ColorPicker("", selection: $appearance.themeColor)
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    .scaleEffect(CGSize(width: 1.3, height: 1.3))
                    
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("主題顏色")
        .onChange(of: appearance.themeColor, perform: { newValue in
            UserInfo.share.themeColor = newValue
            
            let searchBarAppearance = UISearchBar.appearance()
            searchBarAppearance.overrideUserInterfaceStyle = newValue.isLight ? .light : .dark
            searchBarAppearance.tintColor = newValue.isLight ? .black : .white
            
            appearance.themeColor = newValue
            appearance.colorScheme = newValue.isLight ? .light : .dark
        })
        .onAppear {
            setSegmentColor(isShowColorPicker: true)
        }
        .onDisappear {
            setSegmentColor(isShowColorPicker: false)
        }
        .hideBackTitle()
    }
}

struct ChangeThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeThemeView()
    }
}
