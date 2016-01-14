//
//  VRParksViewController.swift
//  VRCoreSpotlightExample
//
//  Created by Jeremy Medford on 1/12/16.
//  Copyright © 2016 Vintage Robot. All rights reserved.
//

import UIKit
import CoreSpotlight

struct Park {
    var name = "Park"
    var address1 = "Some Street"
    var address2 = "Some City and State"
    var thumb = ""
}

class VRParksViewController: UITableViewController {
    
    var parks = [Park]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")
        title = "San Francisco Parks"
        
        let parkOne = Park(name: "Alice Chalmers Playground", address1: "670 Brunswick", address2: "San Francisco, CA", thumb: "park1thumbnail")
        let parkTwo = Park(name: "Mission Dolores Park", address1: "19th and Dolores St", address2: "San Francisco, CA", thumb: "park2thumbnail")
        let parkThree = Park(name: "Laurel Hill Playground", address1: "251 Euclid Ave", address2: "San Francisco, CA", thumb: "park3thumbnail")
        let parkFour = Park(name: "Hayes Valley Playground", address1: "Hayes and Buchanan St", address2: "San Francisco, CA", thumb: "park4thumbnail")
        let parkFive = Park(name: "McKinley Square", address1: "20th St and Vermont", address2: "San Francisco, CA", thumb: "park5thumbnail")
        
        parks = [parkOne, parkTwo, parkThree, parkFour, parkFive]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParkTableViewCell", forIndexPath: indexPath)

        let park = parks[indexPath.row]
        
        cell.textLabel!.text = park.name
        cell.imageView?.image = UIImage(named: park.thumb)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let park = parks[indexPath.row]
        
        // 1. Create attribute set with desired metadata for the index item
        
        // 2. Create item with unique id, a domain id, and the attribute set
        
        // 3. Add item to default searchable index
        
        pushDetailsController(park)
    }
    
    func showPark(name: String!) {
        
        var parkToShow:Park?
        
        for park in parks {
            if park.name == name {
                parkToShow = park
            }
        }
        if parkToShow != nil {
            pushDetailsController(parkToShow)
        }
    }
    
    private func pushDetailsController(park: Park!) {
        print("In pushDetailsController")
        let parkViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ParkDetailsViewController") as! VRParkDetailsViewController
        parkViewController.park = park
        self.navigationController?.pushViewController(parkViewController, animated: true)
    }
}
