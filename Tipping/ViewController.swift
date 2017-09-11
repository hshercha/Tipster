//
//  ViewController.swift
//  Tipping
//
//  Created by hsherchan on 8/10/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    let tipPercentList = [0.18, 0.2, 0.25]
    let currencyList = ["$", "€", "£", "¥"]
    let defaults = UserDefaults.standard
    var currencyConversionRatios = [1, 0.85, 0.77, 108.97]
    var currentCurrencyExchange = 1.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bill = defaults.double(forKey: "default_bill")
        billField.text = String.init(format: "%.2f", bill)
        defaults.set(15, forKey:"default_tip")
        defaults.set(0, forKey:"default_currency_idx")
        defaults.set(1.0, forKey:"default_currency_ratio")
        defaults.synchronize()
        calculateTip()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidEnterBackground(_:)),
            name: NSNotification.Name.UIApplicationDidEnterBackground,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive(_:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func applicationDidEnterBackground(_ notification: NSNotification) {
        let curDate = Date()
        defaults.set(curDate, forKey:"last_date")
        defaults.synchronize()
    }
    
    func applicationDidBecomeActive(_ notification: NSNotification) {
        // do something
        let storedDate = defaults.object(forKey: "last_date") as! Date
        let curDate = Date()
        let timeDiff = curDate.timeIntervalSince(storedDate) / 60
        
        if (timeDiff >= 1){
            billField.text = String.init(format: "%.2f", 0.0)
            calculateTip()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaultCurrentExchange = defaults.double(forKey: "default_currency_ratio")
        let bill = defaults.double(forKey: "default_bill")
        
        if (currentCurrencyExchange != defaultCurrentExchange && bill != 0) {
            let newBill = bill * defaultCurrentExchange
            billField.text = String.init(format: "%.2f", newBill)
        }
        calculateTip()
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        randomizeBorderViewColor()
    }
    
    @IBAction func recalculateTip(_ sender: Any) {
        calculateTip()
        randomizeBorderViewColor()
        let newBill = Double(billField.text!) ?? 0
        defaults.set(newBill, forKey:"default_bill")
        defaults.synchronize()
        
    }
    func randomizeBorderViewColor() {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        UIView.animate(withDuration: 0.4, animations: {
            self.borderView.backgroundColor = UIColor(red:red, green: green, blue: blue, alpha: 1.0)
        }, completion:nil)
        
    }
    
    func calculateTip() {
        var tipPercentage = 1.0
        if (tipControl.selectedSegmentIndex == 3) {
            let currentDefaultTip = defaults.integer(forKey: "default_tip")
            tipPercentage = Double(currentDefaultTip)/100
            
        } else {
            tipPercentage = tipPercentList[tipControl.selectedSegmentIndex]
        }
        currentCurrencyExchange = defaults.double(forKey: "default_currency_ratio")
        let bill = Double(billField.text!) ?? 0
        
        
        let currencyIdx = defaults.integer(forKey: "default_currency_idx")
        let currencySign = currencyList[currencyIdx]
        let currencyFormat = currencySign + "%.2f"
        
        let tip = bill * tipPercentage
        let total = bill + tip
        tipLabel.text = String.init(format: currencyFormat, tip)
        totalLabel.text = String.init(format: currencyFormat, total)
    }
}

