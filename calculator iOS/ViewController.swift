//
//  ViewController.swift
//  calculator iOS
//
//  Created by Volodymyr Lavryk on 06.12.16.
//  Copyright © 2016 Volodymyr Lavryk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
   
    var nowTyping = false
    let decimalSeparator = "."
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if nowTyping {
            let displayText = display.text!
            if (digit != decimalSeparator) || (displayText.range(of: decimalSeparator) == nil){
            display.text = displayText + digit
            }
        } else {
            display.text = digit
            nowTyping = true
        }
        
        
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    var calc = Calculator()

    @IBAction func touchOperation(_ sender: UIButton) {
        if nowTyping {
            calc.setOperand(operand: displayValue)
            nowTyping = false
        }
        if let symbol = sender.currentTitle {
            calc.performOperationWith(symbol: symbol)
        }
        displayValue = calc.result
    }
    

}

