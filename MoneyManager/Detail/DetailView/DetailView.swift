//
//  DetailView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/25.
//

import SwiftUI

struct DetailView: View {
    
    var userModel: UserModel!
    @EnvironmentObject var appearance: AppAppearance
    @StateObject var detailVM = DetailViewModel()
  
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DetailHeaderView()
                .padding(.top, 20)
            
            List(detailVM.detailModels) { detail in
                if detail.billingType < 3 {
                    DetailCellView(detail: detail,
                                   details: $detailVM.detailModels)
                } else {
                    ZStack(alignment: .leading) {
                        NavigationLink("") {
                            AddDetailView()
                        }.opacity(0)

                        Text(R.string.localizable.addNew())
                            .foregroundColor(.gray)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            
            HStack {
                accountNavigationLink()
                addDetailNavigationLink()
                chartNavigationLink()
                settingNavigationLink()
            }
            .padding(.top, 10)
            .background(UserInfo.share.themeColor)
            
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
        .hideBackTitle()
        .onAppear {
            UserInfo.share.selectedUserId = userModel.id
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                detailVM.getDetail()
            }
        }
        .environmentObject(detailVM)
    }
}

// MARK: Tabbar Navigation
extension DetailView {
    @ViewBuilder
    private func accountNavigationLink() -> some View {
        NavigationLink(destination: AccountDetailView()) {
            VStack {
                Image(systemName: "house.fill")
                Text(R.string.localizable.account())
            }
            .frame(maxWidth: .infinity)
            .background(.clear)
            .foregroundColor(appearance.themeColor.isLight ? Color(uiColor: UIColor.darkGray) : .white)
        }
    }
    
    @ViewBuilder
    private func addDetailNavigationLink() -> some View {
        NavigationLink(destination: AddDetailView()) {
            VStack {
                Image(systemName: "plus")
                Text(R.string.localizable.add())
            }
            .frame(maxWidth: .infinity)
            .background(.clear)
            .foregroundColor(appearance.themeColor.isLight ? Color(uiColor: UIColor.darkGray) : .white)
        }
    }
    
    @ViewBuilder
    private func chartNavigationLink() -> some View {
        NavigationLink(destination: ChartView()) {
            VStack {
                Image(systemName: "chart.pie.fill")
                Text(R.string.localizable.chart())
            }
            .frame(maxWidth: .infinity)
            .background(.clear)
            .foregroundColor(appearance.themeColor.isLight ? Color(uiColor: UIColor.darkGray) : .white)
        }
    }
    
    @ViewBuilder
    private func settingNavigationLink() -> some View {
        NavigationLink(destination: SettingView()) {
            VStack {
                Image(systemName: "gearshape.fill")
                Text(R.string.localizable.setting())
            }
            .frame(maxWidth: .infinity)
            .background(.clear)
            .foregroundColor(appearance.themeColor.isLight ? Color(uiColor: UIColor.darkGray) : .white)
        }
    }
}

#Preview {
    DetailView(userModel: UserModel())
        .environmentObject(AppAppearance())
}
