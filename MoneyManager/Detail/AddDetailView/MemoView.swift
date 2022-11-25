//
//  MemoView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/16.
//

import SwiftUI

struct MemoView: View {
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var memo: String = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            VStack {
                TextEditor(text: $memo)
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
                HStack {
                    Text(memoModel.memo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .contentShape(Rectangle())
                .alignmentGuide(
                    .listRowSeparatorTrailing
                ) { dimensions in
                    dimensions[.trailing]
                }
                .onTapGesture {
                    self.memo = memoModel.memo
                }
                
            }
            .listStyle(.plain)
        }
        .padding(0)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addDetailVM.memo = memo
                    dismiss()
                } label: {
                    Text("完成")
                }

            }
        }
        .navigationTitle("備註")
        .onAppear {
            isFocused = true
            self.memo = addDetailVM.memo
            addDetailVM.getCommonMemos()
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView().environmentObject(AddDetailViewModel())
    }
}
