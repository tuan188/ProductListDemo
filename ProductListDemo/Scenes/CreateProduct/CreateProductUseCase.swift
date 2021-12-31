//
//  CreateProductUseCase.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 31/12/2021.
//

import RxSwift

protocol CreateProductUseCaseType {
    func createProduct(_ product: Product) -> Observable<Product>
    func notifyCreatedProduct(_ product: Product)
}

struct CreateProductUseCase: CreateProductUseCaseType, CreateProduct {
    var productGateway: ProductGatewayType
    
    func notifyCreatedProduct(_ product: Product) {
        NotificationCenter.default.post(name: .createdProduct, object: product)
    }
}
