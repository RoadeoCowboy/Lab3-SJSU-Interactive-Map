//
//  ViewController.swift
//  SJSU Map
//
//  Created by Chen, David on 11/1/15.
//  Copyright © 2015 Chen, David. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
              // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  

    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformScale(view.transform,
                recognizer.scale, recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
    @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    @IBAction func handleTap(recognizer : UITapGestureRecognizer) {
        var loc: CGPoint
        let point = recognizer.locationInView(recognizer.view)
        print("The point is: ", point)
        
        
        if (point.x <= 68.0 && point.x >= 44.0){
            if (point.y <= 236.0 && point.y >= 168.0){
                print("This is King Library.")
                //prepare segue
                //perform segue
                loc = point
//                prepareForSegue(segue: UIStoryboardSegue, sender: loc)
                
//                let alertController = UIAlertController(title: "King Library", message: "Dr. Martin Luther King, Jr. Library, 150 East San Fernando Street, San Jose, CA 95112", preferredStyle: .Alert)
//                
//                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
//                    
//                }
//                alertController.addAction(cancelAction)
//                
//                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
//                   
//                }
//                alertController.addAction(OKAction)
//                
//                self.presentViewController(alertController, animated: true) {
//                    
//                }
            }
        }
        func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
            if (point.x <= 245.0 && point.x >= 196){
                if(point.y <= 160 && point.y >= 236){
                    print("This is Engineering Building.")
                    loc = point
                    if(segue.identifier == "EngSegue"){
                        
                    }
                }
            
            }
        }
//
//        if (point.x == 45.5 && point.y == 388.5){
//            print("This is Yoshihiro Uchida Hall.")
//        }
//        
//        if (point.x == 218.5 && point.y == 284.5){
//            print("This is Student Union.")
//        }
//        
//        if (point.x == 316.5 && point.y == 343.0){
//            print("This is BBC.")
//        }
//        
//        if (point.x == 144.0 && point.y == 527.5){
//            print("This is South Parking Garage.")
//        }
     
    }
}

