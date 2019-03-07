//
//  ViewController.swift
//  Toggling
//
//  Created by Trevor Beasty on 3/6/19.
//  Copyright © 2019 Trevor Beasty. All rights reserved.
//

import UIKit

class FlatToggle: UIViewController {
    
    let scroll = UIScrollView()
    let container = UIView()
    let stack = UIStackView()
    
    let tap = UITapGestureRecognizer()
    
    let c0 = FlatToggle.createComponent(color: .red)
    let c1 = FlatToggle.createComponent(color: .blue)
    let c2 = FlatToggle.createComponent(color: .green)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0
        
        view.addSubview(scroll)
        scroll.fillSuperview()
        
        scroll.addSubview(container)
        container.fillSuperview()
        container.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        container.addSubview(stack)
        stack.fillSuperview()
        
        [c0, c1, c2].forEach({
            stack.addArrangedSubview($0)
        })
        
        view.backgroundColor = .white
        
        tap.addTarget(self, action: #selector(didTap))
        c0.addGestureRecognizer(tap)
        
    }
    
    @objc func didTap() {
        toggleC1()
    }
    
    func toggleC1() {
        c1.alpha = c1.isHidden ? 1 : 0
        UIView.animate(withDuration: 1.0) {
            self.c1.isHidden = !self.c1.isHidden
        }
    }
    
    static func createComponent(color: UIColor) -> UIView {
        let component = UIView()
        component.translatesAutoresizingMaskIntoConstraints = false
        component.heightAnchor.constraint(equalToConstant: 100).isActive = true
        component.backgroundColor = color
        
        return component
    }
    
}

extension UIView {
    
    func fillSuperview() {
        guard let superview = superview else { fatalError() }
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
