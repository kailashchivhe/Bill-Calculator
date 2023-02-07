//
//  ViewController.swift
//  Bill Calculator
//
//  Created by Kailash Chivhe on 30/01/23.
//

import UIKit

class ViewController: UIViewController {
    var billValue: Double = 0.0
    @IBOutlet weak var textFieldBill: UITextField!
    @IBOutlet weak var percentageSegmentControl: UISegmentedControl!
    @IBOutlet weak var tipValue: UILabel!
    @IBOutlet weak var totalBill: UILabel!
    @IBOutlet weak var customTipValue: UILabel!
    @IBOutlet weak var customProgressBar: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customProgressBar.isEnabled = false
        textFieldBill.delegate = self
    }
    
    @IBAction func clear(_ sender: UIButton) {
        resetCustomProgress()
        textFieldBill.text = "0.0"
        percentageSegmentControl.selectedSegmentIndex = 0
        tipValue.text = "$0.0"
        totalBill.text = "$0.0"
    }
    
    func resetCustomProgress(){
        customTipValue.text = "25%"
        customProgressBar.value = 25
        customProgressBar.isEnabled = false
    }
    
    
    func calculateBill(){
        var tip = 0.0
        switch percentageSegmentControl.selectedSegmentIndex{
        case 0:
            tip = (Double(billValue) * 0.10)
        case 1:
            tip = (Double(billValue) * 0.15)
        case 2:
            tip = (Double(billValue) * 0.18)
        case 3:
            tip = Double(billValue) * Double(customProgressBar.value/100)
        default:
            tip = 0.0
        }
        tipValue.text = "$\(Double(tip).rounded(toPlaces: 2))"
        totalBill.text = "$\(Double(billValue+tip).rounded(toPlaces: 2))"
    }
    
    @IBAction func customProgressBarChanged(_ sender: UISlider) {
        customTipValue.text = "\( sender.value.rounded()) %"
        calculateBill()
    }
    
    @IBAction func segmentedControlValueChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 3 {
            customProgressBar.isEnabled = true
        }
        else{
            resetCustomProgress()
        }
        calculateBill()
    }
}

extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.hasText {
            let data = Double(textField.text!)
            billValue = data!
            calculateBill()
        }
        return true;
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

