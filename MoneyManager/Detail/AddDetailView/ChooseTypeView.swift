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
            switch addDetailVM.billingTypeSelection {
            case .expenses:
                ExpensesGroupView(selectedGroup: $selectedGroup.toUnwrapped(defaultValue: ExpensesGroup.food))
            case .income:
                IncomeGroupView(selectedGroup: $selectedGroup.toUnwrapped(defaultValue: IncomeGroup.general))
            case .transfer:
                TransferGroupView(selectedGroup: $selectedGroup.toUnwrapped(defaultValue: IncomeGroup.general))
            }
            
            Divider()
            
            getTypeList()
        }
        .environmentObject(addDetailVM)
        .onAppear {
            switch addDetailVM.billingTypeSelection {
            case .expenses:
                addDetailVM.detailGroupId = ExpensesGroup.food.rawValue.string
                selectedGroup = ExpensesGroup.food
            case .income:
                addDetailVM.detailGroupId = IncomeGroup.general.rawValue.string
                selectedGroup = IncomeGroup.general
            case .transfer:
                addDetailVM.detailGroupId = TransferGroup.transferMoney.rawValue.string
                selectedGroup = TransferGroup.transferMoney
            }
        }
    }
    
    
    @ViewBuilder
    private func getTypeList() -> some View {
        if let selectedGroup = selectedGroup as? ExpensesGroup {
            switch selectedGroup {
            case .food:
                ExpensesFoodList()
            case .clothing:
                ExpensesClothingList()
            case .life:
                ExpensesLifeList()
            case .traffic:
                ExpensesTrafficList()
            case .educate:
                ExpensesEducateList()
            case .entertainment:
                ExpensesEntertainmentList()
            case .electronicProduct:
                ExpensesElectronicProductList()
            case .book:
                ExpensesBookList()
            case .motor:
                ExpensesMotorList()
            case .medical:
                ExpensesMedicalList()
            case .personalCommunication:
                ExpensesPersonalCommunicationList()
            case .invest:
                ExpensesInvestList()
            case .other:
                ExpensesOtherList()
            case .fee:
                ExpensesFeeList()
            }
        }
        else if let selectedGroup = selectedGroup as? IncomeGroup {
            switch selectedGroup {
            case .general:
                IncomeGeneralList()
            case .investment:
                IncomeInvestmentList()
            }
        }
        else if let selectedGroup = selectedGroup as? TransferGroup {
            switch selectedGroup {
            case .transferMoney:
                TransferGeneralList()
            }
        }
        else if let _ = selectedGroup as? String {
            // TODO: 查詢使用者自訂群組的類型
            EmptyView()
        }
       

    }
    
}

struct ChooseTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseTypeView().environmentObject(AddDetailViewModel())
    }
}
