//
//  DetailGroupView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/9.
//

import SwiftUI

struct DetailGroupView: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @Binding var isEditing: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            
            ForEach(addDetailVM.detailGroupsModels, id: \.id) { group in
                HStack {
                    // 刪除按鈕，根據 isEditing 決定是否顯示
                    if isEditing {
                        Button(action: {
                            addDetailVM.deleteGroup(groupId: group.id.stringValue)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.red)
                                .cornerRadius(5)
                        }
                        .scaleEffect(0.7)
                        .padding(.trailing, 10)
                    }
                    
                    Button {
                        addDetailVM.detailGroupId = group.id.stringValue
                    } label: {
                        Text(group.name)
                            .foregroundColor(.black)
                            .font(.system(size: 22))
                            .padding(15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(addDetailVM.detailGroupId == group.id.stringValue ? Color(R.color.cellBackgroundColor()!) : .white)
                        
                    }
                }
            }
        }
        .animation(.default, value: isEditing)
    }
    
}

#Preview {
    DetailGroupView(isEditing: .constant(false))
        .environmentObject(AddDetailViewModel(addDetailType: .add, detail: DetailModel()))
}
