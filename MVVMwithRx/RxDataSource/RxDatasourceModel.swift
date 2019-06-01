//
//  RxDatasource.swift
//  MVVMwithRx
//
//  Created by 鈴木友也 on 2019/05/15.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

typealias SettingsSectionModel = SectionModel<SettingSections, SettingItems>

enum SettingSections {
    case account
    case common
    
    var headerHeight: CGFloat {
        return 40.0
    }
    
    var fotterHeight: CGFloat {
        return 1.0
    }
}


enum SettingItems {
    
    case account
    case security
    case notification
    case contents
    
    case sounds
    case dataUsing
    
    case description(text: String)
    
    var rowHeight: CGFloat {
        switch self {
        case .description:
            return 72.0
        default:
            return 48.0
        }
    }
    
    var title: String? {
        switch self {
        case .account:
            return "アカウント"
        case .security:
            return "セキュリティ"
        case .notification:
            return "お知らせ"
        case .contents:
            return "内容"
        case .sounds:
            return "サウンド設定"
        case .dataUsing:
            return "データ利用設定"
        case .description:
            return nil
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .account, .security, .notification, .contents, .sounds, .dataUsing:
            return .disclosureIndicator
        case .description:
            return .none
        }
    }
}

