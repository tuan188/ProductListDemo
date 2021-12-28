//
//  ProductDetailsViewModel.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 28/12/2021.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct ProductDetailsViewModel {
    let navigator: ProductDetailsNavigatorType
    let useCase: ProductDetailsUseCaseType
    let product: Product
}

// MARK: - ViewModel
extension ProductDetailsViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let name: Driver<String>
        let price: Driver<Double>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let name = input.loadTrigger
            .map { self.product.name }
        
        let price = input.loadTrigger
            .map { self.product.price }
        
        return Output(name: name, price: price)
    }
}
