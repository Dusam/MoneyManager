//
//  AddAccountInfoView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/10.
//

import SwiftUI

struct AddAccountInfoView: View {
    @EnvironmentObject var addAccountVM: AddAccountViewModel
    
    @FocusState private var nameIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(R.string.localizable.accountName())
                .font(.system(size: 26))
                .padding([.top, .leading, .trailing], 20)
            
            TextField("", text: $addAccountVM.accountName)
                .font(.system(size: 26))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.trailing)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 1)
                        .padding(10)
                }
                .focused($nameIsFocused)
                .onTapGesture {
                    addAccountVM.isHiddenCalculator = true
                }
            
            Text(R.string.localizable.initialAmount())
                .font(.system(size: 26))
                .padding([.top, .leading, .trailing], 20)
            
            Button {
                nameIsFocused = false
                addAccountVM.isHiddenCalculator = false
            } label: {
                Text(addAccountVM.initMoney)
                    .font(.system(size: 26))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                            .padding(10)
                    }
            }
        }
        .padding(.bottom, 15)
        .background(.white)
        .cornerRadius(20)
    }
}

struct AddAccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountInfoView().environmentObject(AddAccountViewModel())
    }
}
