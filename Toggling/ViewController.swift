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
    
    let c0 = UIView.createComponent(color: .red, text: "21")
    let c1 = UIView.createComponent(color: .blue, text: "Savage")
    let c2 = UIView.createComponent(color: .green, text: "21, 21, 21")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0
        
        scroll.fill(view)
        
        container.fill(scroll)
        container.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        stack.fill(container)
        
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
    
}

class CompoundToggle: UIViewController {
    
    let scroll = UIScrollView()
    let container = UIView()
    let stack = UIStackView()
    
    let tap = UITapGestureRecognizer()
    
    let c0 = CompoundToggleComponent()
    let c1 = CompoundToggleComponent()
    let c2 = CompoundToggleComponent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0
        
        scroll.fill(view)
        
        container.fill(scroll)
        container.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        stack.fill(container)
        
        [c0, c1, c2].forEach({
            stack.addArrangedSubview($0)
        })
        
        view.backgroundColor = .white
        
    }
    
}

class CompoundToggleComponent: UIView {
    
    let stack = UIStackView()
    let c0 = UIView.createComponent(color: .purple, text: "Tier X")
    let c1 = UIView.createComponent(color: .yellow, text: "Grapes all day!!")
    
    let tap = UITapGestureRecognizer()
    
    init() {
        super.init(frame: .zero)
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0
        
        stack.fill(self)
        
        [c0, c1].forEach({
            stack.addArrangedSubview($0)
        })
        
        tap.addTarget(self, action: #selector(didTap))
        c0.addGestureRecognizer(tap)
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    @objc func didTap() {
        toggleC1()
    }
    
    func toggleC1() {
        c1.alpha = c1.isHidden ? 1 : 0
        UIView.animate(withDuration: 1.0) {
            self.c1.isHidden = !self.c1.isHidden
            self.stack.layoutIfNeeded()
        }
    }
    
}

extension UIView {
    
    func fill(_ other: UIView) {
        other.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            leftAnchor.constraint(equalTo: other.leftAnchor),
            rightAnchor.constraint(equalTo: other.rightAnchor),
            topAnchor.constraint(equalTo: other.topAnchor),
            bottomAnchor.constraint(equalTo: other.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func centerIn(_ other: UIView) {
        other.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            centerXAnchor.constraint(equalTo: other.centerXAnchor),
            centerYAnchor.constraint(equalTo: other.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    static func createComponent(color: UIColor, text: String) -> UIView {
        let component = UIView()
        let label = UILabel()
        label.text = text
        label.centerIn(component)
        label.textColor = .white
        component.translatesAutoresizingMaskIntoConstraints = false
        component.heightAnchor.constraint(equalToConstant: 100).isActive = true
        component.backgroundColor = color
        
        return component
    }
    
}
