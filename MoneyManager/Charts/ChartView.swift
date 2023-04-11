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
                
            Text(R.string.localizable.chartTotal(chartVM.total.string))
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
                NavigationLink {
                    switch data.billingType {
                    case .income:
                        SectionDetailView(title: R.string.localizable.income(),
                                          datas: $chartVM.incomeSectionDatas)
                    case .expenses:
                        SectionDetailView(title: R.string.localizable.spend(),
                                          datas: $chartVM.expensesSectionDatas)
                    case .transfer:
                        SectionDetailView(title: R.string.localizable.transfer(),
                                          datas: $chartVM.transferSectionDatas)
                    }
                } label: {
                    VStack {
                        HStack {
                            Text("\(data.billingType.name) - $\(data.total)")
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                chartVM.getDatas()
            }
        }
        .hideBackButtonTitle()
        .environmentObject(chartVM)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
