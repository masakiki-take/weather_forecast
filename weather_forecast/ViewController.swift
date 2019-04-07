//
//  ViewController.swift
//  weather_forecast
//
//  Created by masaki takeoka on 2019/04/06.
//  Copyright © 2019年 masaki takeoka. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cityLabel.text = cityTextField.text
        
        cityTextField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func findWeather(_ sender: AnyObject) {
        super.viewDidLoad()
        
        var success = false
        
        let request = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!)
        
        
        let task = URLSession.shared.dataTask(with: request!, completionHandler: { (data, response, error) -> Void in
            
            
            let webContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            let websiteArray = webContent?.components(separatedBy: "<p class=\"b-forecast__table-description-content\"><span class=\"phrase\">")
            
            if websiteArray!.count > 1 {
                
                let weatherArray = websiteArray![1].components(separatedBy: "</span>")
                
                if weatherArray.count > 1 {
                    
                    let weatherSummary = weatherArray[0].replacingOccurrences(of: "&deg;", with: "°")
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        success = true
                        
                        self.resultLabel.text = weatherSummary
                    })
                }
            }
        })
        
        task.resume()
        
        if success == false{
            self.resultLabel.text = "Sorry, something went wrong."
        }
        
    }
    
    
    override func viewDidLoad() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}



