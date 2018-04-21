//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Mohit Deshpande on 06/02/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dialogView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // add blur effect
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // apply initial transforms for animation
        //let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
        //let translate = CGAffineTransform(translationX: 0, y: 500)
        //dialogView.transform = scale.concatenating(translate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // create the animation effect of the dialogView
//        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: nil, animations: {
//            
//            let scale = CGAffineTransformMakeScale(1, 1)
//            let translate = CGAffineTransformMakeTranslation(0, 0)
//            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
//            
//        }, completion: nil)
//    
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
