//
//  DetailCellView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/26.
//

import SwiftUI

struct DetailCellView: View {
    @EnvironmentObject var detailVM: DetailViewModel
    
    private var billingType: BillingType = .expenses
    private var detail: DetailModel!
    
    init(detail: DetailModel) {
        self.detail = detail
        billingType = BillingType(rawValue: detail.billingType) ?? .expenses
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(detailVM.detailTypeToString(detailModel: detail))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                Text(detail.memo)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            VStack(alignment: .trailing) {
                Text("TW$ \(detail.amount)")
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(billingType.forgroundColor)
                Text(billingType == .transfer ? "\(detail.accountName) -> \(detail.toAccountName)" : detail.accountName)
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
        DetailCellView(detail: DetailModel()).environmentObject(DetailViewModel())
    }
}
