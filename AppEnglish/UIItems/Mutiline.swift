//
//  Mutiline.swift
//  AppEnglish
//
//  Created by MacBook Pro on 4/28/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Mutiline: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = UIFont.systemFont(ofSize: 22)
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
