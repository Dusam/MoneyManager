//
//  ChooseTypeView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/3.
//

import SwiftUI

struct ChooseTypeView: View {
    
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @State private var selectedGroup: Any?
    
    @State private var isEditingGroup: Bool = false
    @State private var isEditingType: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                DetailGroupView(isEditing: $isEditingGroup)
                
                HStack {
                    Toggle("編輯", isOn: $isEditingGroup)
                        .toggleStyle(.button)
                        .foregroundColor(.blue)
                        .font(.system(size: 18))
                        .padding(.leading, 20)
                    
                    NavigationLink(destination: AddOptionView(.addGroup, addDetailVM.billingType)) {
                        Text("+")
                            .foregroundColor(.blue)
                            .font(.system(size: 30))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                    }
                }
            }
            
            Divider()
            
            VStack {
                DetailTypeView(isEditing: $isEditingType)
                
                HStack {
                    Toggle("編輯", isOn: $isEditingType)
                        .toggleStyle(.button)
                        .foregroundColor(.blue)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                    
                    NavigationLink(destination: AddOptionView(.addType, addDetailVM.billingType, addDetailVM.detailGroupId)) {
                        Text("+")
                            .foregroundColor(.blue)
                            .font(.system(size: 30))
                            .padding(.trailing, 20)
                            .background(.white)
                    }
                }
            }
            
        }
        .environmentObject(addDetailVM)
        .navigationTitle(R.string.localizable.chooseType())
        .onAppear {
            addDetailVM.getDetailGroup()
            addDetailVM.getDetailType()
        }
    }
}

#Preview {
    ChooseTypeView().environmentObject(AddDetailViewModel(addDetailType: .add, detail: DetailModel()))
}
