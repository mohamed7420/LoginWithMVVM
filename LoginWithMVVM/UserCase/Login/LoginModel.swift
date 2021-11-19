//
//  LoginModel.swift
//  LoginWithMVVM
//
//  Created by Mohamed osama on 19/11/2021.
//

import Foundation


struct LoginModel: Codable{
    let userName: String
    let password: String
}

struct LoginModelResponse: Codable{
    let statusCode: Int
    let msg: String
}
