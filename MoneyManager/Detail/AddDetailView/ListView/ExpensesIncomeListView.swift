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
            NavigationLink(destination: addDetailVM.billingTypeSelection == .expenses ? Text("支出") : Text("收入"))   {
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
            
            NavigationLink(destination: Text("帳戶"))   {
                HStack {
                    Text("帳戶:")
                        .font(.system(size: 18))
                    Text(addDetailVM.accountName)
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

struct ExpensesIncomeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesIncomeListView().environmentObject(AddDetailViewModel())
    }
}
