//
//  RemiListViewModel.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 06.07.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import Foundation
import Combine

class RemiListViewModel: ObservableObject {
    @Published var remiRepository = RemiRepository()
    @Published var remiCellViewModels = [RemiCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
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
    }
    
    func deleteRemi(at offsets: IndexSet) {
        remiRepository.deleteRemi(at: offsets)
    }
    
    func loadData() {
        remiRepository.loadData()
    }
}
