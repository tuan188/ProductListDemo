//
//  CreateProductNavigator.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 31/12/2021.
//

import UIKit

protocol CreateProductNavigatorType {
    func dismiss()
}

struct CreateProductNavigator: CreateProductNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
