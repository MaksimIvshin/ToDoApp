//
//  ViewModel.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 23.05.23.
//

import UIKit
import SnapKit

final class ViewModel: UIView {
    
    var date: Date?
    
    private lazy var stackWithItems: UIView = {
        var stack = UIView()
        stack.backgroundColor = .blue
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var actionDateLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.addTarget(self, action: #selector(statusChange), for: .valueChanged)
        return toggle
    }()
    
    private lazy var statusLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()

    func configure(model: ToDoItem) {
        backgroundColor = .white
        nameLabel.text = model.name
        descriptionLabel.text = model.subscribe
        dateLabel.text = "Start: \(model.createDate.create(with: .simple))"
        actionDateLabel.text = "Deadline: \(model.actionDate.create(with: .simple))"
        statusLabel.text = "Status: \(model.isFinished)"
        date = model.createDate
        toggle.setOn(model.isFinished, animated: false)
        addSubviews()
        setupConstraints()
       }
    
    func addSubviews() {
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(dateLabel)
        addSubview(actionDateLabel)
        addSubview(statusLabel)
        addSubview(toggle)
    }
    
    func setupConstraints() {
        nameLabel.layer.masksToBounds = true
        nameLabel.backgroundColor = .white
        nameLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(10)
        }
        
        descriptionLabel.layer.masksToBounds = true
        descriptionLabel.backgroundColor = .white
        descriptionLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(nameLabel.snp.bottom).inset(-10)
        }
        
        dateLabel.layer.masksToBounds = true
        dateLabel.backgroundColor = .white
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-10)
        }
        
        actionDateLabel.layer.masksToBounds = true
        actionDateLabel.backgroundColor = .white
        actionDateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalTo(dateLabel.snp.bottom).inset(-10)
        }
        
        statusLabel.layer.masksToBounds = true
        statusLabel.backgroundColor = .white
        statusLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalTo(actionDateLabel.snp.bottom).inset(-7)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        toggle.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(statusLabel).inset(0)
            $0.bottom.equalTo(statusLabel).inset(0)
        }
    }
    
    @objc private func statusChange(_ sender: UISwitch) {
        guard let date else {
            assertionFailure("error - date not found")
            return
        }
        ToDoManagerImp.shared.toggle(modelWith: date)
    }
}
