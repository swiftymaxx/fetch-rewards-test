//
//  AlertManager.swift
//  Fetch Rewards Exercise
//
//  Created by Maximo Liriano on 10/20/20.
//

import UIKit

struct AlertManager {
    
    static func showAlert(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(action)
        
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
}
