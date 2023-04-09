//
//  Protocols.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 20.03.2023.
//

import UIKit

protocol AlertShowable: AnyObject {
    func showAlert(messageText: String?, titleText: String?)
    func showAlertWithHandler(messageText: String?, titleText: String?, handler: @escaping (UIAlertAction) -> Void)
}

extension AlertShowable where Self: UIViewController {

    func showAlert(messageText: String?, titleText: String?) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showAlertWithHandler(messageText: String?, titleText: String?, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .destructive, handler: handler))
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
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
