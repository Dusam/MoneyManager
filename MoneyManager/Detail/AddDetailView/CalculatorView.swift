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
            Spacer()
            
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
            .padding(.top, 10)
            .background(.white)
        }
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
                
                if addDetailVM.isEditingTransferFee {
                    addDetailVM.transferFee.append(button.rawValue)
                } else {
                    addDetailVM.valueString.append(button.rawValue)
                }
                
            } else {
                self.calValue()
                // 隱藏計算機
                self.isTypingOk = true
                addDetailVM.isHiddenCalculator = true
                addDetailVM.isEditingTransferFee = false
            }
            
        case .clear:
            if addDetailVM.isEditingTransferFee {
                addDetailVM.transferFee = "0"
            } else {
                addDetailVM.valueString = "0"
            }
            
        case .decimal:
            self.isTypingOk = false
            
            if addDetailVM.isEditingTransferFee {
                addDetailVM.transferFee = "\(addDetailVM.transferFee)."
            } else {
                addDetailVM.valueString = "\(addDetailVM.valueString)."
            }
            
        case .del:
            // 如果最後一個字元是(+,-,x,/)其中一種的話，就取消用戶目前計算的操作
            if addDetailVM.isEditingTransferFee {
                // 處理手續費刪除
                guard addDetailVM.transferFee.count > 0, addDetailVM.transferFee != "0" else {
                    return
                }
                
                if addDetailVM.transferFee.count == 1 {
                    addDetailVM.transferFee = "0"
                    return
                }
                
                let lastString = addDetailVM.transferFee.removeLast().string
                if lastString == CalcButton.add.rawValue
                    || lastString == CalcButton.subtract.rawValue
                    || lastString == CalcButton.multiply.rawValue
                    || lastString == CalcButton.divide.rawValue {
                    currentOperation = .none
                }
                let endIndex = addDetailVM.transferFee.endIndex
                addDetailVM.transferFee = String(addDetailVM.transferFee.prefix(upTo: endIndex))
                
            } else {
                // 金額手續費刪除
                guard addDetailVM.valueString.count > 0, addDetailVM.valueString != "0" else {
                    return
                }
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
            }
            self.isTypingOk = false
            
        default:
            isTypingNumber = true
            let number = button.rawValue
            
            if isTypingNumber {
                
                if addDetailVM.isEditingTransferFee {
                    // 輸入手續費
                    if addDetailVM.transferFee == "0" || self.isTypingOk {
                        self.isTypingOk = false
                        addDetailVM.transferFee = number
                    } else {
                        addDetailVM.transferFee = "\(addDetailVM.transferFee)\(number)"
                    }
                    
                } else {
                    // 輸入金額
                    if addDetailVM.valueString == "0" || self.isTypingOk {
                        self.isTypingOk = false
                        addDetailVM.valueString = number
                    } else {
                        addDetailVM.valueString = "\(addDetailVM.valueString)\(number)"
                    }
                    
                }
                
            }
        }
    }
    
    private func calValue() {
        switch currentOperation {
        case .add:
            if addDetailVM.isEditingTransferFee {
                let array = addDetailVM.transferFee.components(separatedBy: CalcButton.add.rawValue)
                
                if array.count == 2 {
                    let value1 = Double(array[0]) ?? 0.0
                    let value2 = Double(array[1]) ?? 0.0
                    addDetailVM.transferFee = (value1 + value2).clearZero
                }
                
            } else {
                let array = addDetailVM.valueString.components(separatedBy: CalcButton.add.rawValue)
                
                if array.count == 2 {
                    let value1 = Double(array[0]) ?? 0.0
                    let value2 = Double(array[1]) ?? 0.0
                    addDetailVM.valueString = (value1 + value2).clearZero
                }
            }
            
            
        case .subtract:
            if addDetailVM.isEditingTransferFee {
                let array = addDetailVM.transferFee.components(separatedBy: CalcButton.subtract.rawValue)
                
                if array.count == 2 {
                    let value1 = Double(array[0]) ?? 0.0
                    let value2 = Double(array[1]) ?? 0.0
                    addDetailVM.transferFee = (value1 - value2).clearZero
                }
            } else {
                let array = addDetailVM.valueString.components(separatedBy: CalcButton.subtract.rawValue)
                
                if array.count == 2 {
                    let value1 = Double(array[0]) ?? 0.0
                    let value2 = Double(array[1]) ?? 0.0
                    addDetailVM.valueString = (value1 - value2).clearZero
                }
            }
            
        case .multiply:
            if addDetailVM.isEditingTransferFee {
                let array = addDetailVM.transferFee.components(separatedBy: CalcButton.multiply.rawValue)
                
                if array.count == 2 {
                    let value1 = Double(array[0]) ?? 0.0
                    let value2 = Double(array[1]) ?? 0.0
                    addDetailVM.transferFee = (value1 * value2).clearZero
                }
            } else {
                let array = addDetailVM.valueString.components(separatedBy: CalcButton.multiply.rawValue)
                
                if array.count == 2 {
                    let value1 = Double(array[0]) ?? 0.0
                    let value2 = Double(array[1]) ?? 0.0
                    addDetailVM.valueString = (value1 * value2).clearZero
                }
            }
            
        case .divide:
            if addDetailVM.isEditingTransferFee {
                let array = addDetailVM.transferFee.components(separatedBy: CalcButton.divide.rawValue)
                
                if array.count == 2 {
                    let value1 = Double(array[0]) ?? 0.0
                    let value2 = Double(array[1]) ?? 0.0
                    addDetailVM.transferFee = (value1 / value2).clearZero
                }
            } else {
                let array = addDetailVM.valueString.components(separatedBy: CalcButton.divide.rawValue)
                
                if array.count == 2 {
                    let value1 = Double(array[0]) ?? 0.0
                    let value2 = Double(array[1]) ?? 0.0
                    addDetailVM.valueString = (value1 / value2).clearZero
                }
            }
            
        case .none:
            break
        }
        
    }
    
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView().environmentObject(AddDetailViewModel())
    }
}
