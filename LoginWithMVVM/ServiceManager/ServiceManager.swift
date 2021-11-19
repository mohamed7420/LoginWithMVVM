//
//  ServiceManager.swift
//  LoginWithMVVM
//
//  Created by Mohamed osama on 19/11/2021.
//

import Foundation
import Alamofire
import RxSwift


class ServiceManager{
    
    static let shared = ServiceManager()
    typealias successCompletion<T: Codable> =  (T) -> Void
    typealias failureCompletion = (Error) -> Void

    private init(){}
    
    func request<T: Codable>(url: URL , headers: HTTPHeaders , method: HTTPMethod , parameters: Parameters , parameterEncoding: ParameterEncoding , model: T.Type , success: @escaping successCompletion<T> , failture: @escaping failureCompletion){
        AF.request(url, method: method, parameters: parameters, encoding: parameterEncoding, headers: headers)
            .validate( statusCode: 200..<300)
            .responseJSON { response in
                switch response.result{
                case .success(let data):
                    guard let data = try? JSONSerialization.data(withJSONObject: data, options: []) else {return}
                    guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {return}
                    success(decodedData)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    failture(error)
                    break
                }
            
            }
        
    }

}
