//
//  VRParkDetailsViewController.swift
//  VRCoreSpotlightExample
//
//  Created by Jeremy Medford on 1/12/16.
//  Copyright © 2016 Vintage Robot. All rights reserved.
//

import UIKit

class VRParkDetailsViewController: UIViewController {

    var park:Park?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if park != nil {
            self.nameLabel.text = park?.name
            self.address1Label.text = park?.address1
            self.address2Label.text = park?.address2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

