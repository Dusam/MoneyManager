//
//  AddButtonView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import SwiftUI

struct AddButtonView<TargetView: View>: View {
    
    var nextView: TargetView
    @EnvironmentObject var appearance: AppAppearance
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                NavigationLink(destination: nextView) {
                    ZStack {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(appearance.themeColor.isLight ? Color(uiColor: UIColor.darkGray) : .white)
                            .frame(width: 50, height: 50)
                    }
                    .background(appearance.themeColor)
                    .clipShape(Circle())
                    
                }
                .padding([.trailing, .bottom], 30)
                
            }
        }
        
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(nextView: AddUserView()).environmentObject(AppAppearance())
    }
}
