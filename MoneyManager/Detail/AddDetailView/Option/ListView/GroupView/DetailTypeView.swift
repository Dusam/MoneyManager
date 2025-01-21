//
//  DetailTypeView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/9.
//

import SwiftUI

struct DetailTypeView: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding var isEditing: Bool
    
    var body: some View {
        ScrollView {
            ForEach(addDetailVM.detailTypeModels, id: \.id) { type in
                HStack {
                    // 刪除按鈕，根據 isEditing 決定是否顯示
                    if isEditing {
                        Button(action: {
                            addDetailVM.deleteType(typeId: type.id.stringValue)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                        .scaleEffect(0.7)
                    }
                    
                    Button {
                        addDetailVM.detailTypeId = type.id.stringValue
                        dismiss()
                    } label: {
                        Text(type.name)
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(15)
                    }
                }
                .overlay(
                    VStack {
                        Divider().offset(x: 0, y: 29)
                    }
                )
            }
        }
        .animation(.default, value: isEditing)
    }
}

#Preview {
    DetailTypeView(isEditing: .constant(false))
        .environmentObject(AddDetailViewModel(addDetailType: .add, detail: DetailModel()))
}
