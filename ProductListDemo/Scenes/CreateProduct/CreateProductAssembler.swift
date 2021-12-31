//
//  CreateProductAssembler.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 31/12/2021.
//

import UIKit
import Reusable

protocol CreateProductAssembler {
    func resolve(navigationController: UINavigationController) -> CreateProductViewController
    func resolve(navigationController: UINavigationController) -> CreateProductViewModel
    func resolve(navigationController: UINavigationController) -> CreateProductNavigatorType
    func resolve() -> CreateProductUseCaseType
}

extension CreateProductAssembler {
    func resolve(navigationController: UINavigationController) -> CreateProductViewController {
        let vc = CreateProductViewController.instantiate()
        let vm: CreateProductViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> CreateProductViewModel {
        return CreateProductViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension CreateProductAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CreateProductNavigatorType {
        return CreateProductNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> CreateProductUseCaseType {
        return CreateProductUseCase(productGateway: resolve())
    }
}
