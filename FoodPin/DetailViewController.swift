//
//  DetailViewController.swift
//  FoodPin
//
//  Created by Mohit Deshpande on 23/01/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //change table view appearance
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        // remove extra seperator from the table view
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        //change color of the seperator
        self.tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
    
        //circular image
        self.restaurantImageView.image = UIImage(named: restaurant.image)
        //restaurantImageView.layer.cornerRadius = restaurantImageView.frame.size.width / 2
        //restaurantImageView.clipsToBounds = true
        
        // set title of navigation bar
        self.navigationItem.title = restaurant.name
        
        // Enable Self Sizing Cells
        tableView.estimatedRowHeight = 320.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailTableViewCell
        
        // Configure the cell...
        cell.mapButton.isHidden = true
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
            cell.mapButton.isHidden = false
        case 3:
            cell.fieldLabel.text = "Been Here"
            cell.valueLabel.text = restaurant.isVisited ? "Yes, I've been here before" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    func getReviews(id: String) -> [Review]{
        let headers = [
            "Authorization": "Bearer YEXFXXvgjj01-tx8I-gaGmycaJCY-bryGRKY6UtW66o6QmtaclkmkgP9ZFSqZsP8OKQjCbhh8drrD7EX3X8aotUTqKosLxJs2tWZZuiwR-P4n-G43dNC2LndjkfeWnYx",
            "Cache-Control": "no-cache",
            "Postman-Token": "6b19d7c5-1a5c-4b4b-8de6-8ed79fd0ba11"
        ]
        var reviews=[Review]()
        let url = URL(string: "https://api.yelp.com/v3/businesses/"+id+"/reviews")!
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
                            var review=Review(id: obj["id"] as! String, rating: obj["rating"] as! Int, text: obj["text"] as! String,time_created: obj["time_created"] as! String, url: obj["url"] as! String)
                            reviews.append(review)
                        }
                    } catch {
                        print("JSon processing Failed")
                    }
                    
                }
            }
        }
        task.resume()
        
        return reviews;

    }
    @IBAction func close(_ segue: UIStoryboardSegue) {
    
    }
    

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
        }
    }
    

}
