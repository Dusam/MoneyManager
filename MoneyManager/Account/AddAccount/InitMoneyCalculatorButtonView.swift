//
//  InitMoneyCalculatorButtonView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/11/9.
//

import SwiftUI

struct InitMoneyCalculatorButtonView: View {
    var item: CalcButton
    
    var body: some View {
        Text(item.rawValue)
            .font(.system(size: 32))
            .frame(
                width: self.buttonWidth(item: item),
                height: self.buttonHeight(item: item)
            )
            .background(item.buttonColor)
            .foregroundColor(.white)
            .overlay {
                Rectangle()
                    .stroke(Color(R.color.cellBackgroundColor()!), lineWidth: 1)
            }
//            .cornerRadius(self.buttonWidth(item: item)/2)
    }
    
    private func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2.05 + 10
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4 + 10
    }
    
    private func buttonHeight(item: CalcButton) -> CGFloat {
        if item == .ok {
            return (((UIScreen.main.bounds.width * 0.8) - (4 * 12)) / 4) * 1.91
        }
        return ((UIScreen.main.bounds.width * 0.8) - (5 * 12)) / 4
    }
}

struct InitMoneyCalculatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        InitMoneyCalculatorButtonView(item: CalcButton.add)
    }
}
