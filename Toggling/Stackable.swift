//
//  Stackable.swift
//  Toggling
//
//  Created by Trevor Beasty on 3/7/19.
//  Copyright © 2019 Trevor Beasty. All rights reserved.
//

import UIKit

protocol StackHost: AnyObject {
    var stack: [Stacked] { get set }
    var stackContainer: UIView { get }
}

class Stacked {
    
    var previous: Stacked? = nil
    var next: Stacked? = nil
    
    let view: UIView
    var toAboveY: NSLayoutConstraint? = nil
    var horizontalConstraints: [NSLayoutConstraint] = []
    
    init(_ view: UIView) {
        self.view = view
    }
    
    enum RelativePosition {
        case beneath
        case behind
    }
    
}

extension StackHost {
    
    func stackViews(_ views: [UIView]) {
        self.stack.forEach({
            $0.view.removeFromSuperview()
        })
        let stack = views.map({ return setUp($0) })
        for (i, stacked) in stack.enumerated() {
            if i == 0 {
                stacked.bindTo(stackContainer)
            }
            else {
                stacked.bindTo(stack[i - 1], relativePosition: .beneath)
            }
        }
        self.stack = stack
    }
    
    func slideDownAndIn(_ view: UIView, beneath: UIView) {
        guard let high = stacked(beneath), stacked(view) == nil else { fatalError() }
        let middle = setUp(view)
        let low = stackedBeneath(high)
        middle.bindTo(high, relativePosition: .behind)
        stackContainer.layoutIfNeeded()
        UIView.animate(withDuration: 1.0) {
            middle.bindTo(high, relativePosition: .beneath)
            low?.bindTo(middle, relativePosition: .beneath)
            self.stackContainer.layoutIfNeeded()
        }
    }
    
    func slideDownAndInAtBottom(_ view: UIView) {
        guard let bottom = views.last else { fatalError() }
        slideDownAndIn(view, beneath: bottom)
    }
    
    func slideUpAndOut(_ view: UIView) {
        
    }
    
    var views: [UIView] {
        return stack.map({ return $0.view })
    }
    
    func stackedBeneath(_ stacked: Stacked) -> Stacked? {
        guard
            let i = stack.firstIndex(where: { $0 === stacked }),
            i < stack.count - 1
            else { return nil }
        return stack[i + 1]
    }
    
    func stackedAbove(_ stacked: Stacked) -> Stacked? {
        guard
            let i = stack.firstIndex(where: { $0 === stacked }),
            i > 0
            else { return nil }
        return stack[i - 1]
    }
    
    func stacked(_ view: UIView) -> Stacked? {
        return stack.first(where: { $0.view === view })
    }
    
    func setUp(_ view: UIView) -> Stacked {
        guard !views.contains(view) else { fatalError() }
        view.translatesAutoresizingMaskIntoConstraints = false
        stackContainer.addSubview(view)
        let horizontalConstraints = [
            view.leftAnchor.constraint(equalTo: stackContainer.leftAnchor),
            view.rightAnchor.constraint(equalTo: stackContainer.rightAnchor)
        ]
        NSLayoutConstraint.activate(horizontalConstraints)
        let stacked = Stacked(view)
        stacked.horizontalConstraints = horizontalConstraints
        return stacked
    }
    
}

extension Stacked {
    
    func bindTo(_ above: Stacked, relativePosition: RelativePosition) {
        self.toAboveY?.isActive = false
        let toAboveY: NSLayoutConstraint
        switch relativePosition {
        case .behind:
            toAboveY = view.bottomAnchor.constraint(equalTo: above.view.bottomAnchor)
        case .beneath:
            toAboveY = view.topAnchor.constraint(equalTo: above.view.bottomAnchor)
        }
        toAboveY.isActive = true
        self.toAboveY = toAboveY
    }
    
    func bindTo(_ container: UIView) {
        self.toAboveY?.isActive = false
        let toAboveY = view.topAnchor.constraint(equalTo: container.topAnchor)
        toAboveY.isActive = true
        self.toAboveY = toAboveY
    }
    
}
