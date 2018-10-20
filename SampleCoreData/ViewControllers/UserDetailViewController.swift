//
//  UserDetailViewController.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/19/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    var userData:UserData?
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtAddress: UITextField!
    
    var mPresenter:UserDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mPresenter = UserDetailPresenter(delegate: self)
        displayUserDetail(data: userData!)

    }

    @IBAction func onClickUpdateUser(_ sender: UIButton) {
//        let message = "Name : \(edtName.text ?? "") \n Email : \(edtEmail.text ?? "") \n Address : \(edtAddress.text ?? "") "
//        Utils.showAlert(viewcontroller: self, title: "User Information", message: message)
      
        var updateData = userData
        updateData?.name = edtName.text ?? ""
        updateData?.email = edtEmail.text ?? ""
        updateData?.address = edtAddress.text ?? ""
        
        mPresenter.updateUserData(oldData:userData!,newData:updateData!)
    }
}
extension UserDetailViewController:UserDetailDelegate{
    func displayUserDetail(data: UserData) {
        edtName.text = data.name
        edtEmail.text = data.email
        edtAddress.text = data.address
        
    }
    func displayUpdateUserDetail(data:UserData,message:String){
        displayUserDetail(data: data)
        Utils.showAlert(viewcontroller: self, title: "Update", message: "Successfully Updated")
    }
    
    func displayErrorMessage(message: String) {
        Utils.showAlert(viewcontroller: self, title: "Error", message: message)
    }
    
    
}
