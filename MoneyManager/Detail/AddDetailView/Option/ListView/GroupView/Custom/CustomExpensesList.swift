//
//  CustomExpensesList.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/7.
//

import SwiftUI

struct CustomExpensesList: View {
    @Binding var selectedGroup: Any?

    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @Environment(\.dismiss) var dismiss    
    
    var body: some View {
        List(RealmManager.share.getExpensesType(selectedGroup as! String),
             id: \.self) { model in
            Button {
                addDetailVM.detailTypeId = model.id.stringValue
                dismiss()
            } label: {
                Text(model.name)
                    .font(.system(size: 22))
                    .padding([.top, .bottom], 20)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(
                        VStack {
                            Divider().offset(x: 0, y: 29)
                        }
                    )
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct CustomExpensesList_Previews: PreviewProvider {
    static var previews: some View {
        CustomExpensesList(selectedGroup: .constant(""))
    }
}
