//
//  SearchResultsController.swift
//  aimalaif
//
//  Created by Oriol Marí Marqués on 04/03/2017.
//  Copyright © 2017 Oriol Marí Marqués. All rights reserved.
//

import UIKit

class SearchResultsController: UIViewController {
    @IBOutlet weak var obsTV: UITextView!
    @IBOutlet weak var contactInfoTV: UITextView!
    @IBOutlet weak var healthTV: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dniLabel: UILabel!

    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("AAAAAAAAAAA")
        if segue.identifier == "SearchResultsSegue" {
            print("BBBBBBBBBBBBB")
            if let destination = segue.destination as? LastLocationController {
                print("CCCCCCCCCCCC")
                destination.viaSegue = "location"
                print("DDDDDDDDDDDDD")
            }
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SocketIOManager.sharedInstance.searchResult() {
            (result: [Any]) in
            self.dniLabel.text = String(describing: result[0])
            self.nameLabel.text = String(describing: result[1])
            self.healthTV.text = String(describing: result[2])
            self.contactInfoTV.text = String(describing: result[3])
            self.obsTV.text = String(describing: result[4])
            print(result)
        }
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
