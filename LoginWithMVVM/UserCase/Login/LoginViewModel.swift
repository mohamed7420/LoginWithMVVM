//
//  LoginViewModel.swift
//  LoginWithMVVM
//
//  Created by Mohamed osama on 19/11/2021.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire


class LoginViewModel{
   
    
    var userName = BehaviorRelay<String>.init(value: "")
    var password = BehaviorRelay<String>.init(value: "")
    var responseSubject = PublishSubject<LoginModelResponse>()
    let serviceInstance = ServiceManager.shared
   
    func login(){
     
        guard let url = URL(string: Constant.baseURL + Constant.login) else {return}
      
        let params = [
            "username": userName.value,
            "password": password.value
        ]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        serviceInstance.request(url: url , headers: headers, method: .post, parameters: params, parameterEncoding: URLEncoding.default, model: LoginModelResponse.self) {[weak self] response in
            guard let self = self else {return}
            self.responseSubject.onNext(response)
        } failture: { error in
            self.responseSubject.onError(error)
        }
    }
    
    func isValidate() -> Observable<Bool>{
        return Observable.combineLatest(userName.asObservable() , password.asObservable()).map { userName , password in
            return userName.count > 3 && password.count > 3
        }.startWith(false)
    }
}
