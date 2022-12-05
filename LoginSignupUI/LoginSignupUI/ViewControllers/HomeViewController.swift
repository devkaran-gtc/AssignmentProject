//
//  HomeViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 11/30/22.
//

import UIKit
import CoreData
import TPKeyboardAvoidingSwift

class HomeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    struct Data {
        let imgName: String
        let name: String
        let place: String
        let postImg: String
        let description: String
    }
    
    let data: [Data] = [
        Data(imgName: "img1", name: "Prisha Mclaughlin", place: "Ahmedabad", postImg: "img2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        
        Data(imgName: "img3", name: "Prisha Mclaughlin", place: "Ahmedabad", postImg: "img4", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
        
        Data(imgName: "img5", name: "Prisha Mclaughlin", place: "Ahmedabad", postImg: "img6", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.tintColor = .label
        configureItems()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        fetchData()
    }
    
    func fetchData() {
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 425.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Data1 = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.profileImg.image = UIImage(named: Data1.imgName)
        cell.nameLbl.text = Data1.name
        cell.placeLbl.text = Data1.place
        cell.postImg.image = UIImage(named: Data1.postImg)
        cell.descriptionTextView.text = Data1.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let Data = data[indexPath.row]
        if let vc1 = storyboard?.instantiateViewController(withIdentifier: "detailViewSegue") as? DetailViewController {
            vc1.post = UIImage(named: Data.postImg)!
            vc1.profile = UIImage(named: Data.imgName)!
            vc1.nameLbl = Data.name
            vc1.placeLbl = Data.place
            vc1.descriptionlbl = Data.description
            navigationController?.pushViewController(vc1, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            switch indexPath.section {
            case 0:
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case 1:
                tableView.deleteRows(at: [indexPath], with: .automatic)
            default:
                break
            }
            tableView.endUpdates()
        }
    }
}


