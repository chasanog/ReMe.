//
//  ContentView.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 06.07.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var remiListVM = RemiListViewModel()
    @ObservedObject var remiCellVM: RemiCellViewModel
    //    @State var showModal: Bool = false
    var onCommit: (Remi) -> (Void) = {_ in}
    
    @State var presentAddNewItem = false
    @State var presentInfoModal = false
    @State var addButtonColor: Color
    @State var presentInfo = false
    let email = "cshdev.team@gmail.com"
    @State private var keyboardHeight: CGFloat = 0
    //    let topColor = UIColor(red: 121/255.0, green: 179/255.0, blue: 238/255.0, alpha: 1.0)
    //    let bottomColor = UIColor(red: 255/255, green: 184/255, blue: 18/255, alpha: 1.0)
    //    private var gradientLayer = CAGradientLayer()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "FFB812"), Color(hex: "79B3EE")]), startPoint: .bottom, endPoint: .top)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        List {
                            ForEach(self.remiListVM.remiCellViewModels) { remiCellVM in
                                NavigationLink(destination: DetailView(remiCellVM: remiCellVM, rmiDesc: remiCellVM.remi.remiDescription)) {
                                    RemiCell(remiCellVM: remiCellVM)
                                }
                            }.onDelete { (index) in
                                self.remiListVM.deleteRemi(at: index)
                                
                            }
                        }
                        .onAppear{
                            self.remiListVM.loadData()
                            if #available(iOS 14.0, *) {
                                UITableView.appearance().separatorStyle = .none
                            } else {
                                UITableView.appearance().tableFooterView = UIView()
                            }
                            UITableView.appearance().separatorStyle = .none
                            UITableView.appearance().backgroundColor = .clear
                            UITableViewCell.appearance().backgroundColor = .clear
                            //                                UITableView.appearance().allowsSelection = false
                            UITableViewCell.appearance().selectionStyle = .none
                        }
                        .edgesIgnoringSafeArea(.all)
                        .environment(\.defaultMinListRowHeight, 100)
                            //            }
                            .navigationBarTitle("ReMe.").foregroundColor(.black)
                        
                        Button(action: {self.presentInfo.toggle()}) {
                            VStack(alignment: .trailing) {
                                Image(systemName: "info.circle")
                                    .renderingMode(.original)
//                                .resizable()
                                    .font(.system(size: 24))
                                    .padding(.all)
                                
                                    
                            }.sheet(isPresented: self.$presentInfo) {
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [Color(hex: "FFB812"), Color(hex: "79B3EE")]), startPoint: .bottom, endPoint: .top)
                                    .edgesIgnoringSafeArea(.all)
//                                    Spacer()
                                    VStack(alignment: .center) {
                                        
//                                        Spacer(minLength: 5)
//                                        .frame(height: UIScreen.main.bounds.height * 0.95)
                                        VStack(alignment: .center) {
                                            Text("ReMe.")
                                            .bold()
                                                .font(.largeTitle)
                                                .padding(.all)
                                                .padding(.top, geometry.size.height * 0.05 )
                                                .foregroundColor(.black)
                                                
                                            Text("info_text".localized)
                                                .padding(.all)
                                                .foregroundColor(.black)
                                            Text("info_text_feedback".localized)
                                                .padding(.all)
                                                .foregroundColor(.black)
                                            
                                            Button(self.email) {
                                                if let url = URL(string: "mailto:\(self.email)") {
                                                    if #available(iOS 10.0, *) {
                                                        UIApplication.shared.open(url)
                                                    } else {
                                                        UIApplication.shared.openURL(url)
                                                    }
                                                }
                                            }
                                        }
                                        Spacer()
                                        VStack(alignment: .center) {
                                            Button(action: {
                                                self.presentInfo = false
                                            }) {
                                                Text("label_dismiss".localized)
                                                    .bold()
                                                    .font(.title)
                                                    .foregroundColor(.black)
//                                                    .padding(.top, UIScreen.main.bounds.height * 0.025)
//                                                    .padding(.leading, 0)
                                                    .frame(width: 150, height:50, alignment: .center)
                                                    .padding(.all)
//                                                    .padding(.all)
//                                                    .padding(.leading, geometry.size.width * 0.3)
                                                
                                                
                                            }
                                        }
                                        .frame(width: 150, height: 50, alignment: .center)
//                                        .padding(.horizontal, UIScreen.main.bounds.width)
                                        
                                    }
//                                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.5)
                                    
//                                    )
                                }
                                
                            }
                            
                        }
                        
                        
                        
                        //                        )
                    }.edgesIgnoringSafeArea(.bottom)
                        .frame(minWidth: geometry.size.width, idealWidth: geometry.size.width, maxWidth: geometry.size.width, minHeight: geometry.size.height * 0.85,  idealHeight: geometry.size.height * 0.85, maxHeight: geometry.size.height * 0.85, alignment: .center)
                }.onAppear{
                    UINavigationBarAppearance().backgroundColor = UIColor.clear
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .accentColor(.black)
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: {self.presentAddNewItem.toggle()}) {
                            HStack(alignment: .center){
                                Text("label_new".localized).bold().font(.title).foregroundColor(.black)
                            }.sheet(isPresented: self.$presentAddNewItem) {
                                LinearGradient(gradient: Gradient(colors: [Color(hex: "FFB812"), Color(hex: "79B3EE")]), startPoint: .bottom, endPoint: .top)
                                    .edgesIgnoringSafeArea(.all)
                                    .overlay(
                                        VStack {
                                            VStack(alignment: .trailing) {
                                                Button(action: {
                                                    self.presentAddNewItem = false
                                                    self.remiListVM.loadData()
                                                    self.remiCellVM.remi.remiDescription = ""
                                                }) {
                                                    Text("label_dismiss".localized)
                                                        .bold()
                                                        .foregroundColor(.black)
                                                        .padding(.top)
                                                        .padding(.leading, UIScreen.main.bounds.width * 0.70)
                                                    
                                                }
                                            }
                                            
                                            Spacer(minLength: 50)
                                            RoundedRectangle(cornerRadius: 15).fill(
                                                Color(hex: "BF813C")
                                                //                    LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                //                                                            RadialGradient(gradient: Gradient(colors: [.white, .blue]), center: .center, startRadius: 1, endRadius: 150)
                                            ).overlay(
                                                ZStack {
                                                    TextField("label_placeholder".localized, text: self.$remiCellVM.remi.remiDescription, onCommit: {
                                                        self.onCommit(self.remiCellVM.remi)
                                                    }).padding()
                                                    
                                                    RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 3)
                                                }
                                                .opacity(0.8)
                                                
                                                
                                                
                                                
                                            )
                                                
                                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.1)
                                                .padding(.bottom, 50)
                                            Button(action: {
                                                self.remiListVM.addRemi(remi: Remi(remiDescription: self.remiCellVM.remi.remiDescription, count: 0))
                                                self.remiCellVM.remi.remiDescription = ""
                                                self.presentAddNewItem = false
                                                self.remiListVM.loadData()
                                              
                                            }) {
                                                Text("label_add".localized)
                                                    .bold()
                                                    .foregroundColor(.black)
                                                    .font(.title)
                                            
                                            }
                                            .disabled(self.remiCellVM.remi.remiDescription.isEmpty)
                                            .opacity(self.remiCellVM.remi.remiDescription.isEmpty ? 0.2 : 1.0)
                                            Spacer()
                                        }
                                        .padding()
                                        .padding(.bottom, self.keyboardHeight)
                                        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0}.animation(.easeInOut(duration: 0.3))
//                                        .onReceive(self.keyboardHeight = $0)
                                )
                            }
//                            .padding(.bottom, keyboardHeight)
//                            .onReceive(keyboardHeight) {self.keyboardHeight = $0}
                            //Keyboard offset
                            
                        }
                    }.onDisappear(perform: self.remiListVM.loadData)
                    
                )
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(remiCellVM: RemiCellViewModel(remi: Remi(remiDescription: "Test ReMe", count: 0)), addButtonColor: .gray)
    }
}

struct RemiCell: View {
    @ObservedObject var remiCellVM: RemiCellViewModel
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 15).fill(
                    Color(hex: "BF813C")
                    //                    LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    //                    RadialGradient(gradient: Gradient(colors: [.white, .blue]), center: .center, startRadius: 0, endRadius: 150)
                )
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.95)
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 3)
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(self.remiCellVM.remi.remiDescription)
                                        .bold()
                                        .padding(.leading, 15)
                                        .foregroundColor(.black)
                                        .font(.body)
                                    Spacer()
                                    Text(String(self.remiCellVM.remi.count))
                                        .bold()
                                        .padding(.trailing, 10)
                                        .foregroundColor(.black)
                                        .font(.title)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                        }
                        
                        
                )
                    .opacity(0.8)
                
                
                
            }
        }
        
        //            VStack {
        //                Image("Card")
        //                    .renderingMode(.original)
        //                    .overlay(
        //                        HStack {
        //                            Text(remiCellVM.remi.remiDescription)
        //                                .padding(.leading, 0)
        //                                .foregroundColor(.black)
        //                            Text(String(remiCellVM.remi.count))
        //                                .padding(.trailing, 10)
        //                                .foregroundColor(.black)
        //                    .font(.headline)
        //                        }
        //                )
        //        }
    }
}
extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
