//
//  SingleAccountCellView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/3/30.
//

import SwiftUI

struct SectionDetailView: View {
    var title: String = ""
    @Binding var datas: [SectionDetailModel]
    
    var body: some View {
        List(datas.indices, id: \.self) { index in
            // 不是空的才增加 Section
            if !datas[index].details.isEmpty {
                Section {
                    ForEach(datas[index].details, id: \.id) { detail in
                        
                        let binding = Binding<[DetailModel]>(
                            get: { datas[index].details },
                            set: { datas[index].details = $0 }
                        )
                        DetailCellView(detail: detail, details: binding)
                            .padding([.leading, .trailing], 20)
                            .padding(.top, 10)
                    }
                    
                } header: {
                    VStack(alignment: .leading) {
                        Text(datas[index].date)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                            .foregroundColor(UserInfo.share.themeColor.isLight ? .black : .white)
                    }
                    .frame(maxWidth: .infinity)
                    .background(UserInfo.share.themeColor)
                }
                .listRowInsets(EdgeInsets())
            }
        }
        .padding(.top, -22)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .navigationBarTitle(title)
        .hideBackTitle()
    }
}

struct SingleAccountCellView_Previews: PreviewProvider {
    static var previews: some View {
        SectionDetailView(datas: .constant([]))
    }
}
