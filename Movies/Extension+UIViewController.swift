//
//  Extension+UIViewController.swift
//  Movies
//
//  Created by Влад Третьяк on 21.09.2023.
//

import UIKit

extension UIViewController {
    func alert(title: String?, message: String?, _ buttonBuilder: (UIAlertController) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        buttonBuilder(alert)
        present(alert, animated: true)
    }
}

