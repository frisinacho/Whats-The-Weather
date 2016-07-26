//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Ignacio Lasaosa Sáez on 26/7/16.
//  Copyright © 2016 Ignacio Lasaosa Sáez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityFextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityFextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")!
        
        if let url: NSURL = attemptedUrl {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
                if let urlContent = data {
                
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                    let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                    if websiteArray.count > 1 {
                    
                        let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    
                        if weatherArray.count > 1 {
                            
                            wasSuccessful = true
                        
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                                self.resultLabel.text = weatherSummary
                            })
                        
                        }
                    }
                    
                    if wasSuccessful == false {
                        self.resultLabel.text = "Couldn't find the weather for that city - please try again."
                    }
                }
            }
        
            task.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

