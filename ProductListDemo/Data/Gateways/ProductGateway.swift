//
//  ProductGateway.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import RxSwift

protocol ProductGatewayType {
    func getProductList() -> Observable<[Product]>
}

struct ProductGateway: ProductGatewayType {
//    let productRepository = ProductRepository()  // database
    
    func getProductList() -> Observable<[Product]> {
        return Observable.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let products = [
                    Product(id: 1, name: "iPhone", price: 1000),
                    Product(id: 2, name: "Macbook", price: 3000)
                ]

                observer.onNext(products)
            }

            return Disposables.create()
        }
        
//        return .just([
//            Product(id: 1, name: "iPhone", price: 1000),
//            Product(id: 2, name: "Macbook", price: 3000)
//        ])
        
        //        return productRepository.getProductList()
        
//        return API.shared.getProductList(API.GetProductListInput())
//                    .map { PagingInfo(page: 1, items: $0) }
    }
}

