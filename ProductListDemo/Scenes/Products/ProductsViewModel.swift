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
        let selectProductTrigger: Driver<IndexPath>
        let editProductTrigger: Driver<IndexPath>
        let deleteProductTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let products: Driver<[Product]>
        let isLoading: Driver<Bool>
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let productsSubject = PublishSubject<[Product]>()
        let products = productsSubject.asDriverOnErrorJustComplete()
            .debug()
        
        let activityIndicator = ActivityIndicator()
        let isLoading = activityIndicator.asDriver()
        
        input.loadTrigger
            .flatMapLatest {
                return self.useCase.getProductList()
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .drive(onNext: { products in
                print(products)
                productsSubject.onNext(products)
            })
            .disposed(by: disposeBag)
        
        input.selectProductTrigger
            .withLatestFrom(products) { indexPath, products in
                return products[indexPath.row]
            }
            .drive(onNext: { product in
                self.navigator.toProductDetail(product: product)
            })
            .disposed(by: disposeBag)
        
        input.deleteProductTrigger
            .withLatestFrom(products) { indexPath, products in
                return (indexPath, products)
            }
            .drive(onNext: { indexPath, products in
//                let products = productsSubject.value  // stateful   stateless
                let product = products[indexPath.row]
                let updatedProducts = products.filter { $0.id != product.id }
                productsSubject.onNext(updatedProducts)
            })
            .disposed(by: disposeBag)
        
        input.editProductTrigger
            .withLatestFrom(products) { indexPath, products in
                return products[indexPath.row]
            }
            .drive(onNext: { product in
                print("Edit product", product.name)
            })
            .disposed(by: disposeBag)
        
        return Output(
            products: productsSubject.asDriverOnErrorJustComplete(),
            isLoading: isLoading
        )
    }
}
