//
//  DetailView.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 06.07.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var remiCellVM: RemiCellViewModel
    @State var rmiDesc: String
    @State var opacity = 1.0
  
    var body: some View {
        GeometryReader { geometry in
            LinearGradient(gradient: Gradient(colors: [Color(hex: "FFB812"), Color(hex: "79B3EE")]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack(spacing: 40) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(hex: "BF813C"))
                                .opacity(0.8)
                            RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 3).onAppear( perform: {
                                if #available(iOS 14.0, *) {
                                    UITextView.appearance().backgroundColor = .clear
                                }
                            })
                            VStack {
                                if #available(iOS 14.0, *) {
                                    ZStack {
                                        TextEditor(text: self.$remiCellVM.remi.remiDescription)
                                            .font(Font.headline.weight(.bold))
                                            .font(.system(size:28))
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.center)
                                            .background(Color.clear)
                                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.25)
                                        Text("Hello").opacity(0).padding(.all, 8)
                                    }
                                } else {
                                    TextField(self.remiCellVM.remi.remiDescription, text: self.$remiCellVM.remi.remiDescription)
                                        .font(Font.headline.weight(.bold))
                                        .font(.system(size:28))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.25)
                                }
                                
                                Text("label_edit_hint".localized)
                                    .font(.footnote)
                                    .foregroundColor(.black)
                                    .padding(.all)
                                    .opacity(0.6)
                            }
                        }.frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
                        .padding(.top, -55)
                        Text(String(self.remiCellVM.remi.count))
                            .bold()
                            .frame(width: geometry.size.width, height: 70)
                            .font(.system(size: 60))
                            .foregroundColor(.black)
                            .padding(.bottom, -100)
                            .padding(.top, -33)
                        Divider().accentColor(.gray).blur(radius: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "01D700"))
                                    .frame(width: 170, height: 200, alignment: .leading)
                                    .padding(.trailing, 100.0)
                                    .opacity(self.opacity)
                                    .onTapGesture {
                                        self.remiCellVM.remi.count = self.remiCellVM.remi.count + 1
                                        let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                                        impactMed.impactOccurred()
                                    }
                                    .overlay(
                                        ZStack {
                                            Text("+").bold().font(.largeTitle)
                                                .padding(.trailing, 100.0)
                                            Circle().stroke(Color.clear, lineWidth: 1)
                                                .frame(width: 175, height: 205)
                                                .padding(.trailing, 100.0)
                                            Circle().stroke(Color(hex: "01D700"), lineWidth: 5)
                                                .frame(width: 180, height: 210)
                                                .padding(.trailing, 100.0)
                                        }
                                        
                                    )
                                
                            }
                            
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "C20000"))
                                    .frame(width: 100, height: 120, alignment: .leading)
                                    .padding(.leading, 190)
                                    .padding(.top, -100)
                                    .onTapGesture {
                                        
                                        if self.remiCellVM.remi.count != 0 {
                                            self.remiCellVM.remi.count = self.remiCellVM.remi.count - 1
                                            let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                                            impactMed.impactOccurred()
                                        } else {
                                            let impactMedWarning = UINotificationFeedbackGenerator()
                                            impactMedWarning.notificationOccurred(.warning)
                                        }
                                        
                                        
                                    }
                                    .overlay(
                                        ZStack {
                                            Text("-").bold().font(.largeTitle)
                                                .padding(.leading, 190)
                                                .padding(.top, -70)
                                            Circle().stroke(Color.clear, lineWidth: 1)
                                                .frame(width: 105, height: 120)
                                                .padding(.leading, 190)
                                                .padding(.top, -100)
                                            Circle().stroke(Color(hex: "C20000"), lineWidth: 5)
                                                .frame(width: 110, height: 120)
                                                .padding(.leading, 190)
                                                .padding(.top, -100)
                                        }
                                        
                                    )
                                
                            }
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "4A4949"))
                                    .frame(width: 60, height: 120, alignment: .leading)
                                    .padding(.trailing, -30)
                                    .padding(.top, -60)
                                    .onTapGesture {
                                        self.remiCellVM.remi.count = 0
                                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                        impactMed.impactOccurred()
                                    }
                                    .overlay(
                                        ZStack {
                                            Image(systemName: "arrow.counterclockwise")
                                                .frame(width: 120, height: 120)
                                                .font(.system(size: 30, weight: .bold))
                                                .padding(.trailing, -30)
                                                .padding(.top, -65)
                                            Circle().stroke(Color.clear, lineWidth: 1)
                                                .frame(width: 65, height: 120)
                                                .padding(.trailing, -30)
                                                .padding(.top, -60)
                                            Circle().stroke(Color(hex: "4A4949"), lineWidth: 5)
                                                .frame(width: 70, height: 120)
                                                .padding(.trailing, -30)
                                                .padding(.top, -60)
                                        }
                                        
                                    )
                                
                            }
                        }.frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.9)
                )
            
        }
        .accentColor(.black)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(remiCellVM: RemiCellViewModel(remi: Remi(remiDescription: "This is a preview", count: 36)), rmiDesc: "This is a preview")
    }
}
