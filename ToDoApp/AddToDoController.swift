//
//  AddToDoController.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 31.05.23.
//

import UIKit
import SnapKit

protocol AddViewControllerDelegate: AnyObject  {
    func updateTodoItems()
}

class AddToDoController: BaseViewController,
                         AvoidingKeyboard, UITextFieldDelegate, UITextViewDelegate {
    
    enum Constants {
        static let maxNameLength: Int = 20
    }
    
    weak var delegate: AddViewControllerDelegate?
    let placeholderText = "Your description here"
    
    lazy var newTaskTitle: UILabel = {
        let ntLabel = UILabel()
        ntLabel.text = "New Task"
        ntLabel.font = UIFont(name: "Inter-SemiBold", size: 32)
        ntLabel.backgroundColor = Resources.Colors.backgroundAddView
        ntLabel.translatesAutoresizingMaskIntoConstraints = false
        return ntLabel
    }()
    
    lazy var separator: UILabel = {
        let separator = UILabel()
        separator.backgroundColor = Resources.Colors.separatofForNewTask
        separator.layer.cornerRadius = 4
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    lazy var separatorForNameTF: UILabel = {
        let separator = UILabel()
        separator.backgroundColor = Resources.Colors.separator
        separator.layer.cornerRadius = 4
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    lazy var separatorForDescriptionTV: UILabel = {
        let separator = UILabel()
        separator.backgroundColor = Resources.Colors.separator
        separator.layer.cornerRadius = 4
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    lazy var separatorForDateTF: UILabel = {
        let separator = UILabel()
        separator.backgroundColor = Resources.Colors.buttonSave
        separator.layer.cornerRadius = 4
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    lazy var nameTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = Resources.Colors.nameSubscribeDate
        tf.placeholder = "Enter your To Do (max. 20 char.)"
        tf.layer.cornerRadius = 4
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        let newWidth = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = newWidth
        tf.leftViewMode = .always
        tf.addSubview(separatorForNameTF)
        tf.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        return tf
    }()
    
    lazy var descripitonTV: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = Resources.Colors.nameSubscribeDate
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.layer.cornerRadius = 4
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textContainerInset = UIEdgeInsets(top: 18, left: 5, bottom: 0, right: 0)
        tv.addSubview(placeHolderForDescriprionTV)
        tv.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        return tv
    }()
    
    lazy var placeHolderForDescriprionTV: UILabel = {
        let label = UILabel()
        label.text = placeholderText
        label.textColor = Resources.Colors.separator
        return label
    } ()
    
    lazy var dateTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = Resources.Colors.nameSubscribeDate
        tf.layer.cornerRadius = 4
        tf.placeholder = Date().create(with: .titleDate).capitalized
        tf.inputView = dPicker
        tf.addSubview(imageCalendar)
        tf.inputAccessoryView = toolBar
        tf.translatesAutoresizingMaskIntoConstraints = false
        let newWidth = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = newWidth
        tf.leftViewMode = .always
        tf.addSubview(separatorForDateTF)
        tf.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        return tf
    }()
    
    lazy var imageCalendar: UIImageView = {
        var image = UIImageView()
        image.image = Resources.Images.calendar
        image.translatesAutoresizingMaskIntoConstraints = true
        return image
    }()
    
    lazy var toolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.barStyle = UIBarStyle.default
        tb.isTranslucent = true
        tb.tintColor = .black
        tb.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dpClose))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        tb.setItems([spaceButton, doneButton], animated: false)
        tb.isUserInteractionEnabled = true
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    lazy var dPicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.preferredDatePickerStyle = .wheels
        dp.minimumDate = Date()
        dp.locale = Locale(identifier: "US")
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.addTarget(self, action: #selector(pickerChanged), for: .valueChanged)
        return dp
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.backgroundColor = Resources.Colors.buttonSave
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveHomeWork), for: .touchUpInside)
        return button
    }()
    
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
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        configure()
        setupConstraints()
    }
    
    private func addViews() {
        view.addSubview(saveButton)
        view.addSubview(scroll)
        scroll.addSubview(stack)
        view.addSubview(newTaskTitle)
        view.addSubview(separator)
        view.addSubview(separatorForDescriptionTV)
    }
    
    private func setupConstraints() {
        newTaskTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(105)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(scroll.snp.top).inset(25)
        }
        
        separator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(2)
            $0.bottom.equalTo(scroll.snp.top).inset(26)
        }
        
        separatorForNameTF.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameTF)
            $0.bottom.equalTo(nameTF)
            $0.height.equalTo(2)
        }
        
        separatorForDescriptionTV.snp.makeConstraints {
            $0.leading.trailing.equalTo(descripitonTV)
            $0.bottom.equalTo(descripitonTV)
            $0.height.equalTo(2)
        }
        
        placeHolderForDescriprionTV.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.top.centerY.equalTo(descripitonTV)
        }
        
        separatorForDateTF.snp.makeConstraints {
            $0.leading.trailing.equalTo(dateTF)
            $0.bottom.equalTo(dateTF)
            $0.height.equalTo(2)
        }
        
        imageCalendar.snp.makeConstraints {
            $0.trailing.equalTo(dateTF).inset(15)
            $0.top.equalTo(dateTF).inset(19)
            $0.bottom.equalTo(dateTF).inset(17)
        }
        
        scroll.snp.makeConstraints {
            $0.top.equalTo(newTaskTitle.snp.bottom).inset(25)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(saveButton.snp.top).inset(15)
        }
        
        stack.snp.makeConstraints {
            $0.top.equalTo(newTaskTitle.snp.bottom).inset(-26)
            $0.bottom.equalTo(scroll.contentLayoutGuide.snp.bottom)
            $0.width.equalTo(scroll.frameLayoutGuide)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(140)
            $0.height.equalTo(34)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }
    }
    
    private func configure() {
        stack.addArrangedSubview(nameTF)
        stack.addArrangedSubview(descripitonTV)
        stack.addArrangedSubview(dateTF)
        descripitonTV.delegate = self
        view.backgroundColor = Resources.Colors.backgroundAddView
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let descripitonLabel = descripitonTV.text, !descripitonLabel.isEmpty
        else {
            placeHolderForDescriprionTV.isHidden = false
            return
        }
        placeHolderForDescriprionTV.isHidden = true
    }
    
    @objc private func dpClose (_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    @objc private func pickerChanged(_ sender: UIDatePicker) {
        dateTF.text = sender.date.create(with: .simple)
    }
    
    private func saveList() {
        let newToDo = ToDoItem(createDate: Date(),
                               actionDate: dPicker.date,
                               name: nameTF.text ?? "",
                               subscribe: descripitonTV.text ?? "", isFinished: false)
        ToDoManagerImp.shared.save(toDoItem: newToDo)
        NotificationManager.shared.scheduleNotification(title: newToDo.name, body: newToDo.subscribe, date: newToDo.actionDate)
        self.navigationController?.popViewController(animated: true)
        self.delegate?.updateTodoItems()
    }
    
    @objc func saveHomeWork() {
        if let textName = self.nameTF.text, textName.isEmpty {
            let alert = UIAlertController(title: "Warning!", message: "Fill the name!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if self.dPicker.date.create(with:.simple) == Date().create(with: .simple) {
            let alert = UIAlertController(title: "Warning!", message: "Fill deadline (for ex. tomorrow)!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else  {
            saveList()
        }
    }
}

extension AddToDoController {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let mutableString = NSMutableString(string: textField.text ?? "")
        mutableString.replaceCharacters(in: range, with: string)
        return mutableString.length <= Constants.maxNameLength
    }
}
