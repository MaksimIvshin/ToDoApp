//
//  ViewController.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(add))
    } ()
    
    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scroll)
        scroll.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scroll.addSubview(stack)
        stack.snp.makeConstraints {
            $0.leading.trailing.equalTo(scroll.contentLayoutGuide)
            $0.top.equalTo(scroll.contentLayoutGuide.snp.top).inset(30)
            $0.bottom.equalTo(scroll.contentLayoutGuide.snp.bottom)
            $0.width.equalTo(scroll.frameLayoutGuide)
        }
        configure()
        customizeNavigationBar()
        
    }
    
    
    @objc private func add() {
        let addController = AddViewController.loadFromNib()
        addController.delegate = self
        self.present(addController, animated: true)
    }
    
    private func customizeNavigationBar () {
        navigationItem.title = "To Do List"
        navigationItem.setRightBarButton(addButton, animated: false)
    }
    
    private func configure() {
        stack.arrangedSubviews.forEach({ $0.removeFromSuperview()
        })
        let model = ToDoManagerImp.shared.fetchToDoList()
        model.forEach { model in
            let newToDoListView = ViewModel()
            newToDoListView.configure(model: model)
            stack.addArrangedSubview(newToDoListView)
        }
    }
}

extension ViewController: AddViewControllerDelegate {
    func updateHomeWorks() {
        configure()
    }
}

