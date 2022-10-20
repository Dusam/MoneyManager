//
//  DetailView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/25.
//

import SwiftUI

struct DetailView: View {
    
    var userModel: UserModel!
    @ObservedObject var detailVM = DetailViewModel()
  
    var body: some View {
        VStack(alignment: .leading) {
            DetailHeaderView()
                .padding(.top, 20)
            
            ScrollView {
                VStack {
                    DetailCellView(rowName: "早餐", amount: $detailVM.breakfastAmount)
                    DetailCellView(rowName: "午餐", amount: $detailVM.lunchAmount)
                    DetailCellView(rowName: "晚餐", amount: $detailVM.dinnerAmount)
                    DetailCellView(rowName: "雜支", amount: $detailVM.otherAmount)
                }
            }
            .padding([.leading, .trailing, .bottom], 30)
        }
        .navigationTitle("明細")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    detailVM.createDetail(userModel.id)
                } label: {
                    Text("儲存")
                        .font(.system(.body))
                }

            }
        }
        .onAppear {
            UserInfo.share.selectedUserId = userModel.id
            detailVM.getDetail()
        }
        .environmentObject(detailVM)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(userModel: UserModel())
    }
}
