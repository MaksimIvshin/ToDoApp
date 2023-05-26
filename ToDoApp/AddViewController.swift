//
//  AddViewController.swift
//  16_class_work
//
//  Created by Heorhi Sinkou on 24/05/2023.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func updateHomeWorks()
}

class AddViewController: BaseViewController, AvoidingKeyboard {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var subscribeTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!

    weak var delegate: AddViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    func configView() {
        view.backgroundColor = .systemGray6
        nameTextField.placeholder = "Name"
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 7
        subscribeTextView.layer.borderWidth = 1
        subscribeTextView.layer.cornerRadius = 7
        nameTextField.delegate = self
        datePicker.minimumDate = Date()
    }

    func saveList() {
        let newHomeWork = ToDoItem(createDate: Date(), actionDate: datePicker.date, name: nameTextField.text ?? "", subscribe: subscribeTextView.text ?? "")
        ToDoManagerImp.shared.save(toDoItem: newHomeWork)
        self.dismiss(animated: true) {
            self.delegate?.updateHomeWorks()
        }
    }

    @IBAction func saveHomeWork() {
        if let textName = self.nameTextField.text, textName.isEmpty {
            let alert = UIAlertController(title: "Warning!", message: "Fill the name!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else if let dp = self.datePicker?.date.createDate(), dp == Date().createDate() {
            let alert = UIAlertController(title: "Warning!", message: "Fill deadline (for ex. tomorrow)!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else  {
            saveList()
        }
    }
}



extension AddViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return true
    }
}
