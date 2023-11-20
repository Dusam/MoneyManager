//
//  ContentView.swift
//  MoneyManager
//
//  Created by Qian-Yu Du on 2022/5/19.
//

import SwiftUI
import RealmSwift

struct UserListView: View {
    @StateObject var appearance = AppAppearance()
    @ObservedObject private var userVM: UserViewModel = UserViewModel()
    
    @State private var isShowAlert = false
    @State private var deleteUser: UserModel!
    
    var body: some View {
        NavigationStack {
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
            .onAppear {
                let searchBarAppearance = UISearchBar.appearance()
                let isLight = appearance.themeColor.isLight
                searchBarAppearance.overrideUserInterfaceStyle = isLight ? .light : .dark
                searchBarAppearance.tintColor = isLight ? .black : .white
                
                UserInfo.share.selectedDate = Date()
                userVM.getUsers()
            }
        }
        .setNavigationBar(appearance.themeColor)
        .preferredColorScheme(appearance.colorScheme)
        .environmentObject(userVM)
        .environmentObject(appearance)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
