//
//  AddDetailView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import SwiftUI

struct AddDetailView: View {
    
    enum AddDetailType {
        case add, edit
    }
    
    @ObservedObject var addDetailVM = AddDetailViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isShowDeleteAlert = false
    
    @Binding private var details: [DetailModel]
    private var addDetailType: AddDetailType = .add
    private var detail: DetailModel = DetailModel()
    
    /// Modify detail need to set these parameter.
    ///
    ///     AddDetailView(addDetailType: .edit,
    ///                   detail: detail,
    ///                   details: $detailVM.detailModels)
    ///
    /// - Parameters:
    ///   - addDetailType: Set edit to modify detail. default is add.
    ///   - detail: Set the model when addDetailType is edit.
    ///   - details: The details is use to remove detail model from array when delete.
    init(addDetailType: AddDetailType = .add,
         detail: DetailModel = DetailModel(),
         details: Binding<[DetailModel]> = .constant([])) {
        self.addDetailType = addDetailType
        self._details = details
        self.detail = detail
        addDetailVM.isHiddenCalculator = addDetailType == .edit
        
        if addDetailType == .edit {
            addDetailVM.setEditDetailModel(detail)
        }
    }
    
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
                HStack {
                    Button {
                        if addDetailType == .edit {
                            addDetailVM.updateDetail()
                        } else {
                            addDetailVM.createDetail()
                        }
                        dismiss()
                    } label: {
                        VStack {
                            Image(systemName: "checkmark.circle")
                            Text(R.string.localizable.save())
                        }
                        .frame(maxWidth: .infinity)
                        .background(.white)
                    }
                    
                    if addDetailType == .edit {
                        Button {
                            isShowDeleteAlert.toggle()
                        } label: {
                            VStack {
                                Image(systemName: "xmark.circle")
                                Text(R.string.localizable.delete())
                            }
                            .frame(maxWidth: .infinity)
                            .tint(.red)
                            .background(.white)
                        }
                    }
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
        .alert(isPresented: $isShowDeleteAlert) {
            Alert(title: Text(R.string.localizable.delete()),
                  message: Text(R.string.localizable.confirmDelete("")),
                  primaryButton: .destructive(Text(R.string.localizable.yes())) {
                details.removeAll(detail)
                addDetailVM.deleteDetail()
                dismiss()
            },
                  secondaryButton: .cancel(Text(R.string.localizable.no())))
        }
        .hideBackButtonTitle()
        .environmentObject(addDetailVM)
        .onAppear {
            if addDetailType != .edit {
                switch addDetailVM.billingType {
                case .expenses:
                    addDetailVM.detailGroupId = UserInfo.share.selectedData.expensesGroupId
                    addDetailVM.detailTypeId = UserInfo.share.selectedData.expensesTypeId
                case .income:
                    addDetailVM.detailGroupId = UserInfo.share.selectedData.incomeGroupId
                    addDetailVM.detailTypeId = UserInfo.share.selectedData.incomeTypeId
                case .transfer:
                    addDetailVM.detailGroupId = UserInfo.share.selectedData.transferGroupId
                    addDetailVM.detailTypeId = UserInfo.share.selectedData.trnasferTypeId
                }
            }
        }
    }
}

struct AddDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddDetailView()
    }
}
