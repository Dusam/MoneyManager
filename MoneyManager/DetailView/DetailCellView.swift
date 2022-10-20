//
//  DetailCellView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/26.
//

import SwiftUI

struct DetailCellView: View {
    
    var rowName = ""
    @Binding var amount: Int
    
    private var amountNumberProxy: Binding<String> {
        Binding<String>(
            get: {
                return amount == 0 ? "" : "\(amount)"
            },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    amount = value.intValue
                } else {
                    amount = 0
                }
            }
        )
    }
    
    var body: some View {
        HStack {
            Text(rowName)
                .padding([.top, .bottom], 10)
                .font(.system(.title2))
            Spacer()
            
            HStack {
                Spacer()
                TextField("金額", text: amountNumberProxy)
                    .keyboardType(.numberPad)
                    .padding([.top, .bottom], 10)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(.title2))
                Spacer()
            }
            
            Spacer()
        }
    }
}

struct DetailCellView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCellView(rowName: "週一", amount: .constant(0))
    }
}
