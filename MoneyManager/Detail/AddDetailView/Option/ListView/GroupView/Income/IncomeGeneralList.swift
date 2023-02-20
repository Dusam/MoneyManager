//
//  IncomeGeneralList.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/4.
//

import SwiftUI

struct IncomeGeneralList: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List(IncomeGeneral.allCases, id: \.self) { type in
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

struct IncomeGeneralList_Previews: PreviewProvider {
    static var previews: some View {
        IncomeGeneralList()
    }
}