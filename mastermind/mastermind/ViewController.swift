//
//  ViewController.swift
//  mastermind
//
//  Created by Thomas Millet on 27/11/2018.
//  Copyright © 2018 Thomas Millet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    
    @IBOutlet weak var NumberField0: UITextField!
    @IBOutlet weak var NumberField1: UITextField!
    @IBOutlet weak var NumberField2: UITextField!
    @IBOutlet weak var NumberField3: UITextField!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var table: UITableView!
    var number = String(Int.random(in: 1000..<10000))
    var success = 0
    var maybe = 0
    var playCount = 0
    var historicCode = [String]()
    var historicIndices = [String]()
    

    
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(number)

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
    
    func displayEmoji(_ success:Int, _ maybe:Int) -> String
    {
        var str = ""
        for _ in 0..<success{
            str += "😁"
        }
        for _ in 0..<(maybe - success){
            str += "🤔"
        }
        
        return str
    }
    
    func messages(){
        if (success == 4) {
            let alert = UIAlertController(title: "Well done!", message: "You found the code in \(playCount) try", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Niceu", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            resetGame()
        }
        if (playCount == 10){
            let alert = UIAlertController(title: "C'est perdu boloss !", message: "The code was \(number)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "You suck", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            resetGame()
        }
        else {
            print("Random: \(number)")
            message.text = """
            Vous avez \(success) chiffre bien placé
            Vous avez \(maybe - success) chiffre mal placé
            """
        }
        
    }

    @IBAction func BtnClicked(_ sender: Any) {

        var inputs = [NumberField0.text, NumberField1.text, NumberField2.text, NumberField3.text]
        historicCode.append(theUserCode())
    
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
        historicIndices.append(displayEmoji(success, maybe))
        messages()
        table.reloadData()

    }
    
    func theUserCode() -> String
    {
        let userCode = NumberField0.text! + NumberField1.text! + NumberField2.text! + NumberField3.text!
        return userCode
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playCount
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        let count = self.historicCode.count - row - 1
        
        cell.textLabel?.text = self.historicCode[count]
        cell.detailTextLabel?.text = self.historicIndices[count]
        
        return cell
    }
    
    func resetGame(){
        playCount = 0
        number = String(Int.random(in: 1000..<10000))
        historicCode.removeAll()
        historicIndices.removeAll()
        NumberField0.text = ""
        NumberField1.text = ""
        NumberField2.text = ""
        NumberField3.text = ""
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
        }
    }
    
    
    @IBAction func TextUpdate(_ sender: UITextField) {
        checkMaxLength(textField: sender, maxLength: 1)
        
        let text = sender.text
        
        if (text?.utf16.count)! >= 1{
            switch sender{
            case NumberField0:
                NumberField1.becomeFirstResponder()
            case NumberField1:
                NumberField2.becomeFirstResponder()
            case NumberField2:
                NumberField3.becomeFirstResponder()
            case NumberField3:
                NumberField3.resignFirstResponder()
            default:
                break
            }
        }else{
            
        }
    }
}

