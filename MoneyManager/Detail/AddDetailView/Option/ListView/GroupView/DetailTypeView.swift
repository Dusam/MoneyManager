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
    
    var body: some View {
        ScrollView {
            ForEach(addDetailVM.detailTypeModels, id: \.self) { type in
                Button {
                    addDetailVM.detailTypeId = type.id.stringValue
                    dismiss()
                } label: {
                    Text(type.name)
                        .foregroundColor(.black)
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
}

struct DetailTypeView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTypeView().environmentObject(AddDetailViewModel())
    }
}
