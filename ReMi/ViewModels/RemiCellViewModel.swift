//
//  RemiCellViewModel.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 06.07.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import Foundation
import Combine

class RemiCellViewModel: ObservableObject, Identifiable {
    
    @Published var remiRepository = RemiRepository()
    @Published var remi: Remi
    
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(remi: Remi) {
        self.remi = remi
        
        $remi
            .compactMap { remi in
                remi.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $remi
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { remi in
                self.remiRepository.updateRemi(remi)
            }
            .store(in: &cancellables)
    }
    
}
