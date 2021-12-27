//
//  ProductsViewModel.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import MGArchitecture
import RxSwift
import RxCocoa

struct ProductsViewModel {
    let navigator: ProductsNavigatorType
    let useCase: ProductsUseCaseType
}

// MARK: - ViewModel
extension ProductsViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let products: Driver<[Product]>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let products = input.loadTrigger
            .flatMapLatest {
                self.useCase.getProductList()
                    .asDriverOnErrorJustComplete()
            }
        
        return Output(
            products: products
        )
    }
}
