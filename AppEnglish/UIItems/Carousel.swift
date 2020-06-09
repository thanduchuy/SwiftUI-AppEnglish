//
//  Carousel.swift
//  AppEnglish
//
//  Created by MacBook Pro on 5/13/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Carousel: UIViewRepresentable {
    var width : CGFloat
    @Binding var page : Int
    var height : CGFloat
    @Binding var dataRecipe : [String]
    @Binding var dataUse : [String]
    @Binding var dataSignal : String
    func makeCoordinator() -> Coordinator {
          
          return Carousel.Coordinator(parent1: self)
    }
    func makeUIView(context: Context) -> UIScrollView {
        let total = width * CGFloat(3)
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.contentSize = CGSize(width: total, height: 1.0)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        let view1 = UIHostingController(rootView: ListReview(dataRecipe: self.$dataRecipe,dataUse: self.$dataUse, dataSignal: self.$dataSignal))
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: self.height)
        view1.view.backgroundColor = .clear
        view.delegate = context.coordinator
        view.addSubview(view1.view)
        return view
    }
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    class Coordinator : NSObject,UIScrollViewDelegate{
        
        
        var parent : Carousel
        
        init(parent1: Carousel) {
            
        
            parent = parent1
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
            self.parent.page = page
        }
    }
}
