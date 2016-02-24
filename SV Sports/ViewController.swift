//
//  ViewController.swift
//  Eventos
//
//  Created by Pedro Gomes Branco on 2/22/16.
//  Copyright © 2016 Pedro Gomes Branco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var erro: UILabel!
    var teste = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usuario.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        senha.text = ""
    }
    
    @IBAction func Login(sender: AnyObject) {
        
        let rootPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let url = NSURL(string: rootPath)
        let path = (url?.URLByAppendingPathComponent("users.plist").absoluteString)!
        var data : NSMutableArray! = NSMutableArray(contentsOfFile: path)
        
        if (data == nil) {
            data = NSMutableArray()
            data.writeToFile(path, atomically: false)
        }
        
        func verifica(email: String, senha: String)-> Int{
            
            if (usuario.text == email && self.senha.text == senha){
                return 1
            }
            else {
                return 0
            }
        }
        
        func ver1(){
            for i in data.enumerate(){
                let user = data.objectAtIndex(i.index) as! NSMutableDictionary
                let username = user.valueForKey("email") as! String
                let password = user.valueForKey("senha") as! String
                if (verifica(username, senha: password) == 1) {
                    teste = 1
                    break
                }
            }
        }
        
        if((usuario.text != "") && (senha.text != "")){
            ver1()
            if(teste == 1){
                self.performSegueWithIdentifier("login", sender: nil)
                print("GOOD")
            }
            else if(teste == 0){
                erro.text = "Usuário ou senha inválidos"
                teste = -1
            }
        }
        else{
            erro.text = "Preencha os campos abaixo"
            teste = -1
        }
      
    }
}
