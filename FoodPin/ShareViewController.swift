//
//  ShareViewController.swift
//  FoodPin
//
//  Created by Mohit Deshpande on 06/02/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // apply initial transforms for animation
        facebookButton.transform = CGAffineTransformMakeTranslation(0, 500)
        emailButton.transform = CGAffineTransformMakeTranslation(0, 500)
        twitterButton.transform = CGAffineTransformMakeTranslation(0, -700)
        messageButton.transform = CGAffineTransformMakeTranslation(0, -700)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        UIButton.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: nil, animations: {
            
            self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.emailButton.transform = CGAffineTransformMakeTranslation(0, 0)
            
        }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: nil, animations: {
            
            self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.messageButton.transform = CGAffineTransformMakeTranslation(0, 0)
            
            }, completion: nil)
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
