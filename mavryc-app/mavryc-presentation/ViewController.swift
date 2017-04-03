//
//  ViewController.swift
//  mavryc-presentation
//
//  Created by Jake on 3/6/17.

// FEEDBACK:TSH: We'll want to add the proper copyright to our xcode project; fortunately, xcode will do this automatically for us when we create the new project and input the organization name. If we wanted to fix this manually we could edit the organization name in the Xcode project navigator (left hand pane, left-most tab), when the project is selected.

//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit
import MapKit

// FEEDBACK:TSH: I recognize this is a prototype and the structure is likely more thrown together to function than anything else. What we'll strive for is a separation of concerns with our code. We'll strive to keep our view controllers as slim as possible and move out individual concerns into separate classes. We'll also strive to be very conscious about our naming. An example of separation of concerns is the map related work. For example, this view controller would usually know very little about the map code or components.

// FEEDBACK:TSH: The only feedback I'll give on the UI I'll give right here. We'll utilize constraints to allow items to expand/contract depending on the screen size. We'll likely make use of an AppCoordinator that will help us manage what part of the app to start in or show (basically, which storyboard to begin with). We'll utilize as many vector assets as possible to avoid graphical artifacts that come from expanding raster images.

class ViewController: UIViewController, MKMapViewDelegate{
    
    //Test Table declaration
    @IBOutlet weak var dataName: UILabel!
    
    //Mark: Top Selector Section
    
    //Top View Variable
    @IBOutlet weak var topView: UIView!
    var topViewPresent: Bool = true
    
    
    //Button Variable Declarations
    @IBOutlet weak var leftUpperLabelButton: UIButton!
    @IBOutlet weak var rightUpperLabelButton: UIButton!
    @IBOutlet weak var leftIconButton: UIButton!
    @IBOutlet weak var centerIconButton: UIButton!
    @IBOutlet weak var rightIconButton: UIButton!
    @IBOutlet weak var leftBottomTextButton: UIButton!
    @IBOutlet weak var centerBottomTextButton: UIButton!
    @IBOutlet weak var rightBottomTextButton: UIButton!
    
    //Selection Variables
    var selectionType: String?
    var planeType: String?
    
    
    //Label Declarations
    @IBOutlet weak var centerLabel: UILabel!
    
    
    //Mark: MID Section and Map
    
    //Map Declaration
    
    @IBOutlet weak var mapView: MKMapView!
    
    //Mark: Bottom Section
    @IBOutlet weak var oneWayButton: UIButton!
    @IBOutlet weak var roundTripButton: UIButton!
    var tripType: String = "oneway"
    @IBOutlet weak var dateSelectorView: UIView!
    @IBOutlet weak var oneWayBottomView: UIView!
    @IBOutlet weak var roundTripBottomView: UIView!
    
    
    @IBOutlet weak var tripButtonWrap: UIView!
    @IBOutlet weak var flyButton: UIButton!
    @IBOutlet weak var planeTypeMinimizedWrap: UIButton!
    
    
    
    
    
    
    //Button Action Declarations
    @IBAction func rightTopButton(_ sender: Any) {
        // FEEDBACK:TSH: anywhere we see literal strings here in the actual project we'll make use of both enums and other mechanisms to abstract it a little. We might have objects that represent the data/characteristics of the buttons here such as title strings, colors, properties, etc... so that the view controller doesn't have to manage this, but the buttons themselves may do so. So this code could exist in a button subclass, for example, and there would potentially be a delegate here in this class so that if the button could call the delegate, and this class might provide the implementation of that delegate method, which would allow the button to get information and set up its properties appropriately, without having this view controller concerned at all with those propoerties.
        if rightUpperLabelButton.currentTitle == "PREMIUM" {
            rightUpperLabelButton.setTitle(" ", for: .normal)
            leftUpperLabelButton.setTitle("ECONOMY", for: .normal)
            centerLabel.text = "PREMIUM"
            selectionType = "Premium"
            leftBottomTextButton.setTitle("P Mid", for: .normal)
            centerBottomTextButton.setTitle("P Super-Mid", for: .normal)
            rightBottomTextButton.setTitle("P Heavy", for: .normal)
            
        }
        if rightUpperLabelButton.currentTitle == "ECONOMY" {
            rightUpperLabelButton.setTitle("PREMIUM", for: .normal)
            leftUpperLabelButton.setTitle("STANDARD", for: .normal)
            centerLabel.text = "ECONOMY"
            leftBottomTextButton.setTitle("Mid", for: .normal)
            centerBottomTextButton.setTitle("Super-Mid", for: .normal)
            rightBottomTextButton.setTitle("Heavy", for: .normal)
            selectionType = "Economy"
        }
    }
    
    @IBAction func leftTopButton(_ sender: UIButton) {
        if leftUpperLabelButton.currentTitle == "STANDARD" {
            centerLabel.text = "STANDARD"
            leftBottomTextButton.setTitle("S Mid", for: .normal)
            centerBottomTextButton.setTitle("S Super-Mid", for: .normal)
            rightBottomTextButton.setTitle("S Heavy", for: .normal)
            rightUpperLabelButton.setTitle("ECONOMY", for: .normal)
            leftUpperLabelButton.setTitle(" ", for: .normal)
            selectionType = "Standard" // rather than having this as a string, enums are especially awesome in swift and we'll want to take advantage of them here and a lot more places too.
        }
        if leftUpperLabelButton.currentTitle == "ECONOMY" {
            centerLabel.text = "ECONOMY"
            leftBottomTextButton.setTitle("Mid", for: .normal)
            centerBottomTextButton.setTitle("Super-Mid", for: .normal)
            rightBottomTextButton.setTitle("Heavy", for: .normal)
            rightUpperLabelButton.setTitle("PREMIUM", for: .normal)
            leftUpperLabelButton.setTitle("STANDARD", for: .normal)
            selectionType = "Economy"
        }
    }
    
    @IBAction func centerButtonAction(_ sender: UIButton) {
        print("Did this work?")
        planeTypeMinimizedWrap.isHidden = false
        topView.isHidden = true
    }
    @IBAction func leftButtonAction(_ sender: UIButton) {
        planeTypeMinimizedWrap.isHidden = false
        topView.isHidden = true
    }
    @IBAction func rightButtonAction(_ sender: UIButton) {
        planeTypeMinimizedWrap.isHidden = false
        topView.isHidden = true
    }
    @IBAction func planeTypeMinimizedAction(_ sender: UIButton) {
        planeTypeMinimizedWrap.isHidden = true
        topView.isHidden = false
    }
  
    
    @IBAction func rightIconButton(_ sender: Any) {
//        topView.removeFromSuperview()
        topViewPresent = false
    }
    
    @IBAction func centerIconButton(_ sender: Any) {
//        topView.removeFromSuperview()
        topViewPresent = false
    }
    
    @IBAction func leftIconButton(_ sender: Any) {
//        topView.removeFromSuperview()
        topViewPresent = false
    }
    
    //Bottom Functionality
    
    @IBAction func oneWayClicked(_ sender: Any) {
        if tripType != "oneway" {
            tripType = "oneway" // great use for enums
            roundTripButton.setTitleColor(UIColor(red: (24/255.0), green: (77/255.0), blue: (147/255.0), alpha: 1.0), for: .normal) // the colors and style properties we'll move into an AppStyle class so the place that the color is assigned, such as here or in the button's class could simply call something like self.setTitleColor = AppStyle.oneWayButtonColorTitleColor - This will allow for much safer alterations to style elements without changes all over the place
            roundTripButton.backgroundColor = UIColor.white
            oneWayButton.setTitleColor(UIColor.white, for: .normal)
            oneWayButton.backgroundColor = UIColor(red: (24/255.0), green: (77/255.0), blue: (147/255.0), alpha: 1.0)
            oneWayButton.layer.cornerRadius = 5
            oneWayBottomView.isHidden = false
            roundTripBottomView.isHidden = true


            //Change Button colors and Title Colors
            //Render one way collection view
        }
    }
    
    @IBAction func roundTripClicked(_ sender: Any) {
        if tripType != "roundtrip" {
            tripType = "roundtrip"
            oneWayButton.setTitleColor(UIColor(red: (24/255.0), green: (77/255.0), blue: (147/255.0), alpha: 1.0), for: .normal)
            oneWayButton.backgroundColor = UIColor.white
            roundTripButton.setTitleColor(UIColor.white, for: .normal)
            roundTripButton.backgroundColor = UIColor(red: (24/255.0), green: (77/255.0), blue: (147/255.0), alpha: 1.0)
            roundTripButton.layer.cornerRadius = 5
            oneWayBottomView.isHidden = true
            roundTripBottomView.isHidden = false
            //Change Button colors and Title Colors
            //Render round trip collection view
        }
    }
    
    

    
    
    override func viewDidLoad() {
        
        // Button border radius
        roundTripButton.layer.cornerRadius = 4 // property settings like this can also be done up at the property declaration inside of {}s to allow for more direct setup of visual elements at the site of the object itself rather than in viewDidLoad. Ideally however this stuff can be done in the view level in the awakeFromNib method rather than the view controller level of scope, but it can really go either way.
        oneWayButton.layer.cornerRadius = 4
        tripButtonWrap.layer.cornerRadius = 4
        flyButton.layer.cornerRadius = 20
        planeTypeMinimizedWrap.layer.cornerRadius = 4
        

        super.viewDidLoad()
    
        
        
        // again, here tripType would be way better as an enum
        if tripType == "oneway" {
            roundTripBottomView.isHidden = true
        }
        if tripType == "roundtrip" {
            oneWayBottomView.isHidden = true
        }
        
        planeTypeMinimizedWrap.isHidden = true
        
        // 1.
        mapView.delegate = self
        
        // 2.
        let sourceLocation = CLLocationCoordinate2D(latitude: 33.501324, longitude: -111.925278)
        let destinationLocation = CLLocationCoordinate2D(latitude: 	36.174465, longitude: -86.767960)
        
        // 3.
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Scottdale, AZ"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        // A lot of this map stuff should be moved into another class to allow this view controller to be as thin as possible to avoid unneeded coupling.
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Nashville, TN"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
        
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

