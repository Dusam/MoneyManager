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
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                deleteUser = user
                                isShowAlert = true
                            } label: {
                                Text(R.string.localizable.delete())
                            }
                            
                        }
                }
                .scrollContentBackground(.hidden)
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text(R.string.localizable.delete()),
                          message: Text(R.string.localizable.confirmDelete(deleteUser.name)),
                          primaryButton: .destructive(Text(R.string.localizable.delete())) {
                        userVM.removeUser(deleteUser)
                    },
                          secondaryButton: .cancel(Text(R.string.localizable.cancel())))
                }
                
                // 新增按鈕
                AddButtonView(nextView: AddUserView())

            }
            .searchable(text: $userVM.searchText,
                        placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle(R.string.localizable.userList())
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
