//
//  AddDetailView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import SwiftUI

struct AddDetailView: View {
    
    @ObservedObject var addDetailVM = AddDetailViewModel()
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        
        VStack {
            AddDetailNumberView()
            AddDetailHeaderView()
                .padding([.top, .bottom], 10)
            
            ZStack(alignment: .bottom) {
                switch addDetailVM.billingType {
                case .expenses, .income:
                    ExpensesIncomeListView()
                case .transfer:
                    TransferListView()
                }
                
                Button {
                    addDetailVM.createDetail()
                    dismiss()
                } label: {
                    VStack {
                        Image(systemName: "checkmark.circle")
                        Text("儲存")
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                }
                
                CalculatorView()
                    .offset(y: addDetailVM.isHiddenCalculator ? 500 : 0)
                    .animation(.easeOut(duration: 0.3), value: addDetailVM.isHiddenCalculator)
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $addDetailVM.billingType) {
                    ForEach(BillingType.allCases, id: \.self) { type in
                        Text(type.name)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("    ")
                    .font(.system(.body))
            }

        }
        .hideBackButtonTitle()
        .environmentObject(addDetailVM)
        .onAppear {
            switch addDetailVM.billingType {
            case .expenses:
                addDetailVM.detailGroupId = UserInfo.share.expensesGroupId
                addDetailVM.detailTypeId = UserInfo.share.expensesTypeId
            case .income:
                addDetailVM.detailGroupId = UserInfo.share.incomeGroupId
                addDetailVM.detailTypeId = UserInfo.share.incomeTypeId
            case .transfer:
                addDetailVM.detailGroupId = UserInfo.share.transferGroupId
                addDetailVM.detailTypeId = UserInfo.share.trnasferTypeId
            }
        }
    }
}

struct AddDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddDetailView()
    }
}
