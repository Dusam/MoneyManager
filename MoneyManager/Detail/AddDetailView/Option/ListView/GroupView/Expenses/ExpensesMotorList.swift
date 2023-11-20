//
//  ExpensesMotorList.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/3.
//

import SwiftUI

struct ExpensesMotorList: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List(ExpensesMotor.allCases, id: \.self) { type in
            Button {
                addDetailVM.detailTypeId = type.rawValue.string
                dismiss()
            } label: {
                Text(type.name)
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

struct ExpensesMotorList_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesMotorList()
    }
}
