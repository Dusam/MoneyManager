//
//  CalculatorView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import SwiftUI

struct CalculatorView: View {
    
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    
    @State private var isTypingNumber = false
    @State private var isTypingOk = false
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
            // 前三組按鈕
            self.initViewButton(calcButtons)
            
            HStack {
                VStack {
                    self.initViewButton(calcButtons1)
                }
                
                Button(action: {
                    self.didTap(button: .ok)
                }, label: {
                    CalculatorButtonView(item: .ok)
                })
            }
        }
        .background(.white)
    }
    
    private func initViewButton(_ buttons: [[CalcButton]]) -> some View {
        ForEach(buttons, id: \.self) { row in
            HStack(spacing: 12) {
                ForEach(row, id: \.self) { item in
                    Button(action: {
                        self.didTap(button: item)
                    }, label: {
                        CalculatorButtonView(item: item)
                    })
                }
            }
            .padding(.bottom, 3)
        }
    }
    
    private func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .ok:
            isTypingNumber = false
            
            if button != .ok {
                self.calValue()
                self.isTypingOk = false
                currentOperation = button.operation
                addDetailVM.valueString.append(button.rawValue)
                
            } else {
                self.calValue()
                // 隱藏計算機
                self.isTypingOk = true
                addDetailVM.isHiddenCalculator = true
            }
            
        case .clear:
            addDetailVM.valueString = "0"
            
        case .decimal:
            self.isTypingOk = false
            addDetailVM.valueString = "\(addDetailVM.valueString)."
            
        case .del:
            // 如果最後一個字元是(+,-,x,/)其中一種的話，就取消用戶目前計算的操作
            guard addDetailVM.valueString.count > 0, addDetailVM.valueString != "0" else {
                return
            }
            self.isTypingOk = false
            
            if addDetailVM.valueString.count == 1 {
                addDetailVM.valueString = "0"
                return
            }
            
            let lastString = addDetailVM.valueString.removeLast().string
            if lastString == CalcButton.add.rawValue
                || lastString == CalcButton.subtract.rawValue
                || lastString == CalcButton.multiply.rawValue
                || lastString == CalcButton.divide.rawValue {
                currentOperation = .none
            }
            let endIndex = addDetailVM.valueString.endIndex
            addDetailVM.valueString = String(addDetailVM.valueString.prefix(upTo: endIndex))
            
        default:
            isTypingNumber = true
            let number = button.rawValue
            
            if isTypingNumber {
                
                if addDetailVM.valueString == "0" || self.isTypingOk {
                    self.isTypingOk = false
                    addDetailVM.valueString = number
                } else {
                    addDetailVM.valueString = "\(addDetailVM.valueString)\(number)"
                }
            }
        }
    }
    
    private func calValue() {
        switch currentOperation {
        case .add:
            let array = addDetailVM.valueString.components(separatedBy: CalcButton.add.rawValue)
            
            if array.count == 2 {
                let value1 = Double(array[0]) ?? 0.0
                let value2 = Double(array[1]) ?? 0.0
                addDetailVM.valueString = (value1 + value2).clearZero
            }
            
        case .subtract:
            let array = addDetailVM.valueString.components(separatedBy: CalcButton.subtract.rawValue)
            
            if array.count == 2 {
                let value1 = Double(array[0]) ?? 0.0
                let value2 = Double(array[1]) ?? 0.0
                addDetailVM.valueString = (value1 - value2).clearZero
            }
        case .multiply:
            let array = addDetailVM.valueString.components(separatedBy: CalcButton.multiply.rawValue)
            
            if array.count == 2 {
                let value1 = Double(array[0]) ?? 0.0
                let value2 = Double(array[1]) ?? 0.0
                addDetailVM.valueString = (value1 * value2).clearZero
            }
        case .divide:
            let array = addDetailVM.valueString.components(separatedBy: CalcButton.divide.rawValue)
            
            if array.count == 2 {
                let value1 = Double(array[0]) ?? 0.0
                let value2 = Double(array[1]) ?? 0.0
                addDetailVM.valueString = (value1 / value2).clearZero
            }
        case .none:
            break
        }
        
    }
    
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
