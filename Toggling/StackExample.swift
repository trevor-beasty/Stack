//
//  StackExample.swift
//  Toggling
//
//  Created by Trevor Beasty on 3/7/19.
//  Copyright © 2019 Trevor Beasty. All rights reserved.
//

import UIKit

class StackedExample: UIViewController, StackHost {
    
    var stack: [Stacked] = []
    
    var stackContainer: UIView { return view }
    
    let c0 = UIView.createComponent(color: .red, text: "I")
    let c1 = UIView.createComponent(color: .blue, text: "Came")
    let c2 = UIView.createComponent(color: .green, text: "To")
    let c3 = UIView.createComponent(color: .purple, text: "Get")
    let c4 = UIView.createComponent(color: .black, text: "It")
    let c5 = UIView.createComponent(color: .orange, text: "BOOM!!")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        stackViews([c0, c1, c2])
        
        insert(c3, deadline: .now() + 2.0)
        insert(c4, deadline: .now() + 3.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.slideUpAndOut(self.c2)
        }
        
    }
    
    func insert(_ view: UIView, deadline: DispatchTime) {
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.slideDownAndInAtBottom(view)
        }
    }
    
}
