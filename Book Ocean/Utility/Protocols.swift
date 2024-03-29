//
//  Protocols.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 20.03.2023.
//

import UIKit

protocol AlertShowable: AnyObject {
    func showAlert(titleText: String?, messageText: String?)
    func showAlertWithHandler(titleText: String?, messageText: String?, cancelButtonActive: Bool, handler: @escaping (UIAlertAction) -> Void)
}

extension AlertShowable where Self: UIViewController {

    func showAlert(titleText: String?, messageText: String?) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showAlertWithHandler(titleText: String?, messageText: String?, cancelButtonActive: Bool, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: handler))
        if cancelButtonActive {
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        }
        present(alert, animated: true)
    }
}

protocol Transition: AnyObject {
    func navigatePageWithPresent(nameText: String, identifier: String)
    func navigatePageWithPush(nameText: String, identifier: String)
}

extension Transition where Self: UIViewController {

    func navigatePageWithPresent(nameText: String, identifier: String) {
        let storyboard = UIStoryboard(name: nameText, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        present(controller, animated: true, completion: nil)
    }

    func navigatePageWithPush(nameText: String, identifier: String) {
        let storyboard = UIStoryboard(name: nameText, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        navigationController?.pushViewController(controller, animated: true)
    }
}
