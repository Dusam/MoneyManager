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
            SingleAccountListHeaderView()
                .padding(20)
            
            VStack {
                HStack {
                    Text(R.string.localizable.income())
                    Spacer()
                    Text("$\(singleAccountVM.incomeTotal)")
                        .foregroundColor(.green)
                }
                .font(.system(.title3))
                .padding(.bottom, 10)
                HStack {
                    Text(R.string.localizable.spend())
                    Spacer()
                    Text("$\(singleAccountVM.spendTotal)")
                        .foregroundColor(.red)
                }
                .font(.system(.title3))
            }
            .padding([.leading, .trailing, .bottom], 20)
            
            SectionDetailView(title: accountName,
                              datas: $singleAccountVM.singleAccounts)
        }
        .environmentObject(singleAccountVM)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                singleAccountVM.setAccountId(accountId: self.accountId)
            }
        }
    }
}

struct SingleAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SingleAccountView(accountId: "", accountName: "")
    }
}
