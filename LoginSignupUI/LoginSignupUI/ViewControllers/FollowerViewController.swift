//
//  FollowerViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/5/22.
//

import UIKit

class FollowerViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    struct Data1 {
        let img: String
        let name: String
        let nickName: String
    }
    let data1: [Data1] = [
        Data1(img: "img1", name: "Darci Conroy", nickName: "@darciconroy"),
        Data1(img: "img2", name: "Yasmin Mcgregor", nickName: "@yasminmcgregor"),
        Data1(img: "img3", name: "Prisha Mclaughlin", nickName: "@prishalaugh"),
        Data1(img: "img4", name: "Danny O’Reilly", nickName: "@dannyo’reilly"),
        Data1(img: "img5", name: "Monique Everett", nickName: "@moniqueeverett"),
        Data1(img: "img6", name: "Saoirse Hopper", nickName: "@saoirsehop"),
        Data1(img: "img1", name: "Melina Charlton", nickName: "@melinacharlton")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension FollowerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Data2 = data1[indexPath.row]
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! FollowerTableViewCell
        cell1.profileImage.image = UIImage(named: Data2.img)
        cell1.nameLbl.text = Data2.name
        cell1.nickNameLbl.text = Data2.nickName
        return cell1
    }
}
