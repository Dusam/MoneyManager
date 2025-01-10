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
            previousButton()
            Spacer()
            todayButton()
            Spacer()
            nextButton()
            Spacer()
        }
    }
}

extension DetailHeaderView {
    @ViewBuilder
    private func previousButton() -> some View {
        Button {
            detailVM.toPreviousDate()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.gray)
                .font(.system(.title2))
        }
    }
    
    @ViewBuilder
    private func todayButton() -> some View {
        Button {
            detailVM.toCurrentDate()
        } label: {
            VStack {
                Text(detailVM.currentDateString)
                    .font(.system(.title2))
                    .foregroundColor(.gray)
                Text("TW$ \(detailVM.totalAmount)")
                    .font(.system(.title3))
                    .foregroundColor(detailVM.totalAmount >= 0 ? Color(R.color.transferColor()!) : Color(R.color.expensesColor()!))
            }
        }
    }
    
    @ViewBuilder
    private func nextButton() -> some View {
        Button {
            detailVM.toNextDate()
        } label: {
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(.title2))
        }
    }
}

#Preview {
    DetailHeaderView().environmentObject(DetailViewModel())
}
