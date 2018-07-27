//
//  ViewController.swift
//  jsonTest
//
//  Created by Shivam Gandhi on 2018-07-25.
//  Copyright © 2018 Shivam Gandhi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class ViewController: UIViewController {
    
    
    let BASIC_URL = "https://api.coindesk.com/v1/bpi/historical/close.json?start=2017-11-01&end=2018-02-12&currency="
    var currancy_per = ""
    
    @IBOutlet weak var currancyText: UITextField!
    
    @IBOutlet weak var maxValue: UITextField!
    @IBOutlet weak var minValue: UITextField!
    @IBOutlet weak var avgValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getData(urldata:String) {
        let url = urldata
        
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            
            response in
            if response.result.isSuccess{
                if let dataFromServer = response.data
                {
                    do {
                        let json = try JSON(data: dataFromServer)
                        
                        print(json)
                        var someDouble = [Double]()
                        let x = json["bpi"].dictionary
                        
                        
                        
                        for (key,value) in x! {
                            /** Store everydata to "someDouble" array
                             */
                           someDouble.append(value.doubleValue)
                        }

    // ---------------------------------------------------------------------------
                        // Logic to determine Max Value from array
                        var max = 0.0
                        for p in 0...someDouble.count-1
                        {
                            if someDouble[p] > max{
                            max = someDouble[p]
                            }
                        }
                        print("Max is:- ",max)
                        self.maxValue.text = String(max)
                        
    // ---------------------------------------------------------------------------
                        
                        // Logic to determine Average value from array
                        var avg = 0.0
                        var sum = 0.0
          
                        for q in 0...someDouble.count-1
                        {
                            sum = someDouble[q] + sum
                        }
                        avg = sum / Double(someDouble.count)
                        print("Avg is:- " ,avg)
                        self.avgValue.text = String(avg)
                        
    // ---------------------------------------------------------------------------
                        // Logic to determine Min value from array
                        var min = someDouble[0]
                       // var sum = 0.0
                        
                        for w in 1...someDouble.count-1
                        {
                            if someDouble[w] < min{
                                min = someDouble[w]
                            }
                        }
                        print("Min is:- " ,min)
                        self.minValue.text = String(min)
                        
                        
                        
                    }
                    catch {
                        print("error")
                    }
                    
                }
            }
            else {
                print("error while fetching data from server")
            }
        }
        
    }
    
    @IBAction func GoButtonPressed(_ sender: UIButton) {
        
        let currancy = currancyText.text!
        
        if(currancy.isEmpty){
            print("select currancy first")
    // ---------------------------------------------------------------------------
            // show Alert if input field is empty.
            let alert = UIAlertController(title: "Field is empty", message: "Put Currancy Name First", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else{
            
            let URL = BASIC_URL + currancy
            print(URL)
            getData(urldata: URL)
            
            
        }
        
        
        
        
        
        
        
    }
    
    
}

