//
//  RxDataSourcesViewController.swift
//  MVVMwithRx
//
//  Created by 鈴木友也 on 2019/05/15.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
  
    private lazy var datasource = RxTableViewSectionedReloadDataSource<SettingsSectionModel>(configureCell: configurecell)
    
    private lazy var configurecell: RxTableViewSectionedReloadDataSource<SettingsSectionModel>.ConfigureCell = { [weak self]
        
        (datasource, tableView, indexPath, _) in
        
        let item = datasource[indexPath]
        switch item {
        case .account,.security,.notification,.contents,.sounds,.dataUsing:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.accessoryType
            
            return cell
        case .description(let text):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = item.title
            cell.isUserInteractionEnabled = false
            
            return cell
        }
    }
    
    private var viewModel: SettingsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        setUpTableView()
        setUpViewModel()
    }
    
    private func setUpViewController() {
        navigationItem.title = "設定"
    }
    
    private func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12.0
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    private func setUpViewModel() {
        viewModel = SettingsViewModel()
        
        viewModel.items
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        viewModel.updateItems()
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = datasource[indexPath]
        return item.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heghtForHeaderInSection section: Int) -> CGFloat {
        let section = datasource[section]
        return section.model.headerHeight
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = datasource[section]
        return section.model.fotterHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}

