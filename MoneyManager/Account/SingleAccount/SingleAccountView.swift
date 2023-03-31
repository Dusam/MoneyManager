//
//  SingleAccountView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/3/30.
//

import SwiftUI

struct SingleAccountView: View {
    
    @ObservedObject var singleAccountVM = SingleAccountViewModel()
    private var accountId: String = ""
    private var accountName: String = ""
    
    init(accountId: String, accountName: String) {
        self.accountId = accountId
        self.accountName = accountName
    }
    
    var body: some View {
        VStack {
            List(singleAccountVM.singleAccounts, id: \.self) { detail in
                SingleAccountCellView(sectionHeader: detail.date,
                                      datas: Binding<[DetailModel]>(
                                        get: { detail.details },
                                        set: { _ in }
                                      ))
                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle(accountName)
        .onAppear {
            singleAccountVM.getAccountDetail(accountId: self.accountId)
        }
    }
}

struct SingleAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SingleAccountView(accountId: "", accountName: "")
    }
}
