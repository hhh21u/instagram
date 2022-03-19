//
//  LoginViewController.swift
//  instagram
//
//  Created by Chen Hanrui on 2022/3/18.
//

import UIKit
import Parse

extension UITextField {
    func setRightView(icon: UIImage, btnView: UIButton) {
    btnView.setImage(icon, for: .normal)
    btnView.tintColor = .lightGray
    btnView.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
    self.rightViewMode = .always
    self.rightView = btnView
  }
}

class LoginViewController: UIViewController {
 
    let eyeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    {
        didSet{
            passwordField.setRightView(icon: UIImage.init(named: "eye_slash")!, btnView: eyeButton)
            passwordField.tintColor = .lightGray
            passwordField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholderU = NSAttributedString(string: "Phone number, username, email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        usernameField.attributedPlaceholder = placeholderU;
        self.view.addSubview(usernameField)
        let placeholderP = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        passwordField.attributedPlaceholder = placeholderP;
        self.view.addSubview(passwordField)
        
        loginButton.layer.cornerRadius = 0.02 * loginButton.bounds.size.width
        loginButton.clipsToBounds = true
        

        //eyeButton.setTitle("Click Me", for: .normal)
        eyeButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(eyeButton)


        // Do any additional setup after loading t he view.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if passwordField.isSecureTextEntry {
            //print("Success, on eye button")
            passwordField.isSecureTextEntry = false
            passwordField.setRightView(icon: UIImage.init(named: "eye_open")!, btnView: eyeButton)
        }else{
            passwordField.isSecureTextEntry = true
            passwordField.setRightView(icon: UIImage.init(named: "eye_slash")!, btnView: eyeButton)
        }
    }
    
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password){ (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
    
        user.signUpInBackground{ (success, error) in
            if success{
                self.performSegue(withIdentifier: "loginSegue", sender: nil) 
            }else{
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
