//
//  textValidationModel.swift
//  MVVMwithRx
//
//  Created by 鈴木友也 on 2019/05/28.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class textValidationModel {
    func validateUseName(userName: String) -> Observable<()> {
        switch userName.count >= 3 {
        case true:
            return Observable.just(())
        case false:
            return Observable.error(ValidateError.underThreCharacterUserName)
        }
    }
    
    func validatePassword(password: String) -> Observable<()> {
        switch password.count >= 6 {
        case true:
            return Observable.just(())
        case false:
            return Observable.error(ValidateError.underSixCharacterPassword)
        }
    }
}

enum ValidateError: Error {
    case underThreCharacterUserName
    case underSixCharacterPassword
}
