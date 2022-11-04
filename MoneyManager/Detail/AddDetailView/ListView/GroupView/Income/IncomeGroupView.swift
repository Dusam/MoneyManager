//
//  IncomeGroupView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/4.
//

import SwiftUI


struct IncomeGroupView: View {
    @Binding var selectedGroup: Any
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(IncomeGroup.allCases, id: \.self) { group in
                Button {
                    addDetailVM.detailGroupId = group.rawValue.string
                    selectedGroup = group
                } label: {
                    Text(group.name)
                        .foregroundColor(.black)
                        .font(.system(size: 22))
                        .padding([.top, .bottom, .leading], 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background((selectedGroup as? IncomeGroup) == group ? Color(R.color.cellBackgroundColor()!) : .white)
                }
            }
            
        }
        
    }
}

struct IncomeGroupView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeGroupView(selectedGroup: .constant(IncomeGroup.general)).environmentObject(AddDetailViewModel())
    }
}
