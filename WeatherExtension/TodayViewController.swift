//
//  TodayViewController.swift
//  WeatherExtension
//
//  Created by Matt Milner on 8/15/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var currentTempLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = CGSize(width: 0, height: 30)
    
        let userDefaults = NSUserDefaults(suiteName: "group.mattmilner.weatherextension")
        
        guard let currentTemp = userDefaults?.valueForKey("temp") as? Double else {
            fatalError("temp is not found")
        }
        
        //let currentTemp = userDefaults?.valueForKey("temp") as! String
        
        self.currentTempLabel.text = String(currentTemp)
        self.currentTempLabel.textColor = UIColor.whiteColor()
        
        print(currentTemp)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        


        completionHandler(NCUpdateResult.NewData)
    }
    
}
