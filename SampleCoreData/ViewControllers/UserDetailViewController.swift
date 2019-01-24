//
//  UserDetailViewController.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/19/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController,UITextFieldDelegate {
    var userData:UserData?
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtAddress: UITextField!
    @IBOutlet weak var edtPhone:UITextField!
    @IBOutlet weak var edtEducation : UITextField!
    @IBOutlet weak var edtBio : UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var mPresenter:UserDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mPresenter = UserDetailPresenter(delegate: self)
        displayUserDetail(data: userData!)

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
//                        view.frame.origin.y = -keyboardReact.height
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
//                        view.frame.origin.y = 0
            scrollView.contentInset = UIEdgeInsets.zero
            
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }

    @IBAction func onClickUpdateUser(_ sender: UIButton) {
//        let message = "Name : \(edtName.text ?? "") \n Email : \(edtEmail.text ?? "") \n Address : \(edtAddress.text ?? "") "
//        Utils.showAlert(viewcontroller: self, title: "User Information", message: message)
      
        var updateData = userData
        updateData?.name = edtName.text ?? ""
        updateData?.email = edtEmail.text ?? ""
        updateData?.address = edtAddress.text ?? ""
        updateData?.phone = edtPhone.text ?? ""
        updateData?.education = edtEducation.text ?? ""
        updateData?.bio = edtBio.text ?? ""
        mPresenter.updateUserData(oldData:userData!,newData:updateData!)
    }
 }
extension UserDetailViewController:UserDetailDelegate{
    func displayUserDetail(data: UserData) {
        edtName.text = data.name
        edtEmail.text = data.email
        edtAddress.text = data.address
        edtPhone.text = data.phone
        edtEducation.text = data.education
        edtBio.text = data.bio
    }
    func displayUpdateUserDetail(data:UserData,message:String){
        displayUserDetail(data: data)
        Utils.showAlert(viewcontroller: self, title: "Update", message: "Successfully Updated")
    }
    
    func displayErrorMessage(message: String) {
        Utils.showAlert(viewcontroller: self, title: "Error", message: message)
    }
    
    
}
