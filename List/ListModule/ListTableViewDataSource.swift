//
//  ListTableViewDataSource.swift
//  List
//
//  Created by Владислав Сизонов on 04.02.2023.
//

import UIKit

final class ListTableViewDataSource {
    
    // MARK: Public
    
    func makeDataSource(for tableview: UITableView) -> UITableViewDiffableDataSource<Int, ListCellsDataModel> {
        let tableViewDataSource = UITableViewDiffableDataSource<Int, ListCellsDataModel>(tableView: tableview) { tableView, indexPath, cellType in
            switch cellType {
            case .list1(let model):
                let cell = tableview.reuse(ListCell1.self, indexPath)
                let displayData = ListCell1.DisplayData(
                    title: model.title
                )
                cell.configure(with: displayData)
                return cell
                
            case .list2(let model):
                let cell = tableview.reuse(ListCell2.self, indexPath)
                let displayData = ListCell2.DisplayData(
                    title: model.title,
                    subtitle: model.subtitle
                )
                cell.configure(with: displayData)
                return cell
                
            case .empty(let model):
                let cell = tableview.reuse(EmptyCell.self, indexPath)
                let displayData = EmptyCell.DisplayData(
                    title: model.title,
                    subtitle: model.subtitle,
                    icon: model.icon
                )
                cell.configure(with: displayData)
                return cell
            }
        }

        return tableViewDataSource
    }
}

