//
//  SingleAccountListHeaderView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/4/6.
//

import SwiftUI

struct SingleAccountListHeaderView: View {
    
    @EnvironmentObject var singleAccountVM: SingleAccountViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                singleAccountVM.toPreviousDate()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .font(.system(.title2))
            }
            
            Spacer()
            Button {
                singleAccountVM.toCurrentDate()
            } label: {
                VStack {
                    Text(singleAccountVM.currentDateString)
                        .font(.system(.title3))
                        .foregroundColor(.gray)
                    Text("TW$ \(singleAccountVM.totalAmount)")
                        .font(.system(.title3))
                        .foregroundColor(singleAccountVM.totalAmount >= 0 ? Color(R.color.transferColor()!) : Color(R.color.expensesColor()!))
                }
                
            }
            
            Spacer()
            Button {
                singleAccountVM.toNextDate()
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundColor(.gray)
                    .font(.system(.title2))
            }
            Spacer()
        }
    }
}

struct SingleAccountListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SingleAccountListHeaderView().environmentObject(SingleAccountViewModel())
    }
}
