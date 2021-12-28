//
//  ProductDetailsNavigator.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 28/12/2021.
//

import UIKit

protocol ProductDetailsNavigatorType {
    
}

struct ProductDetailsNavigator: ProductDetailsNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
