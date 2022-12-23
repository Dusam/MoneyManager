//
//  ChartHeaderView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/12/21.
//

import SwiftUI

struct ChartHeaderView: View {
    
    @EnvironmentObject var chartVM: ChartViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                chartVM.toPrevious()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .font(.system(.title2))
            }

            Spacer()
            Button {
                chartVM.toCurrentDate()
            } label: {
                VStack {
                    Text(chartVM.currentDateString)
                        .font(.system(.title2))
                        .foregroundColor(.gray)
                }
                
            }
            
            Spacer()
            Button {
                chartVM.toNext()
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundColor(.gray)
                    .font(.system(.title2))
            }
            Spacer()
        }
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

struct ChartHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ChartHeaderView().environmentObject(ChartViewModel())
    }
}
