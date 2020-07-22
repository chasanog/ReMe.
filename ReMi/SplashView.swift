//
//  SplashView.swift
//  ReMi
//
//  Created by Cihan Hasanoglu on 08.07.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                ContentView(remiCellVM: RemiCellViewModel(remi: Remi(remiDescription: "", count: 0)))
            } else {
                Image("splashScreen")
                    .renderingMode(.original)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.isActive = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
