//
//  ViewController.swift
//  TodaysWeatherExtension
//
//  Created by Matt Milner on 8/15/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //temperature, summary, humidity, visibility, windspeed

    
    var locationManager: CLLocationManager!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var windspeed: UILabel!

    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        

        getWeather()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }

    
    private func getWeather() {
        
        let latitude = self.locationManager!.location!.coordinate.latitude
        let longitude = self.locationManager!.location!.coordinate.longitude
        
        
        let weatherAPI = "https://api.forecast.io/forecast/ee590865b8cf07d544c96463ae5d47c5/\(latitude),\(longitude)"
        
        guard let url = NSURL(string: weatherAPI) else {
            fatalError("Invalid URL")
        }
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            
            guard let jsonResult = NSString(data: data!, encoding: NSUTF8StringEncoding) else {
                fatalError("Unable to Format Data")
            }
            
            let weatherInfo = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            

            let currentWeather = weatherInfo["currently"] as! NSDictionary
            
            print(currentWeather)
            
            //    apparentTemperature = "60.01";
//            cloudCover = "0.67";
//            dewPoint = "53.44";
//            humidity = "0.79";
//            icon = "partly-cloudy-day";
//            nearestStormBearing = 334;
//            nearestStormDistance = 3;
//            ozone = "287.74";
//            precipIntensity = 0;
//            precipProbability = 0;
//            pressure = "1013.67";
//            summary = "Mostly Cloudy";
//            temperature = "60.01";
//            time = 1471274971;
//            visibility = "8.19";
//            windBearing = 267;
//            windSpeed = "2.14";
            
            
            let defaults = NSUserDefaults(suiteName: "group.mattmilner.weatherextension")
            defaults!.setObject(currentWeather["temperature"]!, forKey: "temp")
            defaults!.synchronize()
            
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.currentTemp.text = String(currentWeather["temperature"]!)
                self.windspeed.text = String(currentWeather["windSpeed"]!)
                self.visibility.text = String(currentWeather["visibility"]!)
                self.humidity.text = String(currentWeather["humidity"]!)
                self.summary.text = String(currentWeather["summary"]!)
                
                
                
            })
            
            
            
            
        }.resume()
        
        
        
        
    }

}

