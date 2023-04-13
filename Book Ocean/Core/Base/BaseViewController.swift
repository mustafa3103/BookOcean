//
//  BaseViewController.swift
//  Book Ocean
//
//  Created by Mustafa on 12.04.2023.
//

import UIKit

class BaseViewController: UIViewController, AlertShowable, Transition {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(named: "buttonColor")
    }
}
