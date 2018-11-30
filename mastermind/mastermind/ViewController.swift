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
    @IBOutlet weak var button: UIButton!
    
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
//        button.layer.cornerRadius = 5

    }
    
    // Check si les chiffres sont égaux
    func checkSuccess(_ charUser: String, _ charRandom: String){
        if(charUser == charRandom){
            success += 1
        }
    }
    
    // Check si le chiffre existe dans le code
    func checkMaybe(_ char: String, _ array: Array<String>){
        if(array.contains(char)){
            maybe += 1
        }
    }
    
    // Affiche les indices avec des emojis
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
    
    // Affiche les messages d'indices, de defaite et victoire
    func messages(){
        if (success == 4) {
            let alert = UIAlertController(title: "🎉 Bien joué 🎉!", message: "Vous avez trouvé le code en \(playCount) essais", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Niceu", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            resetGame()
        }
        if (playCount == 10){
            let alert = UIAlertController(title: "💣 C'est perdu boloss ! 💣", message: "Le code était \(number)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Recommencer", style: .cancel, handler: nil))
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
    
    // Transforme le code entré par l'utilisateur
    func theUserCode() -> String
    {
        let userCode = NumberField0.text! + NumberField1.text! + NumberField2.text! + NumberField3.text!
        return userCode
        
    }
    
    // Nombre d'entrée du tableau d'historique
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playCount
    }
    
    // Remplir le tableau d'historique
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        let count = self.historicCode.count - row - 1
        
        cell.textLabel?.text = self.historicCode[count]
        cell.detailTextLabel?.text = self.historicIndices[count]
        
        return cell
    }
    
    // Redémarrer le jeu
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
    
    // ????
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Limité le text field à 1 charactère
    func checkMaxLength(textField: UITextField!) {
        if (textField.text!.count > 1) {
            textField.deleteBackward()
        }
    }

    
    // Passer d'un input à l'autre automatiquement
    @IBAction func TextUpdate(_ sender: UITextField) {
        checkMaxLength(textField: sender)
        
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
        }
    }
    
    // Action sur le boutton ok
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
    @IBAction func TextFieldSelected(_ sender: UITextField) {
        NumberField0.backgroundColor = UIColor.darkGray
        NumberField1.backgroundColor = UIColor.darkGray
        NumberField2.backgroundColor = UIColor.darkGray
        NumberField3.backgroundColor = UIColor.darkGray
        sender.backgroundColor = UIColor.gray
    }
    
}
//NumberField0.backgroundColor = UIColor.gray

