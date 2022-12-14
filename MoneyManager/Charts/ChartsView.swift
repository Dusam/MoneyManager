//
//  ChartsView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/12/14.
//

import SwiftUI
import SwiftUICharts

struct ChartsView: View {
    var body: some View {
        VStack {

            Spacer()
            PieChart()
                .data([5,25,70])
                .chartStyle(ChartStyle(backgroundColor: .white,
                                       foregroundColor: [ColorGradient(.blue, .purple),
                                                         ColorGradient(.orange, .red)]))
                .frame(width: 200, height: 200)
                .padding(20)
            Text("安安")
            Spacer()
           
            
//            PieChartView(data: [8,23,54,32,12,37,7,23,43],
//                         title: "測試",
//                         legend: "",
//                         style: Styles.pieChartStyleOne,
//                         form: ChartForm.extraLarge,
//                         dropShadow: true,
//                         valueSpecifier: "%.0f")
//            PieChartView(data: [8,23,54,32,12,37,7,23,43], title: "Title")
        }
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
