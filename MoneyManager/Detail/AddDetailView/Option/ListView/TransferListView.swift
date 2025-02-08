//
//  TransferListView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/2.
//

import SwiftUI

struct TransferListView: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    
    var body: some View {
        List {
            chooseAccountView().listRowPaddingAndSeparatorHidden()
            chooseTransferAccountView().listRowPaddingAndSeparatorHidden()
            transferFeeView().listRowPaddingAndSeparatorHidden()
            chooseTypeView().listRowPaddingAndSeparatorHidden()
            memoView().listRowPaddingAndSeparatorHidden()
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        
    }
}

extension TransferListView {
    private func chooseAccountView() -> some View {
        NavigationLink(destination: ChooseAccountView().environmentObject(addDetailVM))   {
            navigationLinkLabel(title: R.string.localizable.from_title(),
                                value: addDetailVM.accountName)
        }
    }
    
    private func chooseTransferAccountView() -> some View {
        NavigationLink(destination:
                        ChooseAccountView(mode: .transfer).environmentObject(addDetailVM))   {
            navigationLinkLabel(title: R.string.localizable.to_title(),
                                value: addDetailVM.transferToAccountName)
        }
    }
    
    private func transferFeeView() -> some View {
        Button {
            addDetailVM.isHiddenCalculator = false
            addDetailVM.isEditingTransferFee = true
        } label: {
            navigationLinkLabel(title: R.string.localizable.handlingfee_title(),
                                value: addDetailVM.transferFee)
        }
    }
    
    private func chooseTypeView() -> some View {
        NavigationLink(destination: ChooseTypeView().environmentObject(addDetailVM))   {
            navigationLinkLabel(title: R.string.localizable.type_title(),
                                value: addDetailVM.typeName)
        }
    }
    
    private func memoView() -> some View {
        NavigationLink(destination: MemoView().environmentObject(addDetailVM))   {
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
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 15)
        }
    }
}

#Preview {
    TransferListView().environmentObject(AddDetailViewModel(addDetailType: .add, detail: DetailModel()))
}
