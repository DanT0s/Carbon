//
//  AlertService.swift
//  appCarbon
//
//  Created by macbook on 21.01.2021.
//

import Foundation
import UIKit

class AlertService {
    
    class func alert(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        return alert
        
    }
    
}
