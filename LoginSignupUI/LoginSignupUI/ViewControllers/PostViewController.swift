//
//  PostViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/1/22.
//

import UIKit

class PostViewController: UIViewController,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate {
    
    var picker:UIImagePickerController?=UIImagePickerController()
    var indexRow = Int()
    var isEditingUser: Bool = false

    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var imgBtn: UIButton!
    @IBOutlet var descriptionTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate=self
        view.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    
        let backImage = UIImage(named: "ic_back")
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(backImage, for: .normal)
        menuBtn.addTarget(self, action: #selector(backButtonClick(sender:)), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 46).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 46).isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
        
        descriptionTxtView.delegate = self
        descriptionTxtView.text = "Description"
        descriptionTxtView.textColor = UIColor.lightGray
        descriptionTxtView.layer.cornerRadius = 7
        descriptionTxtView.layer.borderWidth = 1
        descriptionTxtView.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        
        imgBtn.layer.masksToBounds = true
        imgBtn.layer.cornerRadius = 15
        imgBtn.layer.borderWidth = 1
        imgBtn.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTxtView.textColor == UIColor.lightGray {
            descriptionTxtView.text = ""
            descriptionTxtView.textColor = .black
            descriptionTxtView.layer.borderWidth = 1
            descriptionTxtView.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTxtView.text == "" {
            descriptionTxtView.text = "Description"
            descriptionTxtView.textColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
            descriptionTxtView.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
        
    }
    
    @objc func backButtonClick(sender : UIButton) {
            self.navigationController?.popViewController(animated: true);
        }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func addImageBtn(_ sender: Any) {
        openGallary()
    }
    
    func openGallary()
    {
        picker!.allowsEditing = true
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            postImage.contentMode = .scaleAspectFit
            postImage.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
        let placeLbl = placeTextField.text ?? ""
        let desc = descriptionTxtView.text ?? ""
        
        if let imageData = postImage.image?.jpegData(compressionQuality: 1) {
            DatabaseHelper.shareInstance.save(desc: desc, place: placeLbl, postImg: imageData)
        }
        _ = navigationController?.popViewController(animated: true)
        
        self.setUpPostMethod()
    }
}

extension PostViewController {
    func setUpPostMethod() {
        guard let place = self.placeTextField.text else { return }
        let post = "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"
        guard let desc = self.descriptionTxtView.text else { return }
        
        if let url = URL(string: "http://192.168.1.71:3000/posts"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters: [String: String] = [
                "place": place,
                "description": desc,
                "imageurl": post
            ]
            
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

extension PostViewController {
    func setUpPutMethod() {
        guard let place = self.placeTextField.text else { return }
        let post = "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"
        guard let desc = self.descriptionTxtView.text else { return }
        
        if let url = URL(string: "http://192.168.1.34:3000/posts"){
            var request = URLRequest(url: url)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "PUT"
            
            let parameters: [String: String] = [
                "place": place,
                "description": desc,
                "imageurl": post
            ]
            
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
extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

//extension UIImage {
//    func toPngString() -> String? {
//        let data = self.pngData()
//        return data?.base64EncodedString(options: .endLineWithLineFeed)
//    }
//}
