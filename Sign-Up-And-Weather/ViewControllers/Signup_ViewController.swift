//
//  Signup_ViewController.swift
//  Sign-Up-And-Weather
//
//  Created by Mohit Andhare on 2023-09-23.
//

import UIKit
import Firebase

class Signup_ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profile_image: UIImageView!
    
    @IBOutlet weak var imageView: UIView!
    
    @IBOutlet weak var set_image_label: UILabel!
    
    @IBOutlet weak var email_text_field: UITextField!
    
    @IBOutlet weak var password_text_field: UITextField!
    
    @IBOutlet weak var confirm_text_field: UITextField!
    
    @IBOutlet weak var user_text_field: UITextField!
    
    @IBOutlet weak var bio_text_field: UITextField!
    
    var email_bottom_line = CALayer()
    var password_bottom_line = CALayer()
    var confirm_password_bottom_line = CALayer()
    var user_name_bottom_line = CALayer()
    var bio_bottom_line = CALayer()
    
    let imagePicker = UIImagePickerController()
    
    let user_default = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imagePicker.delegate = self
        
        //    MARK: PAGE TITLE
        navigationItem.title = "Register"
        
        
        //    MARK: IMAGE CIRCLE CODE
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.clear.cgColor
        
        //    MARK: ENABLED TAP ON LABEL
        let tap_on_set_image_label = UITapGestureRecognizer(target: self, action: #selector(set_image_label_tapped))
        
        self.set_image_label.isUserInteractionEnabled = true
        tap_on_set_image_label.numberOfTapsRequired = 1
        self.set_image_label.addGestureRecognizer(tap_on_set_image_label)
        
        //    MARK: CREATE COTTOM LINE OF TEXT FIELD
        
        
        email_bottom_line.frame = CGRect(x: 0.0, y: email_text_field.frame.height - 1, width: email_text_field.frame.width, height: 1.0)
        email_bottom_line.backgroundColor = UIColor.black.cgColor
        email_text_field.borderStyle = UITextField.BorderStyle.none
        email_text_field.layer.addSublayer(email_bottom_line)
        
        password_bottom_line.frame = CGRect(x: 0.0, y: password_text_field.frame.height - 1, width: password_text_field.frame.width, height: 1.0)
        password_bottom_line.backgroundColor = UIColor.black.cgColor
        password_text_field.borderStyle = UITextField.BorderStyle.none
        password_text_field.layer.addSublayer(password_bottom_line)
        
        confirm_password_bottom_line.frame = CGRect(x: 0.0, y: confirm_text_field.frame.height - 1, width: confirm_text_field.frame.width, height: 1.0)
        confirm_password_bottom_line.backgroundColor = UIColor.black.cgColor
        confirm_text_field.borderStyle = UITextField.BorderStyle.none
        confirm_text_field.layer.addSublayer(confirm_password_bottom_line)
        
        user_name_bottom_line.frame = CGRect(x: 0.0, y: user_text_field.frame.height - 1, width: user_text_field.frame.width, height: 1.0)
        user_name_bottom_line.backgroundColor = UIColor.black.cgColor
        user_text_field.borderStyle = UITextField.BorderStyle.none
        user_text_field.layer.addSublayer(user_name_bottom_line)
        
        bio_bottom_line.frame = CGRect(x: 0.0, y: bio_text_field.frame.height - 1, width: user_text_field.frame.width, height: 1.0)
        bio_bottom_line.backgroundColor = UIColor.black.cgColor
        bio_text_field.borderStyle = UITextField.BorderStyle.none
        bio_text_field.layer.addSublayer(bio_bottom_line)
        
    }
    
    
    
    @objc func set_image_label_tapped() {
        
        let ac = UIAlertController(title: "Select Image", message: "", preferredStyle: .actionSheet)
        
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (_) in
            print("Camera Pressed")
            self.showImagePicker(selectedSource: .camera)
            
        }
        
        let Library = UIAlertAction(title: "Photo Galary", style: .default) { (_) in
            print("Galary Pressed")
            self.showImagePicker(selectedSource: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(camera)
        ac.addAction(Library)
        ac.addAction(cancel)
        
        self.present(ac, animated: true)
    }
    
    
    
    @IBAction func sign_up_btn(_ sender: UIButton) {
        
        
        if email_text_field.text?.isEmpty == true {
            Alert(title: "Email text field is empty", msg: "Please make sure it not be empty")
        }
        
        
        
        else if password_text_field.text?.isEmpty == true {
            
            
            Alert(title: "Password text field is empty", msg: "Please make sure it not be empty")
            
            
        }
        
        else if confirm_text_field.text?.isEmpty == true {
            
            Alert(title: "Confirm Password text field is empty", msg: "Please make sure it not be empty")
        }
        
        else if confirm_text_field.text != password_text_field.text {
            
            Alert(title: "Password Not Matched", msg: "")
            
        }
        
        else if user_text_field.text?.isEmpty == true {
            
            Alert(title: "UserName text field is empty", msg: "Please make sure it not be empty")
        }
        
        else if bio_text_field.text?.isEmpty == true {
            
            Alert(title: "Bio text field is empty", msg: "Please make sure it not be empty")
        }
        
        else {
            
            Auth.auth().createUser(withEmail: email_text_field.text ?? "", password: password_text_field.text ?? "") { (authResult, error) in
                
                
                
                
                if let error = error {
                    print("Error signing up: \(error.localizedDescription)")
                    
                    self.Alert(title: error.localizedDescription, msg: "")
                    return
                }
                
                
                print("User signed up successfully!")
                
                UserDefaults.standard.set(self.user_text_field.text, forKey: "User_Name")
                UserDefaults.standard.set(self.bio_text_field.text, forKey: "Bio")
                
                self.profile_image.image = UIImage(named: "")
                self.navigate_to_bio_page()
                
            }
        }
        
        
    }
    
    
    
    func Alert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true)
        
    }
    
    func saveImageToUserDefaults(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: "selectedImage")
        }
    }
    
    func getSavedImageFromUserDefaults() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: "selectedImage") {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType) {
        
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            
            print("Not Available")
            return
        }
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profile_image.image = selectedImage
            saveImageToUserDefaults(image: selectedImage)
        }
        
        else {
            
            
        }
        picker.dismiss(animated: true)
    }
    
    func navigate_to_bio_page() {
        
        
        let bio_vc : Bio_Page_ViewController = self.storyboard?.instantiateViewController(withIdentifier: "Bio_Page_ViewController") as! Bio_Page_ViewController
        
        self.navigationController?.pushViewController(bio_vc, animated: true)
        
    }
}

