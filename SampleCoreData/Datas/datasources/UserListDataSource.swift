//
//  UserListDataSource.swift
//  SampleCoreData
//
//  Created by AcePlus101 on 10/19/18.
//  Copyright © 2018 AcePlus. All rights reserved.
//

import Foundation
import UIKit
class UserListDataSource:NSObject,UITableViewDataSource {
    var dataArray:[UserData]=[
        UserData(name: "Mg Mg",email: "mg@gmail.com",address: "yangon",phone: "09423192929",education: "B.C.Sc",bio: "I am a programmer"),
        UserData(name: "Kyaw Kyaw",email: "kyaw@gmail.com",address: "Pyay",phone: "09423832382",education: "B.C.Sc",bio: "I am a mobile developer")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.setData(data: self.dataArray[indexPath.row])
        return cell
    }
    
    
}
