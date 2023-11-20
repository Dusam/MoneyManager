//
//  AddDetailHeaderView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import SwiftUI

struct AddDetailHeaderView: View {
    
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                addDetailVM.toPreviousDate()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .font(.system(.title2))
            }

            Spacer()
            Button {
                addDetailVM.toCurrentDate()
            } label: {
                VStack {
                    Text(addDetailVM.currentDateString)
                        .font(.system(.title2))
                        .foregroundColor(.gray)
                }
                
            }
            
            Spacer()
            Button {
                addDetailVM.toNextDate()
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundColor(.gray)
                    .font(.system(.title2))
            }
            Spacer()
        }
    }
}

struct AddDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AddDetailHeaderView().environmentObject(AddDetailViewModel())
    }
}
