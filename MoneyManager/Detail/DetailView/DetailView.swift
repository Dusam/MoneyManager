//
//  DetailView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/25.
//

import SwiftUI
import Introspect

struct DetailView: View {
    
    var userModel: UserModel!
    @ObservedObject var detailVM = DetailViewModel()
  
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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

                        Text("新增一筆...")
                            .foregroundColor(.gray)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            
            NavigationLink(destination: AccountDetailView()) {
                VStack {
                    Image(systemName: "house.fill")
                    Text("帳戶")
                }
                .frame(maxWidth: .infinity)
                .background(.white)
            }
            
        }
        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width < 0 {
                    detailVM.toNextDate()
                }
                
                if value.translation.width > 0 {
                    detailVM.toPreviousDate()
                }
            })
        )
        .navigationTitle("\(userModel.name)")
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
