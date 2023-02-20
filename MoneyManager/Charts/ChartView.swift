//
//  ChartView.swift
//  MoneyManager
//
//  Created by 杜千煜 on 2022/12/20.
//

import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var chartVM: ChartViewModel = ChartViewModel()
    
    var body: some View {
        VStack {
            ChartHeaderView()
            
            PieChart(datas: $chartVM.chartDatas)
                .frame(height: UIScreen.main.bounds.height * 0.3)
                
            
            Text("總計 - TW$\(chartVM.total)")
                .font(.bold(.system(size: 20))())
                .frame(maxWidth: .infinity)
                .padding([.bottom], 10)
                .overlay {
                    VStack {
                        Spacer()
                        Divider()
                            .background(.gray)
                    }
                    .padding([.leading, .trailing], 40)
                    
                }
            
            List(chartVM.listDatas, id: \.self) { data in
                Button {
                    // TODO: 查看單一項目
                } label: {
                    VStack {
                        HStack {
                            Text("\(data.billingType.name) - TW$\(data.total)")
                            Spacer()
                            Text("\(String(format:"%.2f", data.percent))%")
                                 
                        }
                        ProgressView("", value: data.percent, total: 100)
                            .tint(data.billingType.forgroundColor)
                            .scaleEffect(x: 1, y: 4, anchor: .bottom)
                    }
                    
                }
            }
            .listStyle(.plain)
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $chartVM.chartType) {
                    ForEach(ChartType.allCases, id: \.self) { type in
                        Text(type.name)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("    ")
                    .font(.system(.body))
            }

        }
        .environmentObject(chartVM)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}