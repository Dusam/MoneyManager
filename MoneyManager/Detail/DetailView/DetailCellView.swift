//
//  DetailCellView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/26.
//

import SwiftUI

struct DetailCellView: View {
    
    var detail: DetailModel!    
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("轉帳 - 一般轉帳")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                Text("雙蛋蛋餅")
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            VStack(alignment: .trailing) {
                Text("TW$ \(detail.amount)")
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(BillingType(rawValue: detail.billingType)?.forgroundColor)
                Text("現金")
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
                    .foregroundColor(.brown)
                
            }
            
        }
        .listRowSeparator(.hidden)
    }
}

struct DetailCellView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCellView(detail: DetailModel())
    }
}
