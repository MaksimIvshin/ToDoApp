//
//  TableViewCell.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 2.06.23.
//

import UIKit

class TableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with model: ToDoItem) {
        self.contentView.subviews.forEach({ $0.removeFromSuperview() })
        let view = ViewModel()
        view.configure(model: model)
        self.contentView.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
