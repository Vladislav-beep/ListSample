//
//  ListCellsDataModel.swift
//  List
//
//  Created by Владислав Сизонов on 04.02.2023.
//

enum ListCellsDataModel: Hashable {
    case list1(List1CellDataModel)
    case list2(List2CellDataModel)
    case empty(EmptyCellDataModel)
}

struct List1CellDataModel: Hashable {
    let title: String
}

struct List2CellDataModel: Hashable {
    let title: String
    let subtitle: String
}

struct EmptyCellDataModel: Hashable {
    let title: String
    let subtitle: String
    let icon: String
}
