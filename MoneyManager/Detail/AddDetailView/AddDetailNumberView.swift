//
//  AddDetailNumberView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/31.
//

import SwiftUI

struct AddDetailNumberView: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    
    var body: some View {
        HStack {
            Text("TW$")
                .font(.system(size: 32))
                .foregroundColor(.blue)
                .padding(.leading, 5)
            
            Text(addDetailVM.valueString)
                .font(.system(size: 36))
                .foregroundColor(addDetailVM.billingTypeSelection.forgroundColor)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 5)
                .overlay(
                    VStack {
                        Divider().offset(x: 0, y: 15)
                    }
                )
        }
        .frame(height: UIScreen.main.bounds.height * 0.07)
        .padding([.top, .leading, .trailing], 20)
        .contentShape(Rectangle())
        .onTapGesture {
            addDetailVM.isHiddenCalculator = false
            addDetailVM.isEditingTransferFee = false
        }
    }
}

struct AddDetailNumberView_Previews: PreviewProvider {
    static var previews: some View {
        AddDetailNumberView().environmentObject(AddDetailViewModel())
    }
}
