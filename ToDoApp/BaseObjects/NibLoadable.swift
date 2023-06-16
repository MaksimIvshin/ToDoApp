//
//  NibLoadable.swift
//  ToDoApp
//
//  Created by Maks Ivshin on 25.05.23.
//
import UIKit

protocol NibLoadable: AnyObject {
    static func loadFromNib(_ nib: UINib) -> Self
}

extension NibLoadable where Self: UIView {
    static func loadFromNib(_ nib: UINib = nib()) -> Self {
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? Self {
            return view
        } else {
            assertionFailure("Can't create xib with identifier: \(Self.description())")
            return self.init()
        }
    }
    
    static func nib() -> UINib {
        let bundle = Bundle(for: self)
        let nibName = Self.description()
        return UINib(nibName: nibName, bundle: bundle)
    }
}

extension NibLoadable where Self: UIViewController {
    static func loadFromNib(_ nib: UINib = nib()) -> Self {
        let result = self.init()
        nib.instantiate(withOwner: result, options: nil)
        result.viewDidLoad()
        return result
    }
    
    static func nib() -> UINib {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: bundle)
    }
}

extension UIView: NibLoadable {}
extension UIViewController: NibLoadable {}

