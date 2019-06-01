//
//  ViewController.swift
//  MVVMwithRx
//
//  Created by 鈴木友也 on 2019/04/23.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
   
    private lazy var viewModel = ViewModel(
        idTextObservable: idTextField.rx.text.asObservable(),
        passwordTextObservable: passwordTextField.rx.text.asObservable(),
        model:Model()
    )
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // サイズ設定
        idTextField.frame.size = CGSize(width: 300, height: 30)
        passwordTextField.frame.size = CGSize(width: 300, height: 30)
        validationLabel.frame.size = CGSize(width: 300, height: 40)
        
        // UI部品の基本設定
        
        container.backgroundColor = UIColor.white
        idTextField.placeholder = "idを入力してください"
        idTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "passwordを入力してください"
        passwordTextField.borderStyle = .roundedRect
        validationLabel.text = "Login"
        validationLabel.textColor = UIColor.white
        validationLabel.backgroundColor = UIColor.black
        validationLabel.textAlignment = .center
        // 追加
        
        self.view.addSubview(container)
        self.container.addSubview(idTextField)
        self.container.addSubview(passwordTextField)
        self.container.addSubview(validationLabel)
        // レイアウト設定
        
        container.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        idTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(200)
            make.width.equalTo(300)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(260)
            make.width.equalTo(300)
        }
        validationLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(320)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        viewModel.validationText
            .bind(to:validationLabel.rx.text)
            .disposed(by:disposeBag)
        
        viewModel.loadLabelColor
            .bind(to: loadLabelColor)
            .disposed(by:disposeBag)
    }
    // UI部品を生成
    
    let container:UIView =  {
        let container = UIView()
        return container
    }()
    let idTextField:UITextField = {
        let idTextField = UITextField()
        return idTextField
    }()
    let passwordTextField:UITextField =  {
        let passwordTextField = UITextField()
        return passwordTextField
    }()
    let validationLabel:UILabel =  {
        let validationLabel = UILabel()
        return validationLabel
    }()
    
    private var loadLabelColor: Binder<UIColor> {
        return Binder(self) { me, color in
            me.validationLabel.textColor = color
        }
    }
}

