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
            DataTextFields[returnEmptyField()].text = String(returnEmptyField()) //show value of the empty textfield
        }
    }
    

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
    
    
    
}

