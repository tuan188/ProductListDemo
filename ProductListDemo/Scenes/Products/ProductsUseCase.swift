//
//  ProductsUseCase.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import RxSwift

// scene usecases / screen use cases
protocol ProductsUseCaseType {
    func getProductList() -> Observable<[Product]>
}

struct ProductsUseCase: ProductsUseCaseType, GetProductList {
    var productGateway: ProductGatewayType
    
}
