//
//  ViewController.swift
//  mastermind
//
//  Created by Thomas Millet on 27/11/2018.
//  Copyright © 2018 Thomas Millet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var NumberField0: UITextField!
    @IBOutlet weak var NumberField1: UITextField!
    @IBOutlet weak var NumberField2: UITextField!
    @IBOutlet weak var NumberField3: UITextField!
    @IBOutlet weak var message: UILabel!
    
    let number = String(Int.random(in: 1000..<10000))
    var success = 0
    var maybe = 0
    var playCount = 0
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func checkSuccess(_ charUser: String, _ charRandom: String){
        if(charUser == charRandom){
            success += 1
        }
    }
    func checkMaybe(_ char: String, _ array: Array<String>){
        if(array.contains(char)){
            maybe += 1
        }
    }
    
    func message(u: String){
        if (success == 4) {
//            print("Vous avez gagné !")
//            print(number)
            message.text = "Vous avez gagné !"
        }
        if (playCount == 10){
            message.text = """
            C'est perdu boloss !
            \(number)
            """
        }
        else {
            print("Random: \(number)")
//            print("Votre code: \(u)")
//            print("Vous avez \(success) chiffre bien placé")
//            print("Vous avez \(maybe - success) chiffre mal placé")
            message.text = """
            Vous avez \(success) chiffre bien placé
            Vous avez \(maybe - success) chiffre mal placé
            """
        }
        
    }

    @IBAction func BtnClicked(_ sender: Any) {
        let userCode = NumberField0.text! + NumberField1.text! + NumberField2.text! + NumberField3.text!
        var inputs = [NumberField0.text, NumberField1.text, NumberField2.text, NumberField3.text]
    
        success = 0
        maybe = 0
        playCount += 1
        
        
       // Check numbers
       for i in 0..<number.count{

        let characters = Array(number)
        let char = String(characters[i])
        
        checkSuccess(inputs[i]! , char)
        checkMaybe(char, inputs as! Array<String>)
        
        }
        message(u: userCode)

    }
    

}

