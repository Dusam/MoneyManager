//
//  CalculatorView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/26.
//

import SwiftUI
enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case ok = "OK"
    case clear = "AC"
    case del = "DEL"
    case decimal = "."
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .ok:
            return .orange
        case .del:
            return .red
        case .clear:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct CalculatorView: View {
    
    @EnvironmentObject var addDetailVM: AddDetailViewModel
    @State var currentValueString = ""
    
    @State private var isTypingNumber = false
    @State private var runningNumber = 0.0
    @State private var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .del, .divide, .mutliply],
        [.seven, .eight, .nine, .subtract],
        [.four, .five, .six, .add]
    ]
    
    let buttons1: [[CalcButton]] = [
        [.one, .two, .three],
        [.zero, .decimal]
    ]
    
    var body: some View {
        VStack {
            // 前三組按鈕
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { item in
                        Button(action: {
                            self.didTap(button: item)
                        }, label: {
                            Text(item.rawValue)
                                .font(.system(size: 32))
                                .frame(
                                    width: self.buttonWidth(item: item),
                                    height: self.buttonHeight(item: item)
                                )
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(self.buttonWidth(item: item)/2)
                        })
                    }
                }
                .padding(.bottom, 3)
            }
            
            
            HStack {
                VStack {
                    ForEach(buttons1, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { item in
                                Button(action: {
                                    self.didTap(button: item)
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame(
                                            width: self.buttonWidth(item: item),
                                            height: self.buttonHeight(item: item)
                                        )
                                        .background(item.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(self.buttonWidth(item: item)/2)
                                })
                            }
                        }
                        .padding(.bottom, 3)
                    }
                }
                
                Button(action: {
                    self.didTap(button: .ok)
                }, label: {
                    Text(CalcButton.ok.rawValue)
                        .font(.system(size: 32))
                        .frame(
                            width: self.buttonWidth(item: .ok),
                            height: self.buttonHeight(item: .ok)
                        )
                        .background(CalcButton.ok.buttonColor)
                        .foregroundColor(.white)
                        .cornerRadius(self.buttonWidth(item: .ok)/2)
                })
                
            }
        }
        .background(.white)
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .ok:
            isTypingNumber = false
            
            if button == .add {
//                addDetailVM.currentOperation = .add
//                addDetailVM.runningNumber = Double(addDetailVM.valueString) ?? 0.0
                currentOperation = .add
                runningNumber = Double(addDetailVM.valueString) ?? 0.0
            }
            else if button == .subtract {
//                addDetailVM.currentOperation = .subtract
//                addDetailVM.runningNumber = Double(addDetailVM.valueString) ?? 0.0
                currentOperation = .subtract
                runningNumber = Double(addDetailVM.valueString) ?? 0.0
            }
            else if button == .mutliply {
//                addDetailVM.currentOperation = .multiply
//                addDetailVM.runningNumber = Double(addDetailVM.valueString) ?? 0.0
                currentOperation = .multiply
                runningNumber = Double(addDetailVM.valueString) ?? 0.0
            }
            else if button == .divide {
//                addDetailVM.currentOperation = .divide
//                addDetailVM.runningNumber = Double(addDetailVM.valueString) ?? 0.0
                currentOperation = .divide
                runningNumber = Double(addDetailVM.valueString) ?? 0.0
            }
            else if button == .ok {
                let runningValue = runningNumber
                let currentValue = Double(currentValueString) ?? 0.0
//                switch addDetailVM.currentOperation {
                switch currentOperation {
                case .add: addDetailVM.valueString = "\(runningValue + currentValue)"
                case .subtract: addDetailVM.valueString = "\(runningValue - currentValue)"
                case .multiply: addDetailVM.valueString = "\(runningValue * currentValue)"
                case .divide: addDetailVM.valueString = "\(runningValue / currentValue)"
                case .none:
                    break
                }
                // 隱藏計算機
                addDetailVM.isHiddenCalculator = true
            }
            
            if button != .ok {
                currentValueString = "0"
                addDetailVM.valueString.append(button.rawValue)
            }
            
            // 清空目前數值
            currentValueString = ""
            
        case .clear:
            addDetailVM.valueString = "0"
//            addDetailVM.runningNumber = 0
            runningNumber = 0.0
        case .decimal:
            break
        case .del:
            // 如果最後一個字元是(+,-,x,/)其中一種的話，就取消用戶目前計算的操作
            let lastString = addDetailVM.valueString.removeLast().string
            if lastString == CalcButton.add.rawValue
                || lastString == CalcButton.subtract.rawValue
                || lastString == CalcButton.mutliply.rawValue
                || lastString == CalcButton.divide.rawValue {
                currentOperation = .none
            }
            addDetailVM.valueString = addDetailVM.valueString.removingSuffix(
                addDetailVM.valueString.removeLast().string
            )
//            addDetailVM.runningNumber = Double(addDetailVM.valueString) ?? 0.0
            runningNumber = Double(currentValueString) ?? 0.0
        default:
            isTypingNumber = true
            
            let number = button.rawValue
//            if addDetailVM.valueString == "0" {
//                addDetailVM.valueString = number
//            } else {
//                addDetailVM.valueString = "\(addDetailVM.valueString)\(number)"
//            }
            
            if isTypingNumber {
                if addDetailVM.valueString == "0" {
                    addDetailVM.valueString = number
                } else {
                    addDetailVM.valueString = "\(addDetailVM.valueString)\(number)"
                }
                
                currentValueString = "\(currentValueString)\(number)"
            }
            
//            if currentValueString == "0" {
//                currentValueString = number
//                if addDetailVM.valueString == "0" {
//                    addDetailVM.valueString = number
//                } else {
//                    addDetailVM.valueString = "\(addDetailVM.valueString)\(number)"
//                }
//            } else {
//                currentValueString = "\(currentValueString)\(number)"
//                addDetailVM.valueString = "\(addDetailVM.valueString)\(number)"
//            }
            
            

        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight(item: CalcButton) -> CGFloat {
        if item == .ok {
            return ((UIScreen.main.bounds.width * 0.8) - (5 * 12)) / 2
        }
        return ((UIScreen.main.bounds.width * 0.8) - (5 * 12)) / 4
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
