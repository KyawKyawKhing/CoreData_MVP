//
//  ViewController.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/19/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var userTableView: UITableView!
    var mPresenter:HomePresenter!
    var userListDataSource:UserListDataSource!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mPresenter = HomePresenter(delegate: self)//don't forget to initialize
        self.userTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        userListDataSource = self.userTableView.dataSource as? UserListDataSource
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mPresenter.getUserList()
    }
    @IBAction func clickOnBarButtonItem(_ sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "AddUserIdentifier", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserDetailIdentifier"{
            let cv = segue.destination as! UserDetailViewController
            cv.userData = sender as? UserData
        }
    }
}
extension HomeViewController:HomeDelegate{
    func displayUserList(dataList: [UserData]) {
        userListDataSource.dataArray = dataList
        userTableView.reloadData()
    }
    func displayErrorMessage(message: String) {
        Utils.showAlert(viewcontroller: self,title: "Display Error",message: message)
    }
    
    func reloadData(message: String) {
        mPresenter.getUserList()
        Utils.showAlert(viewcontroller: self, title: "Deleted", message: message)
    }
    
}
extension HomeViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        
        print("did end editing row at \(indexPath!.row)")
        self.mPresenter.deleteUserData(userData: self.userListDataSource.dataArray[indexPath!.row-1])
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        
//        self.mPresenter.deleteUserData(userData: self.userListDataSource.dataArray[indexPath.row-1])
        print("will begin editing row at \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let userData = userListDataSource.dataArray[indexPath.row]
        self.performSegue(withIdentifier: "UserDetailIdentifier", sender: userData)
      let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(longPressGestureRecognizer:)))
        self.userTableView.addGestureRecognizer(longPressRecognizer)
    }
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = userTableView.indexPathForRow(at: touchPoint) {
             
                let alert = UIAlertController(title: "Confirm", message: "Are you sure to delete?", preferredStyle: .alert)
            
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                alert.addAction(cancelAction)
                
                
                let okAction = UIAlertAction(title: "OK", style: .default){
                    response -> Void in
                    let index = indexPath.row
                    let data = self.userListDataSource.dataArray[indexPath.row-1]
                    
                    self.mPresenter.deleteUserData(userData: self.userListDataSource.dataArray[indexPath.row-1])
                }
                alert.addAction(okAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
