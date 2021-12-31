//
//  ProductsNavigator.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import UIKit

protocol ProductsNavigatorType {
    func toProductDetail(product: Product)
    func toCreateProduct()
}

struct ProductsNavigator: ProductsNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toProductDetail(product: Product) {
        print("To product", product.name)
        
        let vc: ProductDetailsViewController = assembler.resolve(
            navigationController: navigationController,
            product: product
        )
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toCreateProduct() {
        let nav = UINavigationController()
        let vc: CreateProductViewController = assembler.resolve(navigationController: nav)
        nav.viewControllers = [vc]
        nav.modalPresentationStyle = .fullScreen
        
        navigationController.present(nav, animated: true, completion: nil)
    }
}
