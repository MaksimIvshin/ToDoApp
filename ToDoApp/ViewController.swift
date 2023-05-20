//
//  ViewController.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createToDoItem()
    }

    func createToDoItem() {
        view.backgroundColor = .lightGray
        let toDoItemView = UIView()
        view.addSubview(toDoItemView)
        toDoItemView.backgroundColor = .cyan
        toDoItemView.layer.cornerRadius = 20
        toDoItemView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(50)
            make.height.equalTo(200)
        }

        let nameToDoItemView = UILabel()
        nameToDoItemView.text = "Name"
        toDoItemView.addSubview(nameToDoItemView)
        nameToDoItemView.backgroundColor = .gray
        nameToDoItemView.layer.cornerRadius = 20
        nameToDoItemView.layer.masksToBounds = true
        nameToDoItemView.snp.makeConstraints { make in
            make.left.right.equalTo(toDoItemView).inset(10)
            make.height.equalTo(40)
            make.top.equalTo(toDoItemView).inset(10)
        }

        let dateToDoItemView = UILabel()
        dateToDoItemView.text = "Date"
        toDoItemView.addSubview(dateToDoItemView)
        dateToDoItemView.backgroundColor = .green
        dateToDoItemView.layer.cornerRadius = 20
        dateToDoItemView.layer.masksToBounds = true
        dateToDoItemView.snp.makeConstraints { make in
            make.top.equalTo(nameToDoItemView).inset(50)
            make.left.right.equalTo(toDoItemView).inset(10)
            make.height.equalTo(40)
        }
    }


//    func createToDoItemView() -> UIView? {
//        let toDoItemView = UIView()
//        view.addSubview(toDoItemView)
//        toDoItemView.translatesAutoresizingMaskIntoConstraints = false
//        toDoItemView.layer.cornerRadius = 15
//        toDoItemView.contentMode = UIView.ContentMode.scaleAspectFill
//        toDoItemView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
//        toDoItemView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500).isActive = true
//        toDoItemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        toDoItemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
//        toDoItemView.isUserInteractionEnabled = true
//        toDoItemView.layer.masksToBounds = true
//        toDoItemView.backgroundColor = .blue
//        return toDoItemView
//    }

}

