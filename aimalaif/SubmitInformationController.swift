//
//  SubmitInformationController.swift
//  aimalaif
//
//  Created by Oriol Marí Marqués on 04/03/2017.
//  Copyright © 2017 Oriol Marí Marqués. All rights reserved.
//

import UIKit

class SubmitInformationController: UIViewController {
    

    @IBOutlet weak var dni: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var health: UITextField!
    @IBOutlet weak var contactInfo: UITextField!
    @IBOutlet weak var obs: UITextField!
   
    @IBAction func submitButton(_ sender: Any) {
        SocketIOManager.sharedInstance.submitInformation(dni: dni.text!, name: name.text!, health: health.text!, contactInfo: contactInfo.text!, obs: obs.text!)
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
