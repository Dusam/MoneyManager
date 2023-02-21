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
                Button {
                    addDetailVM.memo = memoModel.memo
                    addDetailVM.needRefershMemo = false
                } label: {
                    Text(memoModel.memo.replacing("\n", with: " "))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                }
                .contentShape(Rectangle())
                .alignmentGuide(
                    .listRowSeparatorTrailing
                ) { dimensions in
                    dimensions[.trailing]
                }
                
            }
            .listStyle(.plain)
        }
        .padding(0)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Text(R.string.localizable.compelete())
                }

            }
        }
        .navigationTitle(R.string.localizable.memo())
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
