//
//  DetailGroupView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2023/2/9.
//

import SwiftUI

struct DetailGroupView: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            
            ForEach(RealmManager.share.getDetailGroup(billType: addDetailVM.billingType), id: \.id) { group in
                
                Button {
                    addDetailVM.detailGroupId = group.id.stringValue
                } label: {
                    Text(group.name)
                        .foregroundColor(.black)
                        .font(.system(size: 22))
                        .padding([.top, .bottom, .leading], 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(addDetailVM.detailGroupId == group.id.stringValue ? Color(R.color.cellBackgroundColor()!) : .white)
                    
                }
                
            }
        }
        
    }
    
}

struct DetailGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DetailGroupView().environmentObject(AddDetailViewModel())
    }
}
