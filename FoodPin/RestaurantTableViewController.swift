//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Mohit Deshpande on 22/01/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "Thai Cafe"]
    
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg",
        "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg",
        "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg",
        "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg",
        "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney",
        "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop",
        "Cafe", "Tea House", "Austrian / Causual Drink",
        "French", "Bakery", "Bakery", "Chocolate", "Cafe",
        "American / Seafood", "American", "American",
        "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish",
        "Spanish", "British", "Thai"]

    // keep track of the checked objects
    var restaurantIsVisited = [Bool](count: 21, repeatedValue: false)
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return restaurantNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CustomTableViewCell

        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        // make images into circular images
        //cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        //cell.thumbnailImageView.clipsToBounds = true
        cell.isVisitedIcon.hidden = restaurantIsVisited[indexPath.row] ? false : true
        
        return cell
    }
    
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Create an option menu as action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .ActionSheet)
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
      
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style:
            UIAlertActionStyle.Default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        let isVisitedAction = UIAlertAction(title: restaurantIsVisited[indexPath.row] ? "I haven't been here" : "I've been here", style: .Default, handler: {
            (action:UIAlertAction!) -> Void in
                let cell = tableView.cellForRowAtIndexPath(indexPath) as CustomTableViewCell
                cell.isVisitedIcon.hidden = self.restaurantIsVisited[indexPath.row] ? true : false
                self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
        })
        
        optionMenu.addAction(isVisitedAction)
        
        //Display the menu
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        // Deselect the row after task is done
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    */
    
    //add the swipe to delete functionality
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            //Delete the row from the data source
            self.restaurantNames.removeAtIndex(indexPath.row)
            self.restaurantTypes.removeAtIndex(indexPath.row)
            self.restaurantLocations.removeAtIndex(indexPath.row)
            self.restaurantIsVisited.removeAtIndex(indexPath.row)
            self.restaurantImages.removeAtIndex(indexPath.row)
            
            // finally delete that particular row
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }

    }
    
    // add swipe actions for the table
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var shareAction = UITableViewRowAction(style: .Default, title: "Share", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                let shareMenu = UIAlertController(title: nil, message: "Share Using", preferredStyle: .ActionSheet)
                let twitterAction = UIAlertAction(title: "Twitter", style: .Default, handler: nil)
                let facebookAction = UIAlertAction(title: "Facebook", style: .Default, handler: nil)
                let emailAction = UIAlertAction(title: "Email", style: .Default, handler: nil)
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
                shareMenu.addAction(twitterAction)
                shareMenu.addAction(facebookAction)
                shareMenu.addAction(emailAction)
                shareMenu.addAction(cancelAction)
            
                self.presentViewController(shareMenu, animated: true, completion: nil)
        })
    
        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            //Delete the row from the data source
            self.restaurantNames.removeAtIndex(indexPath.row)
            self.restaurantTypes.removeAtIndex(indexPath.row)
            self.restaurantLocations.removeAtIndex(indexPath.row)
            self.restaurantIsVisited.removeAtIndex(indexPath.row)
            self.restaurantImages.removeAtIndex(indexPath.row)
            
            // finally delete that particular row
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        })
        
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let destinationController = segue.destinationViewController as DetailViewController
                destinationController.restaurantImage = self.restaurantImages[indexPath.row]
                destinationController.restaurantName = self.restaurantNames[indexPath.row]
                destinationController.restaurantType = self.restaurantTypes[indexPath.row]
                destinationController.restaurantLocation = self.restaurantLocations[indexPath.row]
            }
        }
    }
    

}
