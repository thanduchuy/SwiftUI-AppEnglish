//
//  ContentView.swift
//  EnglishApp
//
//  Created by MacBook Pro on 4/24/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isActive = true
    var body: some View {
        GeometryReader { read in
            if self.isActive {
                WelcomeView(isActive: self.$isActive)
            } else {
                MennuView()
            }
        }.animation(.easeInOut(duration: 1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
