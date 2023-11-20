//
//  AddAccountView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/8.
//

import SwiftUI

struct AddAccountView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appearance: AppAppearance
    @ObservedObject var addAccountVM: AddAccountViewModel = AddAccountViewModel()
    
    @State private var showingConfirmation = false
        
    var body: some View {
        ZStack {
            Color(R.color.cellBackgroundColor()!).ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Button {
                    showingConfirmation.toggle()
                } label: {
                    Label {
                        Text(addAccountVM.accountType.typeName)
                    } icon: {
                        Image(uiImage: addAccountVM.accountType.image)
                    }
                    .font(.system(size: 26))
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(20)
                }
                
                AddAccountInfoView()
                
                Toggle(R.string.localizable.joinTotal(), isOn: $addAccountVM.includTotal)
                    .font(.system(size: 24))
                    .padding(20)
                    .background(.white)
                    .cornerRadius(20)
                
                Spacer()
            }
            .padding()
            
            InitMoneyCalculatorView(value: $addAccountVM.initMoney, isHiddenCalculator: $addAccountVM.isHiddenCalculator)
                .offset(y: addAccountVM.isHiddenCalculator ? 500 : 0)
                .animation(.easeOut(duration: 0.3), value: addAccountVM.isHiddenCalculator)
        }
        .confirmationDialog(R.string.localizable.accountType(), isPresented: $showingConfirmation) {
            ForEach(AccountType.allCases, id: \.self) { account in
                Button {
                    addAccountVM.accountType = account
                } label: {
                    Text(account.typeName)
                        .font(.system(size: 28))
                }
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    addAccountVM.saveAccount()
                    dismiss()
                } label: {
                    Text(R.string.localizable.save())
                        .foregroundColor(appearance.themeColor.isLight ? .black : .white)
                }
            }
        })
        .hideBackTitle()
        .onTapGesture {
            addAccountVM.isHiddenCalculator = true
        }
        .navigationTitle(R.string.localizable.addAccount())
        .environmentObject(addAccountVM)
        
    }
}

struct AddAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountView()
    }
}
