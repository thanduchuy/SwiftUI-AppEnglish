//
//  ListReview.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/13/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ListReview: View {
    @Binding var dataRecipe : [String]
    @Binding var dataUse : [String]
    @Binding var dataSignal : String
    var body: some View {
        HStack(spacing: 0) {
            ItemRecipe(width: UIScreen.main.bounds.width, data:  Binding.constant(self.dataRecipe))
            ItemUse(width: UIScreen.main.bounds.width, data:  Binding.constant(self.dataUse))
            ItemSignal(width: UIScreen.main.bounds.width, data:  Binding.constant(self.dataSignal))
        }
    }
}

