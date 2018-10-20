//
//  HomePresenter.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/20/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
protocol HomeDelegate {
    func displayUserList(dataList:[UserData])
    func displayErrorMessage(message:String)
    func reloadData(message:String)
}
class HomePresenter:GetUserListCallback,DeleteUserCallback {
    
    var delegate:HomeDelegate
    var userModel:UserModel = UserModel()
    
    init(delegate:HomeDelegate) {
        self.delegate = delegate
    }
    
    func getUserList(){
        userModel.getUserList(callback:self )
    }
    
    func deleteUserData(userData:UserData){
        userModel.deleteUserData(userData: userData, callback: self)
    }
    
    func SucceedGetUserList(dataList: [UserData]) {
        delegate.displayUserList(dataList: dataList)
    }
    
    func FailedGetUserList(message: String) {
        delegate.displayErrorMessage(message: message)
    }
    
    
    func SuccedDeleteUser(message: String) {
        delegate.reloadData(message: message)
    }
    
    func FailedDeleteUser(message: String) {
        delegate.displayErrorMessage(message: message)
    }
    
}
