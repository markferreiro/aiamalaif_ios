//
//  ViewController.swift
//  aimalaif
//
//  Created by Oriol Marí Marqués on 04/03/2017.
//  Copyright © 2017 Oriol Marí Marqués. All rights reserved.
//

import UIKit
import CoreLocation

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var dniText: UITextField!
        
    var locationManager:CLLocationManager!
    
    var lat: CLLocationDegrees?
    var long: CLLocationDegrees?
    let uuid = UIDevice.current.identifierForVendor!.uuidString
    var status:String?
    
    
    @IBAction func noButton(_ sender: Any) {
        status = "0"
        SocketIOManager.sharedInstance.establishConnection(room: "norisk", uuid: uuid, dni: dniText.text!)
        startSendingLocation()
    }
    
    @IBAction func yesButton(_ sender: Any) {
        status = "1"
        SocketIOManager.sharedInstance.establishConnection(room: "risk", uuid: uuid, dni: dniText.text!)
        startSendingLocation()
    }
    
    func startSendingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            SocketIOManager.sharedInstance.updateLocation(uuid: uuid, dni: dniText.text!, status: status!, lat: String(location.coordinate.latitude), long: String(location.coordinate.longitude))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

