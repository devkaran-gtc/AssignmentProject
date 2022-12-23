//
//  HomeViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 11/30/22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    var addPost = [AddPost]()
    var images = [PostItem]()
    @IBOutlet var tableView: UITableView!
    
//        struct Data1 {
//            let imgName: String
//            let name: String
//            let place: String
//            let postImg: String
//            var description: String
//        }
//
    //    let data: [Data] = [
    //        Data(imgName: "img1", name: "Prisha Mclaughlin", place: "Ahmedabad", postImg: "img2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    //
    //        Data(imgName: "img3", name: "Prisha Mclaughlin", place: "Ahmedabad", postImg: "img4", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    //
    //        Data(imgName: "img5", name: "Prisha Mclaughlin", place: "Ahmedabad", postImg: "img6", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    //    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.tintColor = .label
        configureItems()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
       
        downloadJSON {
            self.tableView.reloadData()
            print("Success")
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        loaddata()
//        tableView.reloadData()
//    }
//
//    func loaddata() {
//       // images = DatabaseHelper.shareInstance.fetchImage()
//    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    private func configureItems() {
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                        style: .done,
                                                        target: self,
                                                        action: nil)
    }
    
    
    @IBAction func btnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "addPostSegue") as? PostViewController
        navigationController?.pushViewController(vc!, animated: true)
        
    }
}



extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addPost.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let Data1 = data[indexPath.row]
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        //        cell.profileImg.image = UIImage(named: Data1.imgName)
        //        cell.nameLbl.text = Data1.name
        //        cell.placeLbl.text = Data1.place
        //        cell.postImg.image = UIImage(named: Data1.postImg)
        //        cell.descriptionTextView.text = Data1.description
        //        return cell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
//        let row = images[indexPath.row]
//        cell.descriptionTextView.text = row.desc
//        cell.placeLbl.text = row.place
//
//        if let dataa = row.postImg {
//            cell.postImgView.image = UIImage(data: dataa)
//        } else {
//            cell.postImgView.image = nil
//        }
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
      
        let row = addPost[indexPath.row]
        cell.placeLbl?.text = row.place
        cell.descriptionTextView?.text = row.description
        let imgUrl = row.imageurl
        let url = URL(string: imgUrl)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
                let image = UIImage(data: imageData)
            cell.postImgView.image = image
            }else {
                cell.postImgView.image = nil
            }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HomeTableViewCell
            vc.profile = (Cell?.profileImg.image)!
            vc.nameLbl = (Cell?.nameLbl.text)!
            vc.placeLbl = (Cell?.placeLbl.text)!
            vc.post = (Cell?.postImgView.image)!
            vc.descriptionlbl = (Cell?.descriptionTextView.text)!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = UIContextualAction(style: .normal, title: "Edit") { (_, _, _) in
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addPostSegue") as? PostViewController
//        let row = self.images[indexPath.row]
//        DatabaseHelper.shareInstance.updateItem(desc1: row.desc!, place1: row.place!, postImg1: row.postImg!)
//        self.navigationController?.pushViewController(vc!, animated: true)
//        }
//
//        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
//            let row = self.images[indexPath.row]
//            self.images.remove(at: indexPath.row)
//            DatabaseHelper.shareInstance.deleteData(place: row.place!)
//            self.tableView.reloadData()
//        }
//        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete, edit])
//        return swipeConfiguration
//    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "http://192.168.1.71:3000/posts")
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            
            if err == nil {
                do {
                    self.addPost = try JSONDecoder().decode([AddPost].self, from: data!)
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

