//
//  Assembler.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

protocol Assembler: AnyObject,
                    MainAssembler,
                    AppAssembler,
                    ProductsAssembler,
                    ProductDetailsAssembler,
                    GatewaysAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
