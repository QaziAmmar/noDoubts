//
//  HealthData.swift
//  NoDoubtsWatchApp Extension
//
//  Created by Qazi on 15/10/2021.
//

import SwiftUI
import HealthKit

struct HealthData: View {
    private var healthStore = HKHealthStore()
    @State var isAnimation = true
    var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    @State var date = Date()
        let heartRateQuantity = HKUnit(from: "count/min")
        
        @State private var value = 0
        
        var body: some View {
            VStack{
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: true){
                hearthDataView()
                RestingData()
                Spacer()
                }
          

            }.navigationTitle("Statistic")
            
            .onAppear(perform: start)
        }
    //MARK:- Hearth Data
    private func hearthDataView()-> some View{
        ZStack{
        Rectangle().frame(height: 95).foregroundColor(Color("HealthColor")).cornerRadius(10).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack{
                Text("Current").font(.system(size: 13, weight: .regular)).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading).padding(.leading, 10).padding(.top , 10)
                HStack(spacing: 2){
                Image("HeartRate")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .scaledToFit()
                    .padding(.top, 5)
                    .scaleEffect(self.isAnimation ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).speed(1))
                    .onAppear(){
                        self.isAnimation.toggle()
                    }
                    Text("\(value)")
                                                .fontWeight(.regular)
                                                .font(.system(size: 30))
                    Text("BPM")
                        .font(.system(size: 15))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.red)
                                                .padding(.bottom, 20.0)
                }.frame(height: 40).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading).padding(.leading , 10)
                HStack(spacing: -7){
                Text("58 BPM,").foregroundColor(Color("TimimngColor")) .font(.system(size: 13, weight: .regular)).padding(.leading, 10)
                    Text("\((Int(convertDateInto(formatter: dateFormat, date: date)) ?? 0) % 3)" + " minute ago").font(.system(size: 13, weight: .regular)).padding(.leading, 10).foregroundColor(Color("TimimngColor"))
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading).padding(.bottom, 5)
            }
        }
        
    }
    func convertDateInto(formatter: DateFormatter, date: Date) -> String {
        let time = formatter.string(from: date)
        return time
    }
    //MARK:- Resting Data
    private func RestingData()-> some View{
        ZStack{
        Rectangle().frame(height: 95).foregroundColor(Color("HealthColor")).cornerRadius(10).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack{
                Text("Resting Rate").font(.system(size: 13, weight: .regular)).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading).padding(.leading, 10).padding(.top , 10)
                HStack{
                    Text("\(value)")
                                                .fontWeight(.regular)
                                                .font(.system(size: 30))
                    Text("BPM")
                        .font(.system(size: 15))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.red)
                                                .padding(.bottom, 20.0)
                }.frame(height: 40).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading).padding(.leading , 10)
                HStack{
                    Text("Today").font(.system(size: 13, weight: .regular)).padding(.leading, 10).foregroundColor(Color("TimimngColor"))
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading).padding(.bottom, 5)
            }
        }
    }
    

        
        func start() {
            autorizeHealthKit()
            startHeartRateQuery(quantityTypeIdentifier: .heartRate)
        }
        
        func autorizeHealthKit() {
            let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]

            healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _,_ in }
        }
        
        private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
            
            // 1
            let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
            // 2
            let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
                query, samples, deletedObjects, queryAnchor, error in
                
                // 3
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
                
            self.process(samples, type: quantityTypeIdentifier)

            }
            
            // 4
            let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
            
            query.updateHandler = updateHandler
            
            // 5
            
            healthStore.execute(query)
        }
        
        private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
            var lastHeartRate = 0.0
            
            for sample in samples {
                if type == .heartRate {
                    lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
                }
                
                self.value = Int(lastHeartRate)
            }
        }
   
    }

    struct HealthData_Previews: PreviewProvider {
        static var previews: some View {
            HealthData()
        }
    }
