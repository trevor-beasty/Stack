//
//  AppDelegate.swift
//  Toggling
//
//  Created by Trevor Beasty on 3/6/19.
//  Copyright © 2019 Trevor Beasty. All rights reserved.
//

import UIKit

enum ToggleOption {
    case flat
    case compound
}

extension ToggleOption {
    
    var viewController: UIViewController {
        switch self {
        case .flat: return FlatToggle()
        case .compound: return CompoundToggle()
        }
    }
    
}

let toggleOption: ToggleOption = .compound

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = toggleOption.viewController
        return true
    }

}

