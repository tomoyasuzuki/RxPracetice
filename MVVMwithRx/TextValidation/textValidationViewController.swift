//
//  textValidationViewController.swift
//  MVVMwithRx
//
//  Created by 鈴木友也 on 2019/05/28.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TextValidationViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    private lazy var  viewModel: TextValidationViewModel = TextValidationViewModel(userNameObservable: userNameTextField.rx.text.asObservable(), passwordObservable: passwordTextField.rx.text.asObservable())
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.validationUserName
            .bind(to: userValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.validationPassword
            .bind(to: passwordValidationLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
