//
//  RemiListViewModel.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 06.07.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

//@available(iOS 14.0, *)
class RemiListViewModel: ObservableObject {
    @Published var remiRepository = RemiRepository()
    @Published var remiCellViewModels = [RemiCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
//    @AppStorage("remee", store: UserDefaults(suiteName: "group.com.CSHDev.ReMee"))
//    var remeeData: Data = Data()
    
    init() {
        remiRepository.$remis.map { remis in
            remis.map { remi in
                RemiCellViewModel(remi: remi)
            }
        }
        .assign(to: \.remiCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addRemi(remi: Remi) {
        remiRepository.addRemi(remi)
//        guard let remeeData = try? JSONEncoder().encode(remi) else { return }
//        self.remeeData = remeeData
//        print("save \(remi)")
    }
    
    func deleteRemi(at offsets: IndexSet) {
        remiRepository.deleteRemi(at: offsets)
    }
    
    func loadData() {
        remiRepository.loadData()
    }
}
