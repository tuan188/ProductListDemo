//
//  GetProductList.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import Foundation
import RxSwift

protocol GetProductList {
    var productGateway: ProductGatewayType { get }
}

extension GetProductList {
    func getProductList() -> Observable<[Product]> {
        return productGateway.getProductList()
    }
}
