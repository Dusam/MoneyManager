//
//  SingleAccountCellView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/3/30.
//

import SwiftUI

struct SingleAccountCellView: View {
    
    var sectionHeader: String = ""
    @Binding var datas: [DetailModel]
    
    var body: some View {
        Section {
            ForEach(datas, id: \.self) { detail in
                DetailCellView(detail: detail, details: $datas)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
            }
        } header: {
            VStack(alignment: .leading) {
                Text(sectionHeader)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
            }
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .lightGray))
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct SingleAccountCellView_Previews: PreviewProvider {
    static var previews: some View {
        SingleAccountCellView(datas: .constant([]))
    }
}
