//
//  AddOptionView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/8.
//

import SwiftUI

struct AddOptionView: View {
    
    var optionType: AddOptionType = .addGroup
    var billingType: BillingType = .expenses
    private var groupId: String = ""
    
    @ObservedObject private var addOptionVM: AddOptionViewModel = AddOptionViewModel()
    
    init(_ optionType: AddOptionType, _ billingType: BillingType, _ groupId: String = "") {
        self.optionType = optionType
        self.billingType = billingType
        self.groupId = groupId
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField(R.string.localizable.enterName(), text: $addOptionVM.name)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding()
                    .overlay {
                        VStack {
                            Divider()
                                .padding([.top, .leading, .trailing], 10)
                                .offset(x: 0, y: 10)
                        }
                    }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle(optionType.title)
            .onAppear {
                addOptionVM.optionType = optionType
                addOptionVM.billType = billingType
                addOptionVM.groupId = groupId
            }
        }
        
    }
}

struct AddOptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddOptionView(.addType, .expenses)
    }
}
