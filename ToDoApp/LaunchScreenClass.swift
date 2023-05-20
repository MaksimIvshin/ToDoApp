//
//  LaunchScreenClass.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 18.05.23.
//

import UIKit

class LaunchScreenClass: UIViewController {

    @IBOutlet weak var logoToDo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: .allowAnimatedContent) {
            self.logoToDo.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.logoToDo.layer.cornerRadius = 15
        } completion: { _ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainSID")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false, completion: nil)
        }
    }
}
