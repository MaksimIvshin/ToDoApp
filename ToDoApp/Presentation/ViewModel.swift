//
//  ViewModel.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 23.05.23.
//

import UIKit

final class ViewModel: UIView {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var actionDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    func configure(model: ToDoItem) {
        backgroundColor = .lightGray
        nameLabel.text = model.name
        descriptionLabel.text = model.subscribe
        dateLabel.text = "Start: \(model.createDate.createDate())"
        actionDateLabel.text = "Deadline: \(model.actionDate.createDate())"
        statusLabel.text = "Status: \(model.state.rawValue)"
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(actionDateLabel)
        addSubview(statusLabel)
    }
    
    func setupConstraints() {
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.cornerRadius = 7
        nameLabel.backgroundColor = .white
        nameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(5)
            $0.trailing.greaterThanOrEqualToSuperview().inset(15)
            $0.height.equalTo(50)
        }
        descriptionLabel.layer.masksToBounds = true
        descriptionLabel.layer.borderWidth = 1
        descriptionLabel.layer.cornerRadius = 7
        descriptionLabel.backgroundColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(nameLabel.snp.bottom).inset(-5)
            $0.height.equalTo(50)
        }
        dateLabel.layer.masksToBounds = true
        dateLabel.layer.borderWidth = 1
        dateLabel.layer.cornerRadius = 7
        dateLabel.backgroundColor = .white
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-5)
            $0.height.equalTo(50)
        }
        actionDateLabel.layer.masksToBounds = true
        actionDateLabel.layer.borderWidth = 1
        actionDateLabel.layer.cornerRadius = 7
        actionDateLabel.backgroundColor = .white
        actionDateLabel.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-5)
            $0.height.equalTo(50)
        }
        statusLabel.layer.masksToBounds = true
        statusLabel.layer.borderWidth = 1
        statusLabel.layer.cornerRadius = 7
        statusLabel.backgroundColor = .white
        statusLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(dateLabel.snp.bottom).inset(-5)
            $0.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(50)
        }
    }
}
