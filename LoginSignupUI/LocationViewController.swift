//
//  LocationViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS-Mac-Mini5 on 30/01/23.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = UIImage(named: "ic_back")
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(backImage, for: .normal)
        menuBtn.addTarget(self, action: #selector(backButtonClick(sender:)), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 46).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 46).isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
        self.navigationItem.title = "My Location"
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0] 
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    @objc func backButtonClick(sender : UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
}
