//
//  SPGViewController.swift
//  SJSU Map
//
//  Created by Chen, David on 11/13/15.
//  Copyright © 2015 Chen, David. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class SPGViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    var lat: String = "37.337318"
    var long: String = "-121.882212"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "South Parking Garage"
        view.backgroundColor = UIColor.whiteColor()
        //        engImageView.frame = view.bounds
        engImageView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height/2)
        view.addSubview(engImageView)
        
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.startLocation = nil
        
        
        let address1 = UILabel(frame: CGRectMake(0, 320, self.view.bounds.width, self.view.bounds.height/8))
        address1.text = "SJSU South Garage"
        view.addSubview(address1)
        
        
        let address2 = UILabel(frame: CGRectMake(0, 350, self.view.bounds.width, self.view.bounds.height/8))
        address2.text = "Address: 330 S. 7th St. San Jose, CA 95112"
        view.addSubview(address2)
        
        
        let distanceA = UILabel(frame: CGRectMake(0, 380, self.view.bounds.width, self.view.bounds.height/8))
        
        let time = UILabel(frame: CGRectMake(0, 410, self.view.bounds.width, self.view.bounds.height/8))
        
        var myDistance: String = ""
        var myTime: String = ""
        
        var getHTTPrequest: String?{
            let URL = "https://maps.googleapis.com/maps/api/distancematrix/json?"
            let origins = "origins=\(lat),\(long)&"
            let destinations = "destinations=37.333181,-121.880874&"
            let departTime = "departure_time=now&"
            let traffic = "traffic_model=best_guess&"
            let mode = "mode=walking&"
            let APIKey = "key=AIzaSyAUYF7G8hj1Lj68sw0Ixu8xyOnEVbgv4_M"
            
            return URL+origins+destinations+departTime+mode+traffic+APIKey
        }
        
        //        let url = NSURL(string: "https://maps.googleapis.com/maps/api/distancematrix/json?origins=200,500&destinations=219,193&departure_time=now&traffic_model=best_guess&key=AIzaSyAUYF7G8hj1Lj68sw0Ixu8xyOnEVbgv4_M")
        print("HTTPrequest String is: \(getHTTPrequest)")
        
        let url = NSURL(string: getHTTPrequest!)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            var err: NSError?
            
            do{
                var jsonTest = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                
                let json = JSON(jsonTest)
                //                print ("This JSON is: \(json)")
                myDistance = json["rows"][0]["elements"][0]["distance"]["text"].string!
                myTime = json["rows"][0]["elements"][0]["duration"]["text"].string!
                
                print("myDistance is: \(myDistance)")
                print("myTime is: \(myTime)")
                
                dispatch_async(dispatch_get_main_queue(), {
                    //perform all UI stuff here
                    distanceA.text = ("Distance: \(myDistance)")
                    time.text = ("Time: \(myTime)")
                    self.view.addSubview(distanceA)
                    self.view.addSubview(time)
                })
                
                
            } catch{
                print("error serializing JSON: \(error)")
            }
            
            
        }   //end task
        task.resume()
        
        
        // Do any additional setup after loading the view.
    }   //end viewDidLoad()
    
    func locationManager(manager: CLLocationManager!,
        didUpdateLocations locations: [CLLocation]!)
    {
        
        let latestLocation: AnyObject = locations[locations.count - 1]
        
        //        latitude.text = String(format: "%.4f",
        //            latestLocation.coordinate.latitude)
        //        longitude.text = String(format: "%.4f",
        //            latestLocation.coordinate.longitude)
        //        horizontalAccuracy.text = String(format: "%.4f",
        //            latestLocation.horizontalAccuracy)
        //        altitude.text = String(format: "%.4f",
        //            latestLocation.altitude)
        //        verticalAccuracy.text = String(format: "%.4f",
        //            latestLocation.verticalAccuracy)
        
        print("Lat is: \(latestLocation.coordinate.latitude)")
        print("Long is: \(latestLocation.coordinate.longitude)")
        
        self.lat = String(latestLocation.coordinate.latitude)
        self.long = String(latestLocation.coordinate.longitude)
        
        if startLocation == nil {
            startLocation = latestLocation as! CLLocation
        }
        
        //        var distanceBetween: CLLocationDistance =
        //        latestLocation.distanceFromLocation(startLocation)
        //
        //        distance.text = String(format: "%.2f", distanceBetween)
    }
    
    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
    }
    
    
    var engImageView: UIImageView = {
        let image = UIImage(named: "SPG.jpg")
        let imageView = UIImageView(image: image)
        return imageView
        }()
    
    //    var address = UILabel(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height/8))
    
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
