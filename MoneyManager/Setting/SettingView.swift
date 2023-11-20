//
//  SettingView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/6.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            NavigationLink(destination: ChangeThemeView()) {
                Text("主題顏色")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
            Divider()
        }
        .navigationTitle(R.string.localizable.setting())
        .hideBackTitle()
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
