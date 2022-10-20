//
//  DetailHeaderView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/25.
//

import SwiftUI

struct DetailHeaderView: View {
    @EnvironmentObject var detailVM: DetailViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                detailVM.toPreviousDate()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .font(.system(.title2))
            }

            Spacer()
            Button {
                detailVM.toCurrentDate()
            } label: {
                VStack {
                    Text(detailVM.currentDateString)
                        .font(.system(.title2))
                        .foregroundColor(.gray)
                    Text("TW$ \(detailVM.totalAmount)")
                        .font(.system(.title3))
                        .foregroundColor(detailVM.totalAmount >= 0 ? .blue : .red)
                }
                
            }
            
            Spacer()
            Button {
                detailVM.toNextDate()
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundColor(.gray)
                    .font(.system(.title2))
            }
            Spacer()
        }
    }
}

struct DetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailHeaderView().environmentObject(DetailViewModel())
    }
}
