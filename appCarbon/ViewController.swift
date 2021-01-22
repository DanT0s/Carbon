//
//  ViewController.swift
//  appCarbon
//
//  Created by macbook on 21.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: OTPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.configure()
        
        textField.didEnterLastDigit = { code in
         let alert = AlertService.alert(title: "Success", message: "Your code \(code)")
            self.present(alert, animated: true, completion: nil)
        }
    }

}

