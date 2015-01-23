//
//  DetailViewController.swift
//  FoodPin
//
//  Created by Mohit Deshpande on 23/01/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantTypeLabel: UILabel!
    @IBOutlet weak var restaurantLocationLabel: UILabel!
    
    var restaurantImage: String!
    var restaurantName: String!
    var restaurantType: String!
    var restaurantLocation: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.restaurantNameLabel.text = restaurantName
        self.restaurantTypeLabel.text = restaurantType
        self.restaurantLocationLabel.text = restaurantLocation
        self.navigationItem.title = restaurantName
        //circular image
        self.restaurantImageView.image = UIImage(named: restaurantImage)
        restaurantImageView.layer.cornerRadius = restaurantImageView.frame.size.width / 2.5
        restaurantImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
