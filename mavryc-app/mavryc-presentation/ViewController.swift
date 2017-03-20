//
//  ViewController.swift
//  mavryc-presentation
//
//  Created by Jake on 3/6/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, MKMapViewDelegate {
    
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
            selectionType = "Standard"
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
            tripType = "oneway"
            roundTripButton.setTitleColor(UIColor(red: (24/255.0), green: (77/255.0), blue: (147/255.0), alpha: 1.0), for: .normal)
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
        roundTripButton.layer.cornerRadius = 4
        oneWayButton.layer.cornerRadius = 4
        tripButtonWrap.layer.cornerRadius = 4
        flyButton.layer.cornerRadius = 20
        planeTypeMinimizedWrap.layer.cornerRadius = 4
        
        
        super.viewDidLoad()
        
        //JSON Test
        let todoEndpoint: String = "http://localhost:3000/"
        Alamofire.request(todoEndpoint)
            .responseJSON { response in
                // check for errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET")
                    print(response.result.error!)
                    return
                }
                
                // make sure we got some JSON since that's what we expect
                guard (response.result.value as? [String: Any]) != nil else {
                    print("didn't get todo object as JSON from API")
                    print("Error: \(response.result.error)")
                    return
                }
                
                // get and print
                print(response.result.value!)
        }
        

        
        
        
        
        
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

