//
//  ViewController.swift
//  kotlikeh
//
//  Created by Grzegorz Kulesza on 16/06/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<5 {
            DataTextFields[i].addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),  for: .editingChanged) //for change every times contains of text field changes
            DataTextFields[i].delegate = self //for only digits can be tapped in field
        }
        
        
    }
    
    
    @IBOutlet var DataTextFields: [UITextField]!
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard returnEmptyField() != 5 else {
            return
        }
        if checkForZeroesFields() == false {
            //DataTextFields[returnEmptyField()].text = String(returnEmptyField()) //show value of the empty textfield
            /*
            let p = Int(DataTextFields[4].text!)
            let m = Int(DataTextFields[1].text!)
            let t = Int(DataTextFields[0].text!)
            let t1 = Int(DataTextFields[2].text!)
            let t2 = Int(DataTextFields[3].text!)
            */
            switch returnEmptyField() {
            case 0:
                DataTextFields[returnEmptyField()].text = countTime(p: Int(DataTextFields[4].text!)!, m: Int(DataTextFields[1].text!)!, t1: Int(DataTextFields[2].text!)!, t2: Int(DataTextFields[3].text!)!)
            case 1:
                DataTextFields[returnEmptyField()].text = countWeight(p: Int(DataTextFields[4].text!)!, t: Int(DataTextFields[0].text!)!, t1: Int(DataTextFields[2].text!)!, t2: Int(DataTextFields[3].text!)!)
            case 2:
                DataTextFields[returnEmptyField()].text = countStartTemperature(p: Int(DataTextFields[4].text!)!, m: Int(DataTextFields[1].text!)!, t: Int(DataTextFields[0].text!)!, t2: Int(DataTextFields[3].text!)!)
            case 3:
                DataTextFields[returnEmptyField()].text = countEndTemperature(p: Int(DataTextFields[4].text!)!, m: Int(DataTextFields[1].text!)!, t: Int(DataTextFields[0].text!)!, t1: Int(DataTextFields[2].text!)!)
            case 4:
                DataTextFields[returnEmptyField()].text = countPower(t: Int(DataTextFields[0].text!)!, m: Int(DataTextFields[1].text!)!, t1: Int(DataTextFields[2].text!)!, t2: Int(DataTextFields[3].text!)!)
            
            default:
                DataTextFields[returnEmptyField()].text = "Some choose error"
            }
            
            
        }
    }
    
    //MARK: - validation data functions
    
    func returnEmptyField() -> Int {
        //        var timeTextField = DataTextFields[0]
        //        var weightTextField = DataTextFields[1]
        //        var temperatureStartTextField = DataTextFields[2]
        //        var temperatureEndTextField = DataTextFields[3]
        //        var powerTextField = DataTextFields[4]
        var counter: Int = 0
        var output: Int = 5 //5 is out of range
        
        for i in 0..<5 {
            if DataTextFields[i].text == "" {
                counter += 1
                output = i
            }
        }
        
        if counter == 1 {
            return output
        } else {
            return 5
        }
        
    }
    
    func checkForZeroesFields() -> Bool {
        for i in 0..<5 {
            if DataTextFields[i].text != "" {
                let cellValue = Int(DataTextFields[i].text!)
                if cellValue == 0 {
                    return true
                }
            }
        }
        return false
        
    }
    
    
    
    //MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == DataTextFields[0] || textField == DataTextFields[1] || textField == DataTextFields[2] || textField == DataTextFields[3] || textField == DataTextFields[4]
        {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    
    //MARK: - Calculation formulas
    
    func countTime(p: Int, m: Int, t1: Int, t2: Int) -> String {
        let c = Float(4190) // J/kg/degC
        let p = Float(p)
        let m = Float(m)
        let t1 = Float(t1)
        let t2 = Float(t2)
        
        let time = m * c * (t2 - t1)/p
        return  String(Int(time))
    }
    
    
    func countPower(t: Int, m: Int, t1: Int, t2: Int) -> String {
        let c = Float(4190) // J/kg/degC
        let t = Float(t)
        let m = Float(m)
        let t1 = Float(t1)
        let t2 = Float(t2)
        
        let power = m * c * (t2 - t1)/t
        return  String(Int(power))
    }
    
    
    func countWeight(p: Int, t: Int, t1: Int, t2: Int) -> String {
        let c = Float(4190) // J/kg/degC
        let p = Float(p)
        let t = Float(t)
        let t1 = Float(t1)
        let t2 = Float(t2)
        
        let weight = p * t / c / (t2 - t1)
        return  String(Int(weight))
    }
    
    func countStartTemperature(p: Int, m: Int, t: Int, t2: Int) -> String {
        let c = Float(4190) // J/kg/degC
        let p = Float(p)
        let m = Float(m)
        let t = Float(t)
        let t2 = Float(t2)
        
        let startTemperature = t2 - p * t / (m * c)
        return  String(Int(startTemperature))
    }
    
    
    func countEndTemperature(p: Int, m: Int, t: Int, t1: Int) -> String {
        let c = Float(4190) // J/kg/degC
        let p = Float(p)
        let m = Float(m)
        let t = Float(t)
        let t1 = Float(t1)
        
        let endTemperature = t1 + p * t / (m * c)
        return  String(Int(endTemperature))
    }
    
    
}

