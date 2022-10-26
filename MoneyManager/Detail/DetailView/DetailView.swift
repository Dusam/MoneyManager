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
            
            List(detailVM.detailModels) { detail in
                if detail.billingType < 3 {
                    DetailCellView(detail: detail)
                } else {
                    ZStack(alignment: .leading) {
                        NavigationLink("") {
                            AddDetailView()
                        }.opacity(0)

                        
                        Text("新增一筆")
                            .foregroundColor(.gray)
                    }
                }
                
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("明細")
        .introspectNavigationController(customize: { navigation in
            navigation.navigationBar.topItem?.backButtonDisplayMode = .minimal
        })
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
