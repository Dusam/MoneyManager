//
//  SingleAccountView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/3/30.
//

import SwiftUI

struct SingleAccountView: View {
    
    @StateObject var singleAccountVM = SingleAccountViewModel()
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
                totalLabel(title: R.string.localizable.income(),
                           value: singleAccountVM.incomeTotal,
                           color: .green)
                totalLabel(title: R.string.localizable.spend(),
                           value: singleAccountVM.spendTotal,
                           color: .red)
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

extension SingleAccountView {
    private func totalLabel(title: String, value: Int, color: Color) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text("$\(value)")
                .foregroundColor(color)
        }
        .font(.system(.title3))
        .padding(.bottom, 10)
    }
}

#Preview {
    SingleAccountView(accountId: "", accountName: "")
}
