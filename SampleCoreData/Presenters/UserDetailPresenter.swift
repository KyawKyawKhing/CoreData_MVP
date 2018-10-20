//
//  UserDetailPresenter.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/20/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
protocol UserDetailDelegate {
    func displayUserDetail(data:UserData)
    func displayUpdateUserDetail(data:UserData,message:String)
    func displayErrorMessage(message:String)
}
class UserDetailPresenter:UpdateUserCallback{
    var delegate:UserDetailDelegate
    var userModel:UserModel = UserModel()
    
    init(delegate:UserDetailDelegate) {
        self.delegate = delegate
    }
    
    func updateUserData(oldData:UserData,newData:UserData){
        userModel.updateUserData(oldData:oldData,newData:newData, callback: self)
    }
    
    func SucceedUpdateUser(data: UserData, messsage: String) {
        delegate.displayUpdateUserDetail(data: data,message: messsage)
    }
    
    func FailedGetUpdate(message: String) {
        delegate.displayErrorMessage(message: message)
        
    }
    
}
