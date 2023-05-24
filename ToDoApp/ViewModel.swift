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
        return
        label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return
        label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return
        label
    }()

    private lazy var actionDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return
        label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return
        label
    }()

    func configure(model: ToDoItem) {
        backgroundColor = .red
        nameLabel.text = model.name
        descriptionLabel.text = model.subscribe
        dateLabel.text = model.createDate.createDate()
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
        nameLabel.backgroundColor = .blue
        nameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(5)
            $0.trailing.greaterThanOrEqualToSuperview().inset(15)
        }
        descriptionLabel.backgroundColor = .green
        descriptionLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalTo(nameLabel.snp.bottom).inset(-5)
            $0.trailing.equalToSuperview().inset(15)
        }
        dateLabel.backgroundColor = .white
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-5)

        }
        actionDateLabel.backgroundColor = .cyan
        actionDateLabel.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-5)

        }
        statusLabel.backgroundColor = .purple
        statusLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalTo(dateLabel.snp.bottom).inset(-5)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}
