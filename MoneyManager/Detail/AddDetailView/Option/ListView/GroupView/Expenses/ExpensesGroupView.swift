//
//  ExpensesGroupView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/3.
//

import SwiftUI

struct ExpensesGroupView: View {
    
    @Binding var selectedGroup: Any
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(ExpensesGroup.allCases, id: \.self) { group in
                Button {
                    addDetailVM.detailGroupId = group.rawValue.string
                    selectedGroup = group
                } label: {
                    Text(group.name)
                        .foregroundColor(.black)
                        .font(.system(size: 22))
                        .padding([.top, .bottom, .leading], 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background((selectedGroup as? ExpensesGroup) == group ? Color(R.color.cellBackgroundColor()!) : .white)
                }
            }
            
            ForEach(RealmManager.share.getExpensesGroup(), id: \.self) { group in
                Button {
                    addDetailVM.detailGroupId = group.id.stringValue
                    selectedGroup = group.id.stringValue
                } label: {
                    Text(group.name)
                        .foregroundColor(.black)
                        .font(.system(size: 22))
                        .padding([.top, .bottom, .leading], 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background((selectedGroup as? String) == group.id.stringValue ? Color(R.color.cellBackgroundColor()!) : .white)
                }
                
            }
        }
        
    }
    
}

struct ExpensesGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesGroupView(selectedGroup: .constant(ExpensesGroup.food)).environmentObject(AddDetailViewModel())
    }
}
