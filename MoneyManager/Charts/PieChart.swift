//
//  ChartsView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/12/14.
//

import SwiftUI
import Charts

struct PieChart: UIViewRepresentable {
    
    @Binding var datas: [PieChartDataEntry]
    
    func makeUIView(context: Context) -> PieChartView {
        let pieChart = PieChartView()
        pieChart.isUserInteractionEnabled = false
        pieChart.legend.enabled = false
        pieChart.holeRadiusPercent = 0.35
        pieChart.transparentCircleColor = .clear
        
        return pieChart
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        uiView.data = addData(datas: datas)
    }
    
    func addData(datas: [PieChartDataEntry]) -> PieChartData {
        let data = PieChartData()
        let dataSet = PieChartDataSet(entries: datas)

        dataSet.label = ""
        dataSet.drawValuesEnabled = false
        dataSet.entryLabelFont = .systemFont(ofSize: 16)
        
        if datas.count <= 1 {
            dataSet.drawValuesEnabled = false
            dataSet.colors = [.gray]
        } else {
            dataSet.colors = [R.color.incomeColor()!,
                              R.color.expensesColor()!,
                              R.color.transferColor()!]
        }
        
        data.dataSet = dataSet
        
        return data
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(datas: .constant([PieChartDataEntry(value: 20, label: "收入"),
                                   PieChartDataEntry(value: 70, label: "支出"),
                                   PieChartDataEntry(value: 10, label: "轉帳")]))
    }
}
