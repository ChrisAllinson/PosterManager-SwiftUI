//
//  ErrorManager.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-11.
//

import Foundation
import UIKit

struct ErrorManager {
    
    // MARK: singleton instance properties
    
    static let shared = ErrorManager()
    
    // MARK: instance properties
    
    var currentViewController = {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }()
    
    // MARK: lifecycle methods
    
    private init() { /*...*/ }
    
    // MARK: public methods
    
    func showAlert(errorMessage: String) {
        let alertController: UIAlertController = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        currentViewController.present(alertController, animated: true, completion: {
        })
    }
}
