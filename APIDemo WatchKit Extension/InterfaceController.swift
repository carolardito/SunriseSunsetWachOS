//
//  InterfaceController.swift
//  APIDemo WatchKit Extension
//
//  Created by Parrot on 2019-03-03.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire
import SwiftyJSON

class InterfaceController: WKInterfaceController {

    // MARK: Outlets
    @IBOutlet var sunriseTimeLabel: WKInterfaceLabel!
    @IBOutlet var sunsetTimeLabel: WKInterfaceLabel!
    
    @IBOutlet var loadingImage: WKInterfaceImage!
    
    @IBOutlet var cityLabel: WKInterfaceLabel!
    
    
    
    // MARK: Default functions
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // 1. when the app starts, show the loading animation
        // 2. go get data from website
        // 3. when you get the data,
        //       -stop the animation (hide the animation)
        //       - update the labels with sunrise/sunset data
        
        let sharedPreferences = UserDefaults.standard
        var city = sharedPreferences.string(forKey: "city")
        if (city == nil) {
            city = "Vancouver" 
            print("no city was set")
        }
        else{
            print("i FOUND A CITY \(city)")
        }
        
        self.cityLabel.setText(city)
        
        // 1. start the animation
        self.loadingImage.setImageNamed("Progress")
        self.loadingImage.startAnimatingWithImages(in: NSMakeRange(0, 10), duration: 2, repeatCount: 0)
        
        // 2. UPDATE THE LABELS SO USER KNOWS TEH DATA IS LOADING
        self.sunriseTimeLabel.setText("Updating...")
        self.sunsetTimeLabel.setText("Updating...")
     
        
        
        
        
        // ---------------
        
        let URL = "https://api.sunrise-sunset.org/json?lat=49.2827&lng=-123.1207&date=today"
        
        Alamofire.request(URL).responseJSON {
            // 1. store the data from the internet in the
            // response variable
            response in
            
            // 2. get the data out of the variable
            guard let apiData = response.result.value else {
                print("Error getting data from the URL")
                return
            }
            
            // OUTPUT the json response to the terminal
            print(apiData)
            
            
            // GET something out of the JSON response
            let jsonResponse = JSON(apiData)
            let sunriseTime = jsonResponse["results"]["sunrise"].string
            let sunsetTime = jsonResponse["results"]["sunset"].string
            
            print("Sunrise: \(sunriseTime)")
            print("Sunset: \(sunsetTime)")
            
            // stop the animation
            self.loadingImage.stopAnimating()
            // and then hide it
            self.loadingImage.setImageNamed(nil)
            
            
            // show the sunrise and sunset in the IPhone App
            self.sunriseTimeLabel.setText("\(sunriseTime!)")
            self.sunsetTimeLabel.setText("\(sunsetTime!)")
            
        }
        
        // ---------------
    }
   
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
