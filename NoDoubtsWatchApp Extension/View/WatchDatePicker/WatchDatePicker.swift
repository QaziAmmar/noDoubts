//
//  WatchDatePicker.swift
//  NoDoubtsWatchApp Extension
//
//  Created by Qazi on 13/10/2021.
//

import SwiftUI

struct WatchDatePicker: View {
    @State private var selectedMonth = [String]()
    @State private var SelectedDay = [String]()
    @State private var userSelectedyear = 0
    @State private var userSelectedday = 0
    @State private var userSelectedmonth = 0
    @State var SelectedYear = [String]()
    var array = ["1","2"]
    @State private var AlreadyCalledFunctions: Bool = true
    @Binding var day: Int
    @Binding var year: Int
    @Binding var month: Int
    //    init(day: Binding<Int>, year: Binding<Int>, month: Binding<Int>) {
    //        _day = day
    //        _year = year
    //        _month = month
    //    }
    var body: some View {
        VStack{
            HStack(spacing: 5){
                Picker("Month", selection: $userSelectedmonth) {
                    ForEach(selectedMonth.indices , id: \.self) { month in
                        Text(selectedMonth[month])
                    }
                }.frame(height: 80).pickerStyle(WheelPickerStyle())
                .onChange(of: userSelectedmonth, perform: { newValue in
                    month = Int(selectedMonth[newValue]) ?? 0

                })
                Picker("Day", selection: $userSelectedday) {
                    ForEach(SelectedDay.indices, id: \.self) { day in
                        Text(SelectedDay[day])
                    }
                }.frame(height: 80).pickerStyle(WheelPickerStyle())
                .onChange(of: userSelectedday, perform: { newValue in
                    print("Selected Unit: \(SelectedDay[newValue])")
                    day = Int(SelectedDay[newValue]) ?? 0

                })
                Picker("Year" , selection: $userSelectedyear) {
                    ForEach(SelectedYear.indices, id: \.self) { unitIndex in
                        Text(SelectedYear[unitIndex])
                        
                    }
                }.frame(height: 80)
                .pickerStyle(WheelPickerStyle())
                .onChange(of: userSelectedyear, perform: { newValue in
                    print("Selected Unit: \(SelectedYear[newValue])")
                    year = Int(SelectedYear[newValue]) ?? 0
                    
                })
                
            }
            
        }.onAppear(){
            for i in 0..<31{
                let seled = String(i + 2021)
                let selecDays = String(i + 1)
                SelectedYear.append(seled)
                SelectedDay.append(selecDays)
                if i < 12{
                    let months = String(i + 1)
                    selectedMonth.append(months)
                }
                //print(seled)
            }
            let date = Date()
            
            // MARK: Way 1

            let components = date.get(.day, .month, .year)
            day = components.day ?? 0
            month = components.month ?? 0
            year = components.year ?? 0
                print("day: \(day), month: \(month), year: \(year)")
            
            
//                        let date = Date()
//                        let dateFormatter = DateFormatter()
//                        let timeFormatter = DateFormatter()
//                        timeFormatter.dateFormat = "yyyy-MM-dd"
//                        let dateTime = timeFormatter.string(from: date)
//
//
//                        SelectedYear.
        }
        
        
    }
    
    
}


struct WatchDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        WatchDatePicker(day: .constant(0), year: .constant(0), month: .constant(0))
    }
}


extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
