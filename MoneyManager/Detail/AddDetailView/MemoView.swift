//
//  MemoView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/16.
//

import SwiftUI

struct MemoView: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @FocusState private var isFocused: Bool
    
    init() {
        isFocused = true
    }
    
    var body: some View {
        VStack(spacing: 15) {
            VStack {
                TextEditor(text: $addDetailVM.memo)
                    .focused($isFocused)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1)
                    )
            }
            .padding()
           
            // 常用備註
            List(addDetailVM.commonMemos, id: \.self) { memoModel in
                Text(memoModel.memo)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color(uiColor: R.color.cellBackgroundColor()!))
                    
            }
            .listStyle(.plain)
        }
        .padding(0)
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView().environmentObject(AddDetailViewModel())
    }
}
