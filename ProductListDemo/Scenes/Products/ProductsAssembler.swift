//
//  ProductsAssembler.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import UIKit
import Reusable

protocol ProductsAssembler {
    func resolve(navigationController: UINavigationController) -> ProductsViewController
    func resolve(navigationController: UINavigationController) -> ProductsViewModel
    func resolve(navigationController: UINavigationController) -> ProductsNavigatorType
    func resolve() -> ProductsUseCaseType
}

extension ProductsAssembler {
    func resolve(navigationController: UINavigationController) -> ProductsViewController {
        let vc = ProductsViewController.instantiate()
        let vm: ProductsViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> ProductsViewModel {
        return ProductsViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension ProductsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ProductsNavigatorType {
        return ProductsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> ProductsUseCaseType {
        return ProductsUseCase(productGateway: resolve())
    }
}
