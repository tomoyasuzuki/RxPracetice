//
//  RxDataSourcesViewModel.swift
//  MVVMwithRx
//
//  Created by 鈴木友也 on 2019/05/15.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewModel {
    let items = BehaviorRelay<[SettingsSectionModel]>(value: [])
    
    var itemsObservable: Observable<[SettingsSectionModel]> {
        return items.asObservable()
    }
    
    func setUp() {
        updateItems()
    }
    
    func updateItems() {
        let sections: [SettingsSectionModel] = [
            accountSection(),
            commonSection()
        ]
        items.accept(sections)
    }
    
    private func accountSection() -> SettingsSectionModel {
        let items: [SettingItems] = [
            .account,
            .security,
            .notification,
            .contents
        ]
        return SettingsSectionModel(model: .account, items: items)
    }
    
    private func commonSection() -> SettingsSectionModel {
        let items: [SettingItems] = [
            .sounds,
            .dataUsing,
            .description(text: "適当な文字列")
        ]
        return SettingsSectionModel(model: .common, items: items)
    }
}
