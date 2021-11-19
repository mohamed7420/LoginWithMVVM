//
//  LoginViewController.swift
//  LoginWithMVVM
//
//  Created by Mohamed osama on 19/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

    
    //MARK:- IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ValidateViews()
        login()
    }
    
    
    private func ValidateViews(){
        userNameTextField.rx.text.map{$0 ?? ""}.bind(to: loginViewModel.userName).disposed(by: disposeBage)
        passwordTextField.rx.text.map{$0 ?? ""}.bind(to: loginViewModel.password).disposed(by: disposeBage)
        loginViewModel.isValidate().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBage)
        print(loginViewModel.userName.value)
        print(loginViewModel.password.value)
    }
    
    private func login(){
       
        
        userNameTextField.rx.text.orEmpty.bind(to: loginViewModel.userName).disposed(by: disposeBage)
        passwordTextField.rx.text.orEmpty.bind(to: loginViewModel.password).disposed(by: disposeBage)
        loginButton.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext:{[weak self] in
            self?.loginViewModel.login()
        }).disposed(by: disposeBage)
    }

}
