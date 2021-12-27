//
//  GatewaysAssembler.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import UIKit

protocol GatewaysAssembler {
    func resolve() -> ProductGatewayType
}

extension GatewaysAssembler where Self: DefaultAssembler {
    func resolve() -> ProductGatewayType {
        return ProductGateway()
    }
}
