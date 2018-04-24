//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Mohit Deshpande on 22/01/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po HingFong, Sheung Wan, Hong Kong", image: "cafedeadend.jpg", isVisited: true),
        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San        Street SOHO, Sheung Wan, Hong Kong", image: "homei.jpg", isVisited: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road        SOHO, Sheung Wan, Hong Kong", image: "teakha.jpg", isVisited: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20        Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "cafeloisl.jpg", isVisited: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road        SOHO, Sheung Wan, Hong Kong", image: "petiteoyster.jpg", isVisited: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop J-K., 200        Hollywood Road, SOHO, Sheung Wan, Hong Kong", image: "forkeerestaurant.jpg", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong,        Sheung Wan, Hong Kong", image: "posatelier.jpg", isVisited: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St        Sydney New South Wales 2010 Surry Hills", image: "bourkestreetbakery.jpg", isVisited: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney        New South Wales", image: "haighschocolate.jpg", isVisited: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61        York St Sydney New South Wales", image: "palominoespresso.jpg", isVisited: false),
        Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY        10003", image: "upstate.jpg", isVisited: false),
        Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY        11211", image: "traif.jpg", isVisited: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445        Graham Ave Brooklyn, NY 11211", image: "grahamavenuemeats.jpg", isVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave        Brooklyn, NY 11211", image: "wafflewolf.jpg", isVisited: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave        Brooklyn, NY 11222", image: "fiveleaves.jpg", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th        Ave Brooklyn, NY 11220", image: "cafelore.jpg", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY        10003", image: "confessional.jpg", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D        4SL United Kingdom", image: "barrafina.jpg", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H        7ND United Kingdom", image: "donostia.jpg", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P        4BZ United Kingdom", image: "royaloak.jpg", isVisited: false),
        Restaurant(name: "Thai Cafe", type: "Thai", location: "22 Charlwood Street London SW1V        2DY Pimlico", image: "thaicafe.jpg", isVisited: false)
        ]

    
    override var prefersStatusBarHidden : Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // enable self-sizing cells
        tableView.estimatedRowHeight = 18.0
        tableView.rowHeight = UITableViewAutomaticDimension
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.restaurants.count
    }
    func getRestaurants()-> [Restaurant]{
        let headers = [
            "Authorization": "Bearer YEXFXXvgjj01-tx8I-gaGmycaJCY-bryGRKY6UtW66o6QmtaclkmkgP9ZFSqZsP8OKQjCbhh8drrD7EX3X8aotUTqKosLxJs2tWZZuiwR-P4n-G43dNC2LndjkfeWnYx",
            "Cache-Control": "no-cache",
            "Postman-Token": "6b19d7c5-1a5c-4b4b-8de6-8ed79fd0ba11"
        ]
        var restaurants=[Restaurant]()
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?location=toronto&limit=50")!
        var request=URLRequest(url:url);
        request.allHTTPHeaderFields=headers
        let task = URLSession.shared.dataTask(with: request){(data,response,error) in
            
            if error != nil {
                print(error!)
            }else{
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]]
                        print(jsonResult!)
                        
                        for obj in jsonResult! {
                            var restaurant=Restaurant(name: obj["name"] as! String, type: obj["categories"][0]["title"] as! String, location: obj["location"]["address1"] as! String,image: obj["image_url"] as! String, isVisited: false)
                            restaurants.append(restaurant)
                        }
                    } catch {
                        print("JSon processing Failed")
                    }
                    
                }
            }
        }
        task.resume()
        
        return restaurants;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell

        // Configure the cell...
        cell.nameLabel.text = self.restaurants[indexPath.row].name
        cell.typeLabel.text = self.restaurants[indexPath.row].type
        cell.locationLabel.text = self.restaurants[indexPath.row].location
        cell.thumbnailImageView.image = UIImage(named: self.restaurants[indexPath.row].image)
        // make images into circular images
        //cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        //cell.thumbnailImageView.clipsToBounds = true
        //cell.isVisitedIcon.hidden = self.restaurants[indexPath.row].isVisited ? false : true
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //Delete the row from the data source
            self.restaurants.remove(at: indexPath.row)
            
            // finally delete that particular row
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }

    }
    
    // add swipe actions for the table
//    override func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: IndexPath) -> [AnyObject]? {
//        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
//                let shareMenu = UIAlertController(title: nil, message: "Share Using", preferredStyle: .actionSheet)
//                let twitterAction = UIAlertAction(title: "Twitter", style: .default, handler: nil)
//                let facebookAction = UIAlertAction(title: "Facebook", style: .default, handler: nil)
//                let emailAction = UIAlertAction(title: "Email", style: .default, handler: nil)
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            
//                shareMenu.addAction(twitterAction)
//                shareMenu.addAction(facebookAction)
//                shareMenu.addAction(emailAction)
//                shareMenu.addAction(cancelAction)
//            
//                self.present(shareMenu, animated: true, completion: nil)
//        })
//    
//        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
//            //Delete the row from the data source
//            self.restaurants.remove(at: indexPath.row)
//            
//            // finally delete that particular row
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
//        })
//        
//        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue: 51.0/255.0, alpha: 1.0)
//        
//        return [deleteAction, shareAction]
//    }

    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailViewController
                destinationController.restaurant = self.restaurants[indexPath.row]
            }
        }
    }
    

}
