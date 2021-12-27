//
//  APIOutput.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import ObjectMapper
import MGAPIService

class APIOutput: APIOutputBase {  // swiftlint:disable:this final_class
    var message: String?
    
    override func mapping(map: Map) {
        message <- map["message"]
    }
}
