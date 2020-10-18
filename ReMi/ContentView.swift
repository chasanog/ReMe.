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
    
    var body: some View {
        MainView(remiCellVM: RemiCellViewModel(remi: Remi(remiDescription: "", count: 0)), addButtonColor: .gray)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
