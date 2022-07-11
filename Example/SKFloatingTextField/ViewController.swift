//
//  ViewController.swift
//  SKFloatingTextField
//
//  Created by coderode on 04/05/2021.
//  Copyright (c) 2021 coderode. All rights reserved.
//

import UIKit
import SKFloatingTextField
class ViewController: UIViewController {
    @IBOutlet weak var floatingTextField: SKFloatingTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setTextFieldUI()
    }
    func setTextFieldUI(){
        floatingTextField.placeholder = "Username"
        floatingTextField.activeBorderColor = .blue
        floatingTextField.borderColor = .black
        floatingTextField.borderWidth = 1
        floatingTextField.floatingLabelText = "Username"
        floatingTextField.floatingLabelColor = .black
        floatingTextField.bgColor = .lightGray
        //floatingTextField.setRectTFUI()
        //floatingTextField.setRoundTFUI()
        //floatingTextField.setOnlyBottomBorderTFUI()
        floatingTextField.setCircularTFUI()
        floatingTextField.delegate = self
        
        self.view.backgroundColor = .lightGray
        //floatingTextField.errorLabelText = "Error"
    }

}
extension ViewController : SKFlaotingTextFieldDelegate {
    
    func textFieldDidEndEditing(textField: SKFloatingTextField) {
        print("end editing")
    }
    
    func textFieldDidChangeSelection(textField: SKFloatingTextField) {
        print("changing text")
    }
    
    func textFieldDidBeginEditing(textField: SKFloatingTextField) {
        print("begin editing")
    }
}

