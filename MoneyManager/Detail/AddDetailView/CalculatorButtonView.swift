//
//  CalculatorButtonView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/10/28.
//

import SwiftUI

struct CalculatorButtonView: View {
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
            .cornerRadius(self.buttonWidth(item: item)/2)
    }
    
    private func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    private func buttonHeight(item: CalcButton) -> CGFloat {
        if item == .ok {
            return ((UIScreen.main.bounds.width * 0.8) - (5 * 12)) / 2
        }
        return ((UIScreen.main.bounds.width * 0.8) - (5 * 12)) / 4
    }
}

struct CalculatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonView(item: CalcButton.add)
    }
}
