//
//  ProductDetailsAssembler.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 28/12/2021.
//

import UIKit
import Reusable

protocol ProductDetailsAssembler {
    func resolve(navigationController: UINavigationController, product: Product) -> ProductDetailsViewController
    func resolve(navigationController: UINavigationController, product: Product) -> ProductDetailsViewModel
    func resolve(navigationController: UINavigationController) -> ProductDetailsNavigatorType
    func resolve() -> ProductDetailsUseCaseType
}

extension ProductDetailsAssembler {
    func resolve(navigationController: UINavigationController, product: Product) -> ProductDetailsViewController {
        let vc = ProductDetailsViewController.instantiate()
        let vm: ProductDetailsViewModel = resolve(navigationController: navigationController, product: product)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController, product: Product) -> ProductDetailsViewModel {
        return ProductDetailsViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            product: product
        )
    }
}

extension ProductDetailsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> ProductDetailsNavigatorType {
        return ProductDetailsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> ProductDetailsUseCaseType {
        return ProductDetailsUseCase()
    }
}
