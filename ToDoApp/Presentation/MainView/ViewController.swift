//
//  ViewController.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit
import SnapKit
import UserNotifications
import NotificationCenter

class ViewController: UIViewController {
    
    let dataSource = MainControllerDataSource()
    
    private lazy var dateLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = Resources.Colors.backgroundAddView
        date.text = Date().create(with: .titleDate).capitalized
        date.font = UIFont(name: "Inter-SemiBold", size: 32)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private lazy var photoLabel: UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, 48, 48))
        image.isUserInteractionEnabled = true
        image.image = Resources.Images.photoApparat
        image.layer.borderColor = UIColor.gray.cgColor// цвет рамки
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = true
        image.layer.cornerRadius = image.frame.size.width / 2
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        let tapToImageAvatar = UITapGestureRecognizer(target: self, action: #selector(imageAvatarTapped))
        image.addGestureRecognizer(tapToImageAvatar)
        return image
    }()
    
    private lazy var incompleteLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = .white
        date.font = UIFont(name: "Inter-SemiBold", size: 14)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private lazy var completedLabel: UILabel = {
        let date = UILabel()
        date.backgroundColor = .white
        date.font = UIFont(name: "Inter-SemiBold", size: 14)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private var completedCount: Int? {
        didSet {
            if let completedCount {
                completedLabel.text = "Completed \(completedCount)"
                completedLabel.backgroundColor = Resources.Colors.backgroundAddView
            } else {
                completedLabel.text = ""
            }
        }
    }
    
    private var notCompletedCount: Int? {
        didSet {
            if let notCompletedCount {
                incompleteLabel.text = "Incomplete \(notCompletedCount)"
                incompleteLabel.backgroundColor = Resources.Colors.backgroundAddView
            } else {
                incompleteLabel.text = ""
            }
        }
    }
    
    lazy var separatorForMainView: UILabel = {
        let separator = UILabel()
        separator.backgroundColor = Resources.Colors.separatofForNewTask
        separator.layer.cornerRadius = 4
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImage()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        customizeNavigationBar()
        initTableView()
        updateHomeWorks()
        customizeViewController()
        ToDoManagerImp.shared.changeHandler = { [weak self] in
            self?.updateHomeWorks()
        }
    }

    private func addViews() {
        view.addSubview(dateLabel)
        view.addSubview(tableView)
        view.addSubview(photoLabel)
        view.addSubview(incompleteLabel)
        view.addSubview(completedLabel)
        view.addSubview(separatorForMainView)
        view.addSubview(addButton)
    }
    
    private func setupConstraints() {
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
        
        incompleteLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(dateLabel.snp.bottom).inset(-8)
            $0.trailing.equalToSuperview().inset(179)
        }
        
        completedLabel.snp.makeConstraints {
            $0.trailing.equalTo(incompleteLabel.snp.trailing).inset(0)
            $0.top.equalTo(dateLabel.snp.bottom).inset(-8)
        }
        
        separatorForMainView.snp.makeConstraints {
            $0.top.equalTo(incompleteLabel.snp.bottom).inset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(2)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.width.equalTo(56)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(separatorForMainView.snp.bottom).inset(-16)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    @objc private func imageAvatarTapped() {
        addImagePress()
    }

    @objc private func add() {
        let addController = AddToDoController()
        addController.delegate = self
        navigationController?.pushViewController(addController, animated: false)
    }
    
    private func customizeNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = Resources.Images.buttonBack
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = Resources.Images.buttonBack
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "To go back", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }

    private func customizeViewController() {
        view.backgroundColor = Resources.Colors.backgroundAddView
    }
    
    private func changeWorksCount(completed: Int, notCompleted: Int) {
        completedCount = completed
        notCompletedCount = notCompleted
    }
}

extension ViewController: AddViewControllerDelegate {
    func updateHomeWorks() {
        dataSource.updateToDoItems()
        changeWorksCount(completed: dataSource.completeCount, notCompleted: dataSource.notCompleteCount)
        tableView.reloadData()
        ToDoManagerImp.shared.saveData()
    }
}

extension ViewController:
    UITableViewDataSource,
    UITableViewDelegate {
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerWithoutXib(cellClasses: TableViewCell.self)
        tableView.reloadData()
        ToDoManagerImp.shared.saveData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.numberOfSections
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let label = UILabel()
        label.text = dataSource.getTitle(for: section)
        return label
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        dataSource.numberOfRowsInSection(section: section)
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
        let model = dataSource.getModel(for: indexPath)
        customCell.configure(with: model)
        return customCell
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    private func addImagePress() {
        let ac = UIAlertController(title: "Select image", message: "Select image from?", preferredStyle: .actionSheet)
        let cameraButton = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
            self?.showImagPicker(source: .camera)
        }
        let libraryButton = UIAlertAction(title: "Library", style: .default) { [weak self] (_) in
            self?.showImagPicker(source: .photoLibrary)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cameraButton)
        ac.addAction(libraryButton)
        ac.addAction(cancelButton)
        self.present(ac, animated: true)
    }

    private func showImagPicker(source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = source
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            photoLabel.image = selectedImage
        } else {
            photoLabel.image = Resources.Images.photoApparat
        }
        saveImage()
        picker.dismiss(animated: true)
    }

    private func saveImage() {
        guard let data = photoLabel.image?.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "imageAvatar")
    }

    private func loadImage() {
        guard let data = UserDefaults.standard.data(forKey: "imageAvatar") else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        photoLabel.image = UIImage(data: decoded)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
