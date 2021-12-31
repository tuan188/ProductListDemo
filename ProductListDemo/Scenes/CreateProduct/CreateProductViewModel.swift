//
//  CreateProductViewModel.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 31/12/2021.
//

import MGArchitecture
import RxSwift
import RxCocoa
import Foundation

struct CreateProductViewModel {
    let navigator: CreateProductNavigatorType
    let useCase: CreateProductUseCaseType
}

// MARK: - ViewModel
extension CreateProductViewModel: ViewModel {
    struct Input {
        let productName: Driver<String>
        let productPrice: Driver<String>
        let createProductTrigger: Driver<Void>
    }
    
    struct Output {
        let error: Driver<Error>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let errorTracker = ErrorTracker()
        let error = errorTracker.asDriver()
        
        let name = input.productName
            .startWith("")
        
        let price = input.productPrice
            .map { Double($0) }
            .unwrap()
            .startWith(0.0)
        
        input.createProductTrigger
            .withLatestFrom(Driver.combineLatest(name, price))
            .flatMapLatest { (name, price) -> Driver<Product> in
                let product = Product(id: "", name: name, price: price)
                return self.useCase.createProduct(product)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .drive(onNext: { product in
                print(product)
                self.useCase.notifyCreatedProduct(product)
                self.navigator.dismiss()
            })
            .disposed(by: disposeBag)
        
        return Output(error: error)
    }
}
