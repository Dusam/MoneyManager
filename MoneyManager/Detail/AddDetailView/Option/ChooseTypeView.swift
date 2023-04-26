//
//  ChooseTypeView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/3.
//

import SwiftUI

struct ChooseTypeView: View {
    
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @State private var selectedGroup: Any?
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                DetailGroupView()
                
                NavigationLink(destination: AddOptionView(.addGroup, addDetailVM.billingType)) {
                    Text("+")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                        .padding(.top, 1)
                        .padding(.leading, 20)
                        .background(.white)
                }
            }
            
            Divider()
            
            VStack {
                DetailTypeView()
                
                NavigationLink(destination: AddOptionView(.addType, addDetailVM.billingType, addDetailVM.detailGroupId)) {
                    Text("+")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                        .padding(.top, 1)
                        .padding(.trailing, 20)
                        .background(.white)
                }
            }
            
        }
        .environmentObject(addDetailVM)
        .navigationTitle(R.string.localizable.chooseType())
        .hideBackTitle()
    }
    
    
    @ViewBuilder
    private func getTypeList() -> some View {
//        if let selectedGroup = selectedGroup as? ExpensesGroup {
//            switch selectedGroup {
//            case .food:
//                ExpensesFoodList()
//            case .clothing:
//                ExpensesClothingList()
//            case .life:
//                ExpensesLifeList()
//            case .traffic:
//                ExpensesTrafficList()
//            case .educate:
//                ExpensesEducateList()
//            case .entertainment:
//                ExpensesEntertainmentList()
//            case .electronicProduct:
//                ExpensesElectronicProductList()
//            case .book:
//                ExpensesBookList()
//            case .motor:
//                ExpensesMotorList()
//            case .medical:
//                ExpensesMedicalList()
//            case .personalCommunication:
//                ExpensesPersonalCommunicationList()
//            case .invest:
//                ExpensesInvestList()
//            case .other:
//                ExpensesOtherList()
//            case .fee:
//                ExpensesFeeList()
//            }
//        }
//        else if let selectedGroup = selectedGroup as? IncomeGroup {
//            switch selectedGroup {
//            case .general:
//                IncomeGeneralList()
//            case .investment:
//                IncomeInvestmentList()
//            }
//        }
//        else if let selectedGroup = selectedGroup as? TransferGroup {
//            switch selectedGroup {
//            case .transferMoney:
//                TransferGeneralList()
//            }
//        }
//        else if let _ = selectedGroup as? String {
//            switch addDetailVM.billingType {
//            case .expenses:
//                CustomExpensesList(selectedGroup: $selectedGroup)
//            case .income:
//                CustomIncomeList(selectedGroup: $selectedGroup)
//            case .transfer:
//                CustomTransferList(selectedGroup: $selectedGroup)
//            }
//            DetailTypeView()
//        }

    }
    
}

struct ChooseTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseTypeView().environmentObject(AddDetailViewModel())
    }
}
