//
//  ContentView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import SwiftUI
import RealmSwift

struct UserListView: View {
    
    @ObservedObject private var userVM: UserViewModel = UserViewModel()
    
    @State private var isShowAlert = false
    @State private var deleteUser: UserModel!
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "chevron.backward.circle.fill"), transitionMaskImage: UIImage(systemName: "chevron.backward.circle.fill"))
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                List(userVM.users, id: \.id) { user in
                    UserCellView(user: user)
                        .listRowBackground(Color.clear)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                deleteUser = user
                                isShowAlert = true
                            } label: {
                                Text("刪除")
                            }
                            
                        }
                }
                .scrollContentBackground(.hidden)
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text("刪除"),
                          message: Text("確定要刪除 \(deleteUser.name) ?"),
                          primaryButton: .destructive(Text("刪除")) {
                        userVM.removeUser(deleteUser)
                    },
                          secondaryButton: .cancel(Text("取消")))
                }
                
                // 新增按鈕
                AddButtonView(nextView: AddUserView())

            }
            .searchable(text: $userVM.searchText,
                        placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("用戶清單")
            .navigationBarTitleDisplayMode(.inline)
            .hideBackButtonTitle()
            .onAppear {
                UserInfo.share.selectedDate = Date()
                userVM.getUsers()
            }
            
        }
        .environmentObject(userVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
