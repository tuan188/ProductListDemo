//
//  ProductGateway.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import RxSwift

protocol ProductGatewayType {
    func getProductList() -> Observable<[Product]>
    func createProduct(_ product: Product) -> Observable<Product>
}

final class ProductGateway: ProductGatewayType {
    static var products: [String: Product] = {
        let id1 = UUID().uuidString
        let id2 = UUID().uuidString
        
        return [
            id1: Product(id: id1, name: "iPhone", price: 1000),
            id2: Product(id: id2, name: "Macbook", price: 3000)
        ]
    }()
    
    func getProductList() -> Observable<[Product]> {
        return Observable.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let products = ProductGateway.products.values
                    .map { $0 }
                    .sorted(by: { $0.name > $1.name })
                
                observer.onNext(products)
            }

            return Disposables.create()
        }
    }
    
    func createProduct(_ product: Product) -> Observable<Product> {
        guard !product.name.isEmpty && product.price > 0 else {
            return Observable.error(CreateProductError(message: "Chưa nhập đủ thông tin sản phẩm"))
        }
        
        var product = product
        product.id = UUID().uuidString
        ProductGateway.products[product.id] = product
        return .just(product)
    }
}

