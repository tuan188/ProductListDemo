//
//  APIError.swift
//  ProductListDemo
//
//  Created by Tuan Truong on 27/12/2021.
//

import MGAPIService
import Foundation

struct APIResponseError: APIError {
    let statusCode: Int?
    let message: String
    
    var errorDescription: String? {
        return message
    }
}
