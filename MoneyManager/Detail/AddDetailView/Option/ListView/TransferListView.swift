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
            NavigationLink(destination: ChooseAccountView().environmentObject(addDetailVM))   {
                HStack {
                    Text(R.string.localizable.from_title())
                        .font(.system(size: 18))
                    Text(addDetailVM.accountName)
                        .font(.system(size: 18))
                        .foregroundColor(addDetailVM.billingType.forgroundColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.bottom, 10)
            .listRowSeparator(.hidden)
            
            NavigationLink(destination:
                            ChooseAccountView(mode: .transfer).environmentObject(addDetailVM))   {
                HStack {
                    Text(R.string.localizable.to_title())
                        .font(.system(size: 18))
                    Text(addDetailVM.transferToAccountName)
                        .font(.system(size: 18))
                        .foregroundColor(addDetailVM.billingType.forgroundColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.bottom, 10)
            .listRowSeparator(.hidden)
            
            Button {
                addDetailVM.isHiddenCalculator = false
                addDetailVM.isEditingTransferFee = true
            } label: {
                HStack {
                    Text(R.string.localizable.handlingfee_title())
                        .font(.system(size: 18))
                    Text(addDetailVM.transferFee)
                        .font(.system(size: 18))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 15)
                }
            }
            .padding(.bottom, 10)
            .listRowSeparator(.hidden)
            
            NavigationLink(destination: ChooseTypeView().environmentObject(addDetailVM))   {
                HStack {
                    Text(R.string.localizable.type_title())
                        .font(.system(size: 18))
                    Text(addDetailVM.typeName)
                        .font(.system(size: 18))
                        .foregroundColor(addDetailVM.billingType.forgroundColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.bottom, 10)
            .listRowSeparator(.hidden)
            
            NavigationLink(destination: MemoView().environmentObject(addDetailVM))   {
                HStack {
                    Text(R.string.localizable.memo_title())
                        .font(.system(size: 18))
                    Text(addDetailVM.memo.replacing("\n", with: " "))
                        .font(.system(size: 18))
                        .foregroundColor(addDetailVM.billingType.forgroundColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.bottom, 10)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

struct TransferListView_Previews: PreviewProvider {
    static var previews: some View {
        TransferListView().environmentObject(AddDetailViewModel())
    }
}
