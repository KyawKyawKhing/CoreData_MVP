//
//  AddUserViewController.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/19/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtAddress: UITextField!
    @IBOutlet weak var edtPhone: UITextField!
    @IBOutlet weak var edtEducation: UITextField!
    @IBOutlet weak var edtBio: UITextField!
    
    var mPresenter:AddUserPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mPresenter = AddUserPresenter(delegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        edtName.delegate = self
        edtEmail.delegate = self
        edtAddress.delegate = self
        edtPhone.delegate = self
        edtEducation.delegate = self
        edtBio.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == NSNotification.Name.UIKeyboardWillShow {
            //            view.frame.origin.y = -keyboardReact.height
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            //            view.frame.origin.y = 0
            scrollView.contentInset = UIEdgeInsets.zero
            
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }

    @IBAction func onClickAddUser(_ sender: UIButton) {
        if (edtName.text?.isEmpty)!{
            Utils.showAlert(viewcontroller: self, title: "Require Field", message: "UserName field is required.")
            return
        }
        if (edtEmail.text?.isEmpty)!{
            Utils.showAlert(viewcontroller: self, title: "Require Field", message: "Email field is required.")
            return
        }
        if (edtAddress.text?.isEmpty)!{
            Utils.showAlert(viewcontroller: self, title: "Require Field", message: "Address field is required.")
            return
        }
        if (edtPhone.text?.isEmpty)!{
            Utils.showAlert(viewcontroller: self, title: "Require Field", message: "Phone Number field is required.")
            return
        }
        if (edtEducation.text?.isEmpty)!{
            Utils.showAlert(viewcontroller: self, title: "Require Field", message: "Education field is required.")
            return
        }
        if (edtBio.text?.isEmpty)!{
            Utils.showAlert(viewcontroller: self, title: "Require Field", message: "Bio field is required.")
            return
        }
        var userData:UserData = UserData(name: "",email: "",address: "",phone: "",education: "",bio: "")
        userData.name = edtName.text!
        userData.email = edtEmail.text!
        userData.address = edtAddress.text!
        userData.phone = edtPhone.text!
        userData.education = edtEducation.text!
        userData.bio = edtBio.text!
        mPresenter.addUserData(userData: userData)
    }
    
}
extension AddUserViewController:AddUserDelegate{
    func displaySuccessfuleMessage(message: String) {
//        self.dismiss(animated: true, completion: nil)
        Utils.showAlert(viewcontroller: self, title: "Add", message: message)
    }
    
    func displayErrorMessage(message: String) {
        Utils.showAlert(viewcontroller: self, title: "Failed", message: message)
    }
    
    
}
