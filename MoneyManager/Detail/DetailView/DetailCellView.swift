//
//  DetailCellView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/26.
//

import SwiftUI

struct DetailCellView: View {
    private var billingType: BillingType = .expenses
    private var detail: DetailModel!
    @Binding private var details: [DetailModel]
    
    init(detail: DetailModel, details: Binding<[DetailModel]>) {
        self.detail = detail
        self._details = details
        billingType = BillingType(rawValue: detail.billingType) ?? .expenses
    }
    
    var body: some View {
        ZStack {
            HStack{
                VStack(alignment: .leading) {
                    Text(DBTools.detailTypeToString(detailModel: detail))
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    Text(detail.memo.replacing("\n", with: " "))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 5)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("TW$ \(detail.amount)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(billingType.forgroundColor)
                    Text(billingType == .transfer ? "\(detail.accountName) -> \(detail.toAccountName)" : detail.accountName)
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                        .multilineTextAlignment(.trailing)
                        .padding(.bottom, 5)
                        .foregroundColor(.brown)
                    
                }
            }
            
            NavigationLink("") {
                AddDetailView(addDetailType: .edit,
                              detail: detail,
                              details: $details)
            }.opacity(0)
        }
        .listRowSeparator(.hidden)
    }
}

struct DetailCellView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCellView(detail: DetailModel(), details: .constant([])).environmentObject(DetailViewModel())
    }
}
