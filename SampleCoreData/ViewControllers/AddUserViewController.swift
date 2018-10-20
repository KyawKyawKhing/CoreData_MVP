//
//  AddUserViewController.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/19/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {

    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtAddress: UITextField!
    @IBOutlet weak var edtPhone: UITextField!
    @IBOutlet weak var edtEducation: UITextField!
    @IBOutlet weak var edtBio: UITextField!
    @IBOutlet weak var btnAddUser: UIButton!
    
    var mPresenter:AddUserPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edtPhone.delegate = self as? UITextFieldDelegate
        edtPhone.keyboardType = UIKeyboardType.phonePad
        mPresenter = AddUserPresenter(delegate: self)
        
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
//        let message = "Name : \(edtName.text ?? "") \n Email : \(edtEmail.text ?? "") \n Address : \(edtAddress.text ?? "") "
//
//        Utils.showAlert(viewcontroller: self, title: "User Information", message: message)
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
        Utils.showAlert(viewcontroller: self, title: "Add", message: message)
    }
    
    func displayErrorMessage(message: String) {
        Utils.showAlert(viewcontroller: self, title: "Failed", message: message)
    }
    
    
}
