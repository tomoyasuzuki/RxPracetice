//
//  ViewModel.swift
//  MVVMwithRx
//
//  Created by 鈴木友也 on 2019/04/23.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import RxSwift

final class ViewModel {
    let validationText:Observable<String>
    let loadLabelColor:Observable<UIColor>
    
    init(idTextObservable: Observable<String?>,
         passwordTextObservable: Observable<String?>,
         model: ModelProtocol) {
        let event = Observable
            .combineLatest(idTextObservable,passwordTextObservable)
            .skip(1)
            .flatMap { (idText,passwordText) -> Observable<Event<Void>> in
                return model
                    .validate(idText: idText, passwordText: passwordText)
                    .materialize()
        }
        .share()
        self.validationText = event
            .flatMap { event -> Observable<String> in
                switch event {
                case .next: return .just("OK")
                case let .error(error as ModelError):
                    return .just(error.errorText)
                case .error, .completed: return .empty()
                }
        }
        
        .startWith("idとpasswordを入力してください")
    
        self.loadLabelColor = event
            .flatMap { event -> Observable<UIColor> in
                switch event {
                case .next: return .just(.green)
                case . error: return .just(.red)
                case .completed: return .empty()
                }
        }
    }
}

extension ModelError {
    fileprivate var errorText: String {
        switch self {
        case .invalidIdAndPassword: return "IDとpasswordが未入力です"
        case .invalidId: return "idが未入力です"
        case .invalidPassword: return "passwordが未入力です"
        case .unexpectedError: return "予期せぬエラーが発生しました" 
        }
    }
}
