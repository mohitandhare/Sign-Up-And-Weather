//
//  ViewController.swift
//  Sign-Up-And-Weather
//
//  Created by Mohit Andhare on 2023-09-23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email_text_field: UITextField!
    
    @IBOutlet weak var password_text_field: UITextField!
    
    
    var bottomLine = CALayer()
    var bottomLine_two = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        bottomLine.frame = CGRect(x: 0.0, y: email_text_field.frame.height - 1, width: email_text_field.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        email_text_field.borderStyle = UITextField.BorderStyle.none
        email_text_field.layer.addSublayer(bottomLine)
        
        bottomLine_two.frame = CGRect(x: 0.0, y: password_text_field.frame.height - 1, width: password_text_field.frame.width, height: 1.0)
        bottomLine_two.backgroundColor = UIColor.black.cgColor
        password_text_field.borderStyle = UITextField.BorderStyle.none
        password_text_field.layer.addSublayer(bottomLine_two)
        
    }

    
    @IBAction func login_btn(_ sender: UIButton) {
    }
    
    
    @IBAction func signup_btn(_ sender: UIButton) {
        
        navigate_to_signup_page()
    }
    
    func navigate_to_signup_page() {
        
        let sign_vc : Signup_ViewController = self.storyboard?.instantiateViewController(identifier: "Signup_ViewController") as! Signup_ViewController
        
        self.navigationController?.pushViewController(sign_vc, animated: true)
        
    }
    
    
    
}

