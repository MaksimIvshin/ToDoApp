//
//  ViewController.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var models: [ToDoItem] { ToDoManagerImp.shared.fetchToDoList() }
    
    private lazy var dateLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = .white
        date.text = Date().create(with: .titleDate).capitalized
        date.font = UIFont(name: "Arial", size: 32)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .gray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(add))
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dateLabel)
        view.addSubview(tableView)
        setupConstraints()
        customizeNavigationBar()
        initTableView()
    }
    
    func setupConstraints() {
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(70)
        }
        tableView.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).inset(-40)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc private func add() {
        let addController = AddToDoController()
        addController.delegate = self
        navigationController?.pushViewController(addController, animated: false)
    }
    
    private func customizeNavigationBar () {
        navigationItem.setRightBarButton(addButton, animated: false)
        navigationController?.navigationBar.backIndicatorImage = Resources.Images.buttonBack
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = Resources.Images.buttonBack
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "To go back", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
}

extension ViewController: AddViewControllerDelegate {
    func updateHomeWorks() {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerWithoutXib(cellClasses: TableViewCell.self)
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        models.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let customCell: TableViewCell = tableView.dequeueReusableCell(for: indexPath)
        else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        customCell.configure(with: model)
        return customCell
    }
}
