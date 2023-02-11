//
//  DetailsViewController.swift
//  List
//
//  Created by Владислав Сизонов on 11.02.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: Private properties
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        subtitleLabel.textColor = .gray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    // MARK: Lifecycle
    
    init(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: Private
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
