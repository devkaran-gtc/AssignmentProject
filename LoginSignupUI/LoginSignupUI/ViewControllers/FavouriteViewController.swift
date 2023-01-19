//
//  FavouriteViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/19/22.
//

import UIKit

class FavouriteViewController: UIViewController {

    var like = [Like]()
    @IBOutlet var tableView: UITableView!
//    struct Data1 {
//        let img1: String
//        let name1: String
//        let nickName1: String
//    }
//    let data1: [Data1] = [
//        Data1(img1: "img1", name1: "Darci Conroy", nickName1: "@darciconroy"),
//        Data1(img1: "img2", name1: "Yasmin Mcgregor", nickName1: "@yasminmcgregor"),
//        Data1(img1: "img3", name1: "Prisha Mclaughlin", nickName1: "@prishalaugh"),
//        Data1(img1: "img4", name1: "Danny O’Reilly", nickName1: "@dannyo’reilly"),
//        Data1(img1: "img5", name1: "Monique Everett", nickName1: "@moniqueeverett"),
//        Data1(img1: "img6", name1: "Saoirse Hopper", nickName1: "@saoirsehop"),
//        Data1(img1: "img1", name1: "Melina Charlton", nickName1: "@melinacharlton")
//    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        downloadJSON {
            self.tableView.reloadData()
            print("Success")
        }
    }
}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return like.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = like[indexPath.row]
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! FavouriteTableViewCell
       
        cell1.profileName.text = row.full_name
        cell1.nickName.text = row.email
        let imgUrl = row.profile_image_url
        let url = URL(string: imgUrl)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
                let image = UIImage(data: imageData)
            cell1.profileImage1.image = image
            }else {
                cell1.profileImage1.image = nil
            }
        return cell1
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "http://192.168.1.33:3000/likes")
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
            if err == nil {
                do {
                    self.like = try JSONDecoder().decode([Like].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("error fatching ")
                }
               
               
            }
        }.resume()
    }
}
    
    


