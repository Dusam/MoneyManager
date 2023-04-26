//
//  ChangeThemeView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/4/25.
//

import SwiftUI

struct ChangeThemeView: View {
    @EnvironmentObject var appearance: AppAppearance
    @State private var themeColor = UserInfo.share.themeColor
    
    var body: some View {
        VStack {
            HStack {
                Text("選擇主題顏色")
                    .font(.system(size: 20))
                Spacer()
                ColorPicker("", selection: $themeColor)
                    .labelsHidden()
                    .scaleEffect(CGSize(width: 1.3, height: 1.3))
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("主題顏色")
        .onChange(of: themeColor, perform: { newValue in
            UserInfo.share.themeColor = newValue
            
            appearance.themeColor = newValue
            appearance.colorScheme = newValue.isLight ? .light : .dark
        })
        .hideBackTitle()
    }
}

struct ChangeThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeThemeView()
    }
}
