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
    
    @EnvironmentObject var appearance: AppAppearance
    @Environment(\.dismiss) var dismiss
    
    @StateObject var addDetailVM: AddDetailViewModel
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
        
        // 初始化 ViewModel
        _addDetailVM = StateObject(wrappedValue: AddDetailViewModel(addDetailType: addDetailType, detail: detail))
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
                    saveButton()
                    
                    if addDetailType == .edit {
                        deleteButton()
                    }
                }
                .padding(.top, 10)
                .background(UserInfo.share.themeColor)
                
                CalculatorView()
                    .offset(y: addDetailVM.isHiddenCalculator ? 500 : 0)
                    .animation(.easeOut(duration: 0.3), value: addDetailVM.isHiddenCalculator)
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                topSegmentedControl()
            }
        }
        .alert(isPresented: $isShowDeleteAlert, content: deleteAlert) 
        .environmentObject(addDetailVM)
        .onAppear {
            if addDetailType != .edit {
                // 使用最後一次選擇的選項類型
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

extension AddDetailView {
    private func saveButton() -> some View {
        Button {
            if addDetailType == .edit {
                addDetailVM.updateDetail()
            } else {
                addDetailVM.createDetail()
            }
            dismiss()
        } label: {
            bottomButtonLabel(imageName: "checkmark.circle",
                              title: R.string.localizable.save())
        }
    }
    
    private func deleteButton() -> some View {
        Button {
            isShowDeleteAlert.toggle()
        } label: {
            bottomButtonLabel(imageName: "xmark.circle",
                              title: R.string.localizable.delete())
        }
    }
    
    @ViewBuilder
    private func bottomButtonLabel(imageName: String, title: String) -> some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
        .frame(maxWidth: .infinity)
        .background(.clear)
        .foregroundColor(appearance.themeColor.isLight ? Color(uiColor: UIColor.darkGray) : .white)
    }
    
    private func topSegmentedControl() -> some View {
        Picker("", selection: $addDetailVM.billingType) {
            ForEach(BillingType.allCases, id: \.self) { type in
                Text(type.name)
            }
        }
        .pickerStyle(.segmented)
        .frame(minWidth: UIScreen.main.bounds.width * 0.6)
    }
    
    private func deleteAlert() -> Alert {
        return Alert(title: Text(R.string.localizable.delete()),
                     message: Text(R.string.localizable.confirmDelete("")),
                     primaryButton: .destructive(Text(R.string.localizable.yes())) {
            details.removeAll(detail)
            addDetailVM.deleteDetail()
            dismiss()
        },
                     secondaryButton: .cancel(Text(R.string.localizable.no())))
    }
}

#Preview {
    AddDetailView().environmentObject(AppAppearance())
}
