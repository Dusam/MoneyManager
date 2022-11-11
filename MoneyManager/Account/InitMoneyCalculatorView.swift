//
//  InitMoneyCalculatorView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/9.
//

import SwiftUI

struct InitMoneyCalculatorView: View {
    
    @Binding var value: String
    @Binding var isHiddenCalculator: Bool
//    @Binding var isHiddenCalculator: String
    @State private var isTypingNumber = false
//    @State private var isTypingOk = false
    @State private var currentOperation: Operation = .none
    
    let calcButtons: [[CalcButton]] = [
        [.clear, .del, .divide, .multiply],
        [.seven, .eight, .nine, .subtract],
        [.four, .five, .six, .add]
    ]
    
    let calcButtons1: [[CalcButton]] = [
        [.one, .two, .three],
        [.zero, .decimal]
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 0) {
                // 前三組按鈕
                self.initViewButton(calcButtons)
                
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        self.initViewButton(calcButtons1)
                    }
                    
                    Button(action: {
                        self.didTap(button: .ok)
                    }, label: {
                        InitMoneyCalculatorButtonView(item: .ok)
                    })
                }
            }
            .background(.white)
            .padding(.bottom)
        }
    }
    
    private func initViewButton(_ buttons: [[CalcButton]]) -> some View {
        ForEach(buttons, id: \.self) { row in
            HStack(spacing: 0) {
                ForEach(row, id: \.self) { item in
                    Button(action: {
                        self.didTap(button: item)
                    }, label: {
                        InitMoneyCalculatorButtonView(item: item)
                    })
                }
            }
        }
    }
    
    private func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .ok:
            isTypingNumber = false
            
            if button != .ok {
                self.calValue()
                self.isHiddenCalculator = false
                currentOperation = button.operation
                
                value.append(button.rawValue)
            } else {
                self.calValue()
                // 隱藏計算機
                self.isHiddenCalculator = true
            }
            
        case .clear:
            value = "0"
            
        case .decimal:
            self.isHiddenCalculator = false
            value = "\(value)."
        case .del:
            // 如果最後一個字元是(+,-,x,/)其中一種的話，就取消用戶目前計算的操作
            // 金額手續費刪除
            guard value.count > 0, value != "0" else {
                return
            }
            if value.count == 1 {
                value = "0"
                return
            }
            
            let lastString = value.removeLast().string
            if lastString == CalcButton.add.rawValue
                || lastString == CalcButton.subtract.rawValue
                || lastString == CalcButton.multiply.rawValue
                || lastString == CalcButton.divide.rawValue {
                currentOperation = .none
            }
            let endIndex = value.endIndex
            value = String(value.prefix(upTo: endIndex))
            
            self.isHiddenCalculator = false
            
        default:
            isTypingNumber = true
            let number = button.rawValue
            
            if isTypingNumber {
                // 輸入金額
                if value == "0" || self.isHiddenCalculator {
                    self.isHiddenCalculator = false
                    value = number
                } else {
                    value = "\(value)\(number)"
                }
            }
        }
    }
    
    private func calValue() {
        switch currentOperation {
        case .add:
            
            let array = value.split(separator: CalcButton.add.rawValue)
            
            if array.count == 2 {
                let value1 = Double(array[0]) ?? 0.0
                let value2 = Double(array[1]) ?? 0.0
                value = (value1 + value2).clearZero
            } else {
                value = removeOperation(value, .add)
            }
        case .subtract:
            
            let array = value.split(separator: CalcButton.subtract.rawValue)
            
            if array.count == 2 {
                let value1 = Double(array[0]) ?? 0.0
                let value2 = Double(array[1]) ?? 0.0
                value = (value1 - value2).clearZero
            } else {
                value = removeOperation(value, .subtract)
            }
        case .multiply:
            
            let array = value.split(separator: CalcButton.multiply.rawValue)
            
            if array.count == 2 {
                let value1 = Double(array[0]) ?? 0.0
                let value2 = Double(array[1]) ?? 0.0
                value = (value1 * value2).clearZero
            } else {
                value = removeOperation(value, .multiply)
            }
        case .divide:
            
            let array = value.split(separator: CalcButton.divide.rawValue)
            
            if array.count == 2 {
                let value1 = Double(array[0]) ?? 0.0
                let value2 = Double(array[1]) ?? 0.0
                value = (value1 / value2).clearZero
            } else {
                value = removeOperation(value, .divide)
            }
        case .none:
            break
        }
        
    }
    
    private func removeOperation(_ value: String, _ calcuBtn: CalcButton) -> String {
        return value.replacingOccurrences(of: calcuBtn.rawValue, with: "")
    }
}

struct InitMoneyCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        InitMoneyCalculatorView(value: .constant(""), isHiddenCalculator: .constant(false))
    }
}
