//
//  textValidationViewModel.swift
//  MVVMwithRx
//
//  Created by 鈴木友也 on 2019/05/28.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TextValidationViewModel {
    var validationUserName: Observable<String>
    var validationPassword: Observable<String>
    
    init(userNameObservable: Observable<String?>, passwordObservable: Observable<String?>) {
        let model = textValidationModel()
        
        validationUserName =
            userNameObservable
                .flatMap { username -> Observable<Event<()>> in
                    return model.validateUseName(userName: username!)
                    .materialize()
                }
                .share()
                .flatMap { event -> Observable<String> in
                    switch event {
                    case .next:
                        return Observable.just("OK")
                    case let .error(error as ValidateError):
                        return Observable.just(error.errorText)
                    case .error,.completed:
                        return Observable.empty()
                    }
                }
                .startWith("ユーザーネームを入力してください")
        
        validationPassword =
            passwordObservable
                .flatMap { password -> Observable<Event<()>> in
                    return model.validatePassword(password: password!)
                    .materialize()
                }
                .share()
                .flatMap { event -> Observable<String> in
                    switch event {
                    case .next:
                        return Observable.just("OK")
                    case let .error(error as ValidateError):
                        return Observable.just(error.errorText)
                    case .error, .completed:
                        return Observable.empty()
                    }
                }
                .startWith("パスワードを入力してください")
        
        
    }
}

extension ValidateError {
    var errorText: String {
        switch self {
        case .underThreCharacterUserName:
            return "ユーザーネームは三文字以上である必要があります"
        case .underSixCharacterPassword:
            return "パスワードは六文字以上にしてください"
        }
    }
}
