//
//  ViewController.swift
//  Tipping
//
//  Created by hsherchan on 8/10/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
        defaults.set(15, forKey:"default_tip")
        defaults.set(0, forKey:"default_currency_idx")
        defaults.set(1.0, forKey:"default_currency_ratio")
        defaults.synchronize()
        calculateTip()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaultCurrentExchange = defaults.double(forKey: "default_currency_ratio")
        
        let bill = Double(billField.text!) ?? 0
        
        if (currentCurrencyExchange != defaultCurrentExchange && bill != 0) {
            let newBill = bill * defaultCurrentExchange
            billField.text = String.init(format: "%.2f", newBill)
        }
        calculateTip()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func recalculateTip(_ sender: Any) {
        calculateTip()
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

