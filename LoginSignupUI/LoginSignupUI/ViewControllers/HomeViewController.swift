//
//  HomeViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 11/30/22.
//

import UIKit
import CoreData

protocol DataPass {
    func post(object:[String:String])
}
class HomeViewController: UIViewController {
    
    var images = [PostItem]()
    var delegate: DataPass!
    @IBOutlet var tableView: UITableView!
    
    //    struct Data {
    //        let imgName: String
    //        let name: String
    //        let place: String
    //        let postImg: String
    //        var description: String
    //    }
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
        //  fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loaddata()
        tableView.reloadData()
    }
    
    func loaddata() {
        images = DatabaseHelper.shareInstance.fetchImage()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    private func configureItems() {
        
        //        let button = UIButton(type: .system)
        //        button.setImage(UIImage(systemName: "camera"), for: .normal)
        //        button.setTitle("Timeline", for: .normal)
        //        button.sizeToFit()
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "camera"),
        //                                                            style: .done,
        //                                                            target: self,
        //                                                            action: nil)
        
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

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 425.0
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        let row = images[indexPath.row]
        cell.descriptionTextView.text = row.desc
        cell.placeLbl.text = row.place
        
        if let dataa = row.postImg {
            cell.postImgView.image = UIImage(data: dataa)
        } else {
            cell.postImgView.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "detailViewSegue") as? DetailViewController
        navigationController?.pushViewController(vc1!, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (_, _, _) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addPostSegue") as? PostViewController
            let row = self.images[indexPath.row]
            DatabaseHelper.shareInstance.updateItem(desc1: row.desc!, place1: row.place!, postImg1: row.postImg!)
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            let row = self.images[indexPath.row]
            self.images.remove(at: indexPath.row)
            DatabaseHelper.shareInstance.deleteData(place: row.place!)
            self.tableView.reloadData()
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeConfiguration
    }
    
}


