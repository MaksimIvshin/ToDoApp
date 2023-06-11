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
        date.font = UIFont(name: "Inter-SemiBold", size: 32)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()

    private lazy var photoLabel: UIImageView = {
        var image = UIImageView(frame: CGRectMake(0, 0, 48, 48))
        image.image = Resources.Images.avatar
        image.translatesAutoresizingMaskIntoConstraints = true
        image.layer.cornerRadius = image.frame.size.width / 2
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()

    private lazy var completeLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = .white
        // как менять в рантайме?
        date.text =  "\(ToDoManagerImp.shared.toDoList.count) incomplete, 0 completed"
        date.font = UIFont(name: "Inter-SemiBold", size: 14)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()

    lazy var separatorForMainView: UILabel = {
        let separator = UILabel()
        separator.backgroundColor = Resources.Colors.separatofForNewTask
        separator.layer.cornerRadius = 4
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    private lazy var completeStackLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = .white
        date.text = "Incomplete"
        date.font = UIFont(name: "Inter-SemiBold", size: 18)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()


    private lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRectMake(0, 0, 56, 56))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 30)
        button.backgroundColor = Resources.Colors.buttonSave
        button.translatesAutoresizingMaskIntoConstraints = true
        button.layer.cornerRadius = button.frame.size.width / 2
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dateLabel)
        view.addSubview(tableView)
        view.addSubview(photoLabel)
        view.addSubview(completeLabel)
        view.addSubview(separatorForMainView)
        view.addSubview(addButton)
        view.addSubview(completeStackLabel)
        setupConstraints()
        customizeNavigationBar()
        initTableView()
    }
    
    func setupConstraints() {
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(76)
        }

        photoLabel.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(71)
            $0.leading.equalTo(dateLabel.snp.trailing).inset(68)
            $0.height.width.equalTo(48)
        }

        completeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(dateLabel.snp.bottom).inset(-8)
            $0.trailing.equalToSuperview().inset(179)
        }

        separatorForMainView.snp.makeConstraints {
            $0.top.equalTo(completeLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(2)
        }

        completeStackLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalTo(separatorForMainView.snp.bottom).inset(-16)

        }

        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.width.equalTo(56)
        }

        tableView.snp.makeConstraints{
            $0.top.equalTo(completeStackLabel.snp.bottom).inset(-16)
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
