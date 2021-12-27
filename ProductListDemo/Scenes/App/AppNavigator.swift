//
//  AppNavigator.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMain() {
        let nav = UINavigationController()
        let vc: MainViewController = assembler.resolve(navigationController: nav)
        nav.viewControllers.append(vc)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
