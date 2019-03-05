//
//  ChangeCityInterfaceController.swift
//  APIDemo
//
//  Created by MacStudent on 2019-03-05.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation


class ChangeCityInterfaceController: WKInterfaceController {
    
    // MARK: Actions
    var cityName:String?

    @IBOutlet var cityLabel: WKInterfaceLabel!
    
    @IBAction func saveCityBtn() {
        let sharedPref = UserDefaults.standard
        sharedPref.set(self.cityName, forKey: "city")
        print("Saved \(self.cityName) to shared preferences!")
        
        // send the person back to previous screen
        self.popToRootController()

    }
    
    @IBAction func pickCityBtn() {
        let suggestedResponses = ["Toronto", "Sao Paulo", "Bruxels", "Ottawa"]
        presentTextInputController(withSuggestions: suggestedResponses, allowedInputMode: .plain) { (results) in
            
            
            if (results != nil && results!.count > 0) {
                // 2. write your code to process the person's response
                let userResponse = results?.first as? String
                self.cityLabel.setText(userResponse)// 3. also save the user's choice to the cityName variable
                self.cityName = userResponse

            }
        }

    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        print("I loaded page 2")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
