//
//  AddDetailView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

struct AddDetailView: View {
    
    @ObservedObject var addDetailVM = AddDetailViewModel()
    @State private var segmentationSelection: BillingType = .expenses
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("TW$")
                    .font(.system(size: 32))
                    .foregroundColor(.blue)
                    .frame(width: 100)
                
                Text(addDetailVM.valueString)
                    .font(.system(size: 36))
                    .foregroundColor(segmentationSelection.forgroundColor)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .overlay(
                        VStack {
                            Divider().offset(x: 0, y: 15)
                        }
                    )
            }
            .frame(height: UIScreen.main.bounds.height * 0.07)
            .padding([.top, .leading, .trailing], 20)
            .contentShape(Rectangle())   
            .onTapGesture {
                addDetailVM.isHiddenCalculator = false
            }
            
            
            AddDetailHeaderView()
                .padding(.top, 10)
            Spacer()
            ZStack{
                CalculatorView()
            }
            .offset(y: addDetailVM.isHiddenCalculator ? 500 : 0)
            .animation(.easeOut(duration: 0.3), value: addDetailVM.isHiddenCalculator)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $segmentationSelection) {
                    ForEach(BillingType.allCases, id: \.self) { type in
                        Text(type.name)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                } label: {
                    Text("    ")
                        .font(.system(.body))
                }

            }

        }
        
        .environmentObject(addDetailVM)
    }
}

struct AddDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddDetailView()
    }
}
