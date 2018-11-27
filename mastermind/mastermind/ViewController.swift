//
//  ViewController.swift
//  mastermind
//
//  Created by Thomas Millet on 27/11/2018.
//  Copyright © 2018 Thomas Millet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let number = String(Int.random(in: 1000..<10000))
    
    @IBOutlet weak var NumberField0:  UITextField!
    @IBOutlet weak var NumberField1: UITextField!
    @IBOutlet weak var NumberField2: UITextField!
    @IBOutlet weak var NumberField3: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    @IBAction func BtnClicked(_ sender: Any) {
        
        
        for i in 0..<number.count{

            let characters = Array(number)
            print(characters[i])
            print(i)
            
            if(String(characters[i]) == "\(NumberField)\(i)".text!){
                print("Rouge")
            }
        }
        
        
        
        let userCode =
                NumberField0.text! +
                NumberField1.text! +
                NumberField2.text! +
                NumberField3.text!
        
        print(number)
        print(userCode)
        
        
    }
    

}

