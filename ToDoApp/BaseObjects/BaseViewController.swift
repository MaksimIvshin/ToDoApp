//
//  BaseViewController.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 25.05.23.
//

import UIKit
class BaseViewController: UIViewController, HideKeyboardWhenTappedAround {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        if let vc = self as? AvoidingKeyboard {
            vc.startAvoidingKeyboard()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let vc = self as? AvoidingKeyboard {
            vc.stopAvoidingKeyboard()
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
