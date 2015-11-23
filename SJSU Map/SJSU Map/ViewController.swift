//
//  ViewController.swift
//  SJSU Map
//
//  Created by Chen, David on 11/1/15.
//  Copyright © 2015 Chen, David. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UIScrollViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var searchBar2: UISearchBar!
//    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var kingRect: UIView!
    @IBOutlet weak var engRect: UIView!
    @IBOutlet weak var pin: UIView!
    @IBOutlet weak var yuhRect: UIView!
    @IBOutlet weak var suRect: UIView!
    @IBOutlet weak var bbcRect: UIView!
    @IBOutlet weak var spgRect: UIView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    let currentLat = CGFloat(200)
    let currentLong = CGFloat(500)
    
//    var lat: Double = 0.0
//    var long: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar2.delegate = self
        kingRect.hidden = true
        engRect.hidden = true
        yuhRect.hidden = true
        suRect.hidden = true
        bbcRect.hidden = true
        spgRect.hidden = true
              // Do any additional setup after loading the view, typically from a nib.
//        self.locationManager.requestAlwaysAuthorization()
//        
//        self.locationManager.requestWhenInUseAuthorization()
//        
//        if (CLLocationManager.locationServicesEnabled()){
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil
       
       
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let latitude = Float(locValue.latitude)
        let longitude = Float(locValue.longitude)
        
        addCircleView(lat: latitude, long: longitude)
        
        
//        self.pin.center = CGPointMake(x, y)
    }
    
//    func locationManager(manager: CLLocationManager!,
//        didUpdateLocations locations: [CLLocation]!)
//    {
//        
//        let latestLocation: AnyObject = locations[locations.count - 1]
//        
//
//        print("Lat is: \(latestLocation.coordinate.latitude)")
//        print("Long is: \(latestLocation.coordinate.longitude)")
//
//        if startLocation == nil {
//            startLocation = latestLocation as! CLLocation
//        }
////*******************NOt Needed********************
////        var distanceBetween: CLLocationDistance =
////        latestLocation.distanceFromLocation(startLocation)
////        
////        distance.text = String(format: "%.2f", distanceBetween)
////*******************Not Needed**********************
//
//    }
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError) {
    }
    
    func addCircleView(lat a: Float, long b: Float) {
        
        let expX = (707 * (fabs(b)-121.886478)/(121.876243-121.886478))
        let x = CGFloat(expX - 160)
        let expY = (fabs(a)-37.331361)/(37.338800-37.331361)
        let y = CGFloat(707 - (707 * expY) + 30)
        
        let circleWidth = CGFloat(20)
        let circleHeight = circleWidth
        // Create a new CircleView
        let circleView = Circles(frame: CGRectMake(x, y, circleWidth, circleHeight))
        
        view.addSubview(circleView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func searchBar(searchBar2: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")   //Displays input as it is being entered.
    }
    
    func searchBarSearchButtonClicked(searchBar2: UISearchBar) {
        print("searchText \(searchBar2.text)")  //Displays entire searchString.
        let searchString = searchBar2.text
        
        kingRect.hidden = true
        engRect.hidden = true
        yuhRect.hidden = true
        suRect.hidden = true
        bbcRect.hidden = true
        spgRect.hidden = true
        
        if(searchString?.lowercaseString == "king"){
            kingRect.hidden = false
        }
        if(searchString?.lowercaseString == "eng"){
            engRect.hidden = false
        }
        if(searchString?.lowercaseString == "yuh"){
            yuhRect.hidden = false
        }
        if(searchString?.lowercaseString == "su"){
            suRect.hidden = false
        }
        if(searchString?.lowercaseString == "bbc"){
            bbcRect.hidden = false
        }
        if(searchString?.lowercaseString == "spg"){
            spgRect.hidden = false
        }

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
//        var loc2: CGPoint
        let point = recognizer.locationInView(recognizer.view)
        print("The point is: ", point)
        
        if (point.x >= 144.0 && point.x <= 202.0){
            if(point.y >= 117.0 && point.y <= 181.0){
                print("This is Engineering Building.")
                loc = point
                let engViewController = EngBldgViewController()
                navigationController?.pushViewController(engViewController, animated: true)
            }
        }
        
        if (point.x >= 10.5 && point.x <= 62.0){
            if (point.y >= 207.0 && point.y <= 273.5){
                print("This is King Library.")
                //prepare segue
                //perform segue
                loc = point
                let kingLibraryViewController = KingLibraryViewController()
                navigationController?.pushViewController(kingLibraryViewController, animated: true)
            }
        }
        
        if (point.x >= 66.0 && point.x <= 112.0){
            if (point.y >= 356.5 && point.y <= 414.0){
                print("This is Yoshihiro Uchida Hall.")
                //prepare segue
                //perform segue
                loc = point
                let yuhViewController = YuhBldgViewController()
                navigationController?.pushViewController(yuhViewController, animated: true)
            }
        }
        
        if (point.x >= 177.0 && point.x <= 246.0){
            if (point.y >= 157.5 && point.y <= 219.5){
                print("This is Student Union.")
                //prepare segue
                //perform segue
                loc = point
                let suViewController = SuViewController()
                navigationController?.pushViewController(suViewController, animated: true)
            }
        }
        
        if (point.x >= 272.5 && point.x <= 310.5){
            if (point.y >= 135.0 && point.y <= 182.5){
                print("This is Boccardo Business Complex.")
                //prepare segue
                //perform segue
                loc = point
                let bbcViewController = BBCBldgViewController()
                navigationController?.pushViewController(bbcViewController, animated: true)
            }
        }
        
        if (point.x >= 180.0 && point.x <= 237.0){
            if (point.y >= 406.0 && point.y <= 462.0){
                print("This is South Parking Garage.")
                //prepare segue
                //perform segue
                loc = point
                let spgViewController = SPGViewController()
                navigationController?.pushViewController(spgViewController, animated: true)
            }
        }
     
    }
}

