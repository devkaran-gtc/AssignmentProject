//
//  FollowerViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/5/22.
//

import UIKit

class FollowerViewController: UIViewController {
    
    var follower = [Followers]()
    @IBOutlet var tableView: UITableView!
//    struct Data1 {
//        let img: String
//        let name: String
//        let nickName: String
//    }
//    let data1: [Data1] = [
//        Data1(img: "img1", name: "Darci Conroy", nickName: "@darciconroy"),
//        Data1(img: "img2", name: "Yasmin Mcgregor", nickName: "@yasminmcgregor"),
//        Data1(img: "img3", name: "Prisha Mclaughlin", nickName: "@prishalaugh"),
//        Data1(img: "img4", name: "Danny O’Reilly", nickName: "@dannyo’reilly"),
//        Data1(img: "img5", name: "Monique Everett", nickName: "@moniqueeverett"),
//        Data1(img: "img6", name: "Saoirse Hopper", nickName: "@saoirsehop"),
//        Data1(img: "img1", name: "Melina Charlton", nickName: "@melinacharlton")
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

extension FollowerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follower.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = follower[indexPath.row]
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! FollowerTableViewCell
       
        cell1.nameLbl.text = row.full_name
        cell1.nickNameLbl.text = row.email
        let imgUrl = row.profile_image_url
        let url = URL(string: imgUrl)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
                let image = UIImage(data: imageData)
            cell1.profileImage.image = image
            }else {
                cell1.profileImage.image = nil
            }
        return cell1
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "http://192.168.1.71:3000/followers")
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
            if err == nil {
                do {
                    self.follower = try JSONDecoder().decode([Followers].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("error fatching ")
                }
               
               
            }
        }.resume()
    }
    
    func setUpPutMethod() {

        if let url = URL(string: "http://192.168.1.71:3000/followers"){
            var request = URLRequest(url: url)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "PUT"

            var parameters = [String: Any]()
            parameters["following"] = true as Bool
            

            request.httpBody = parameters.percentEscaped().data(using: .utf8)

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }

                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        print("Status code :- \(response.statusCode)")
                        print(response)
                        return
                    }
                }

                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    
}

