//
//  VRParksViewController.swift
//  VRCoreSpotlightExample
//
//  Created by Jeremy Medford on 1/12/16.
//  Copyright © 2016 Vintage Robot. All rights reserved.
//

import UIKit

struct Park {
    var name = "Park"
    var address1 = "Some Street"
    var address2 = "Some City and State"
}

class VRParksViewController: UITableViewController {
    
    var parks = [Park]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "San Francisco Parks"
        
        let parkOne = Park(name: "Alice Chalmers Playground", address1: "670 Brunswick", address2: "San Francisco, CA")
        let parkTwo = Park(name: "Mission Dolores Park", address1: "19th and Dolores St", address2: "San Francisco, CA")
        let parkThree = Park(name: "Laurel Hill Playground", address1: "251 Euclid Ave", address2: "San Francisco, CA")
        let parkFour = Park(name: "Hayes Valley Playground", address1: "Hayes and Buchanan St", address2: "San Francisco, CA")
        let parkFive = Park(name: "McKinley Square", address1: "20th St and Vermont", address2: "San Francisco, CA")
        
        parks = [parkOne, parkTwo, parkThree, parkFour, parkFive]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let park = parks[indexPath.row]
        
        let parkViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ParkDetailsViewController") as! VRParkDetailsViewController
        parkViewController.park = park
        
        self.navigationController?.pushViewController(parkViewController, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        let viewController = segue.destinationViewController as! VRParkDetailsViewController
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let park = parks[self.tableView.indexPathForCell(cell)!.row]
        viewController.park = park
    }
    

}
