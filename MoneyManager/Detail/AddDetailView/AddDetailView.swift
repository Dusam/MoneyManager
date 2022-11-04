//
//  AddDetailView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import SwiftUI
import Introspect

struct AddDetailView: View {
    
    @ObservedObject var addDetailVM = AddDetailViewModel()
        
    var body: some View {
        
        VStack {
            AddDetailNumberView()
            AddDetailHeaderView()
                .padding([.top, .bottom], 10)
            
            ZStack {
                switch addDetailVM.billingTypeSelection {
                case .expenses, .income:
                    ExpensesIncomeListView()
                case .transfer:
                    TransferListView()
                }
                                
                CalculatorView()
                    .offset(y: addDetailVM.isHiddenCalculator ? 500 : 0)
                    .animation(.easeOut(duration: 0.3), value: addDetailVM.isHiddenCalculator)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $addDetailVM.billingTypeSelection) {
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
        .introspectNavigationController(customize: { navigation in
            navigation.navigationBar.topItem?.backButtonDisplayMode = .minimal
        })
        .environmentObject(addDetailVM)
    }
}

struct AddDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddDetailView()
    }
}
