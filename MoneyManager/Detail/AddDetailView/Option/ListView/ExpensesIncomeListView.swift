//
//  ExpensesListView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/1.
//

import SwiftUI

struct ExpensesIncomeListView: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    
    var body: some View {
        List {
            chooseTypeView().listRowPaddingAndSeparatorHidden()
            chooseAccountView().listRowPaddingAndSeparatorHidden()
            memoView().listRowPaddingAndSeparatorHidden()
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

extension ExpensesIncomeListView {
    private func chooseTypeView() -> some View {
        NavigationLink(destination: ChooseTypeView().environmentObject(addDetailVM))   {
            navigationLinkLabel(title: R.string.localizable.type_title(),
                                value: addDetailVM.typeName)
        }
    }
    
    private func chooseAccountView() -> some View {
        NavigationLink(destination: ChooseAccountView().environmentObject(addDetailVM))   {
            navigationLinkLabel(title: R.string.localizable.account_title(),
                                value: addDetailVM.accountName)
        }
    }
    
    private func memoView() -> some View {
        NavigationLink(destination: MemoView().environmentObject(addDetailVM)) {
            navigationLinkLabel(title: R.string.localizable.memo_title(),
                                        value: addDetailVM.memo.replacing("\n", with: " "))
        }
    }
    
    @ViewBuilder
    private func navigationLinkLabel(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 18))
            Text(value)
                .font(.system(size: 18))
                .foregroundColor(addDetailVM.billingType.forgroundColor)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    ExpensesIncomeListView().environmentObject(AddDetailViewModel(addDetailType: .add, detail: DetailModel()))
}
