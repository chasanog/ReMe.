//
//  MainView.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 17.10.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @ObservedObject var remiListVM = RemiListViewModel()
    @ObservedObject var remiCellVM: RemiCellViewModel
    var onCommit: (Remi) -> (Void) = {_ in}
    
    @State var presentAddNewItem = false
    @State var presentInfoModal = false
    @State var addButtonColor: Color
    @State var presentInfo = false
    let email = "cshdev.team@gmail.com"
    @State private var keyboardHeight: CGFloat = 0
    
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
                            .listRowBackground(Color.clear)
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
                        .navigationBarTitle("ReMee").foregroundColor(.black)
                        
                        Button(action: {self.presentInfo.toggle()}) {
                            VStack(alignment: .trailing) {
                                Image(systemName: "info.circle")
                                    .renderingMode(.original)
                                    .font(.system(size: 24))
                                    .padding(.all)
                            }.sheet(isPresented: self.$presentInfo) {
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [Color(hex: "FFB812"), Color(hex: "79B3EE")]), startPoint: .bottom, endPoint: .top)
                                        .edgesIgnoringSafeArea(.all)
                                    VStack(alignment: .center) {
                                        VStack(alignment: .center) {
                                            Text("ReMee")
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
                                                    .frame(width: 150, height:50, alignment: .center)
                                                    .padding(.all)
                                            }
                                        }
                                        .frame(width: 150, height: 50, alignment: .center)
                                    }
                                }
                                
                            }
                        }
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
                                                                            .padding(.leading, UIScreen.main.bounds.width * 0.69)
                                                                    }
                                                                }
                                                                
                                                                Spacer(minLength: 50)
                                                                RoundedRectangle(cornerRadius: 15).fill(
                                                                    Color(hex: "BF813C")
                                                                ).overlay(
                                                                    ZStack {
                                                                        TextField("label_placeholder".localized, text: self.$remiCellVM.remi.remiDescription, onCommit: {
                                                                            self.onCommit(self.remiCellVM.remi)
                                                                        }).foregroundColor(.black)
                                                                        .padding()
                                                                        
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
                                                            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0}.animation(.easeInOut(duration: 0.3))
                                                        )
                                                }
                                            }
                                        }.onDisappear(perform: self.remiListVM.loadData)
                )}
            
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(remiCellVM: RemiCellViewModel(remi: Remi(remiDescription: "Test ReMe", count: 0)), addButtonColor: .gray)
    }
}

struct RemiCell: View {
    @ObservedObject var remiCellVM: RemiCellViewModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 15).fill(
                    Color(hex: "BF813C")
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
    }
}
extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
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
