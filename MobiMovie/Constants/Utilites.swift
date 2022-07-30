//
//  Utilites.swift
//  MobiMovie
//
//  Created by Narkoz on 31.07.2022.
//

import UIKit
import Foundation



extension UIWindow {
    static func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okButton)

        
        if let presentedController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
            presentedController.present(alert, animated: true, completion: nil)
        } else {
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}


