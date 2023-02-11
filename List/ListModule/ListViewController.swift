//
//  ListViewController.swift
//  List
//
//  Created by Владислав Сизонов on 04.02.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: Private properties
    
    private let listTableView: UITableView = {
        let listTableView = UITableView()
        listTableView.register(ListCell1.self)
        listTableView.register(ListCell2.self)
        listTableView.register(EmptyCell.self)
        listTableView.separatorStyle = .none
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        return listTableView
    }()
    
    private lazy var addButton: UIButton = {
        let doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Add cell", for: .normal)
        doneButton.backgroundColor = .blue
        doneButton.layer.cornerRadius = 15
        doneButton.addTarget(self, action: #selector(addCell), for: .touchUpInside)
        return doneButton
    }()
    
    private lazy var deleteButton: UIButton = {
        let doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Delete cell", for: .normal)
        doneButton.backgroundColor = .red
        doneButton.layer.cornerRadius = 15
        doneButton.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        return doneButton
    }()
    
    private lazy var tableViewDataSource = ListTableViewDataSource().makeDataSource(for: listTableView)
    
    private var data = [
        ListCellsDataModel.list1(.init(title: "Title table view cell with only one label")),
        ListCellsDataModel.list2(.init(title: "Table view cell", subtitle: "This cell has subtitle")),
        ListCellsDataModel.list2(.init(title: "Second Table view cell", subtitle: "This cell has also a subtitle"))
    ]
    
    private var counter = 0
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateTableView()
        listTableView.delegate = self
    }
    
    // MARK: Private
    
    private func setupViews() {
        view.addSubview(listTableView)
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.heightAnchor.constraint(equalToConstant: 56),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func updateTableView() {
        let emptyCellModel = ListCellsDataModel.empty(.init(title: "No data", subtitle: "Table view has nothing to display", icon: "shoe"))
        if data.isEmpty {
            data.append(emptyCellModel)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, ListCellsDataModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(data, toSection: 0)
        tableViewDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [weak self] (action, view, completion) in
            guard let self = self else { return }
            
            guard let item = self.tableViewDataSource.itemIdentifier(for: indexPath) else { return }
            switch item {
            case .list1, .empty:
                break
                
            case .list2:
                self.data.remove(at: indexPath.item)
                self.updateTableView()
            }
            
            completion(true)
        }
        action.image = UIImage(systemName: "trash")
        return action
    }
    
    @objc func addCell() {
        counter += 1
        let emptyCellModel = ListCellsDataModel.empty(.init(title: "No data", subtitle: "Table view has nothing to display", icon: "shoe"))
        if data.contains(emptyCellModel) {
            data.remove(at: 0)
        }
        
        data.append(ListCellsDataModel.list2(.init(
            title: "Added cell \(counter)",
            subtitle: "This cell was added by button"
        )))
        updateTableView()
    }
    
    @objc func deleteCell() {
        if data.isEmpty {
            return
        }
        data.removeLast()
        updateTableView()
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = tableViewDataSource.itemIdentifier(for: indexPath) else { return }
        
        switch item {
        case .list2(let model):
            present(DetailsViewController(title: model.title, subtitle: model.subtitle), animated: true)
            
        case .list1, .empty:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let item = self.tableViewDataSource.itemIdentifier(for: indexPath) else { return nil }
        switch item {
        case .list1, .empty:
            return nil
            
        case .list2:
            let delete = deleteAction(at: indexPath)
            return UISwipeActionsConfiguration(actions: [delete])
        }
    }
}
