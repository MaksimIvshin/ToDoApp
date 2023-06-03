//
//  ViewModel.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 23.05.23.
//

import UIKit

final class ViewModel: UIView {
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label = PaddingLabel(withInsets: 0, 0, 10, 10)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label = PaddingLabel(withInsets: 0, 0, 10, 10)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel()
        label = PaddingLabel(withInsets: 0, 0, 10, 10)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var actionDateLabel: UILabel = {
        var label = UILabel()
        label = PaddingLabel(withInsets: 0, 0, 10, 10)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        var label = UILabel()
        label = PaddingLabel(withInsets: 0, 0, 10, 10)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    func configure(model: ToDoItem) {
        backgroundColor = .lightGray
        nameLabel.text = model.name
        descriptionLabel.text = model.subscribe
        dateLabel.text = "Start: \(model.createDate.create(with: .titleDate))"
        actionDateLabel.text = "Deadline: \(model.actionDate.create(with: .titleDate))"
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
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(5)
            //$0.trailing.greaterThanOrEqualToSuperview().inset(15)
            $0.height.equalTo(50)
        }
        
        descriptionLabel.layer.masksToBounds = true
        descriptionLabel.layer.borderWidth = 1
        descriptionLabel.layer.cornerRadius = 7
        descriptionLabel.backgroundColor = .white
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


class PaddingLabel: UILabel {
    
    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat
    
    required init(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
