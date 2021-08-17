//
//  AlertHandler.swift
//  F5
//
//  Created by Qazi Ammar Arshad on 08/06/2021.
//

import SwiftUI

struct BannerModifier: ViewModifier {
    @Binding var model: BannerData?
    
    @State var timeRemaining = 0
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    func body(content: Content) -> some View {
        content.overlay(
            VStack {               // << holder container !!
                if model != nil {
                    VStack {
                        HStack(alignment: .center) {
                            Image(model?.image ?? "")
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(model?.title ?? "")
                                    .font(.headline)
                                if let message = model?.message {
                                    Text(message)
                                        .font(.footnote)
                                }
                            }.padding(7)
                            .offset(x: -15)
                            Spacer()
                            
                        }
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(model?.color)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        Spacer()
                    }
                    .padding()
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onTapGesture {
                        withAnimation {
                            model = nil
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { _ in
                                withAnimation {
                                    model = nil
                                }
                            }
                    )
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else {
                            model = nil
                        }
                    }
                }
            }
            .animation(.easeInOut)         // << here !!
        )
    }
}

struct BannerData: Identifiable {
    let id = UUID()
    let title: String
    let message: String?
    let color: Color
    let image : String
}
