//
//  ProductsNavigator.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import UIKit

protocol ProductsNavigatorType {
    
}

struct ProductsNavigator: ProductsNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
