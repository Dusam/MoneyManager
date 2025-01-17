//
//  AddOptionView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/8.
//

import SwiftUI

struct AddOptionView: View {
    @EnvironmentObject var appearance: AppAppearance
    @Environment(\.dismiss) var dismiss
    
    var optionType: AddOptionType = .addGroup
    var billingType: BillingType = .expenses
    private var groupId: String = ""
    
    @StateObject private var addOptionVM: AddOptionViewModel = AddOptionViewModel()
    
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addOptionVM.createGroupType()
                        dismiss()
                    } label: {
                        Text(R.string.localizable.add())
                            .foregroundColor(appearance.themeColor.isLight ? Color(uiColor: UIColor.darkGray) : .white)
                    }

                }
            }
            .onAppear {
                addOptionVM.optionType = optionType
                addOptionVM.billType = billingType
                addOptionVM.groupId = groupId
            }
        }
        
    }
}

#Preview {
    AddOptionView(.addType, .expenses)
        .environmentObject(AppAppearance())
}
