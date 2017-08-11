//
//  SettingsViewController.swift
//  Tipping
//
//  Created by hsherchan on 8/10/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipField: UITextField!
    @IBOutlet weak var currencyControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    
    var currencyConversionRatios = [1, 0.85, 0.77, 108.97]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tip = defaults.integer(forKey:"default_tip")
        defaultTipField.text = "\(tip)"
        let idx = defaults.integer(forKey:"default_currency_idx")
        currencyControl.selectedSegmentIndex = idx
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func updateDefaultTip(_ sender: Any) {
        let currentDefaultTip = defaults.integer(forKey: "default_tip")
        let newDefaultTip = Int(defaultTipField.text!) ?? currentDefaultTip
        
        defaults.set(newDefaultTip, forKey: "default_tip")
        defaults.synchronize()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func updateSettings(_ sender: Any) {
        
        let oldCurrencyIdx = defaults.integer(forKey: "default_currency_idx")
        let newCurrencyIdx = currencyControl.selectedSegmentIndex
        let newCurrencyRatio = currencyConversionRatios[newCurrencyIdx]/currencyConversionRatios[oldCurrencyIdx]
        
        defaults.set(newCurrencyIdx, forKey: "default_currency_idx")
        defaults.set(newCurrencyRatio, forKey: "default_currency_ratio")
        defaults.synchronize()
        
    }

}
