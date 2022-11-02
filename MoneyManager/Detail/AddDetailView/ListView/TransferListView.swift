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
            NavigationLink(destination: Text("轉出帳戶"))   {
                HStack {
                    Text("從:")
                        .font(.system(size: 18))
                    Text(addDetailVM.accountName)
                        .font(.system(size: 18))
                        .foregroundColor(addDetailVM.billingTypeSelection.forgroundColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.bottom, 10)
            .listRowSeparator(.hidden)
            
            NavigationLink(destination: Text("轉入帳戶"))   {
                HStack {
                    Text("到:")
                        .font(.system(size: 18))
                    Text(addDetailVM.transferToAccountName)
                        .font(.system(size: 18))
                        .foregroundColor(addDetailVM.billingTypeSelection.forgroundColor)
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
                    Text("手續費:")
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
            
            NavigationLink(destination: Text("轉帳類型"))   {
                HStack {
                    Text("類別:")
                        .font(.system(size: 18))
                    Text(addDetailVM.typeName)
                        .font(.system(size: 18))
                        .foregroundColor(addDetailVM.billingTypeSelection.forgroundColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.bottom, 10)
            .listRowSeparator(.hidden)
            
            NavigationLink(destination: Text("備註"))   {
                HStack {
                    Text("備註:")
                        .font(.system(size: 18))
                    Text(addDetailVM.memo)
                        .font(.system(size: 18))
                        .foregroundColor(addDetailVM.billingTypeSelection.forgroundColor)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .padding(.bottom, 10)
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
}

struct TransferListView_Previews: PreviewProvider {
    static var previews: some View {
        TransferListView().environmentObject(AddDetailViewModel())
    }
}
