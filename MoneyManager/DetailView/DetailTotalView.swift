//
//  DetailTotalView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/26.
//

import SwiftUI

struct DetailTotalView: View {
    
    @Binding var total: Int
    
    var body: some View {
        HStack {
            Text("當日總計")
                .padding([.top, .bottom], 10)
                .font(.system(.title2))
            Spacer()
            Text("\(total)")
                .keyboardType(.numberPad)
                .padding([.top, .bottom, .leading], 10)
                .textFieldStyle(.roundedBorder)
                .font(.system(.title2))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

struct DetailTotalView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTotalView(total: .constant(0))
    }
}
