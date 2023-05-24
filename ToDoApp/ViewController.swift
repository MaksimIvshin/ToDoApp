//
//  ViewController.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

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
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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
    }

    private func configure() {
        let model = ToDoManagerImp.shared.getMockModel()
        for _ in (1...10) {
            let mainView = ViewModel()
            mainView.configure(model: model)
            stack.addArrangedSubview(mainView)
        }
    }
}
