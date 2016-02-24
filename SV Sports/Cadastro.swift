//
//  cadastro.swift
//  Eventos
//
//  Created by Pedro Gomes Branco on 2/22/16.
//  Copyright © 2016 Pedro Gomes Branco. All rights reserved.
//

import UIKit

class Cadastro: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.email.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var teste2 = 0
    @IBOutlet weak var ola: UILabel!
    @IBOutlet weak var confirmaSenha:UITextField!
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBAction func Salvar(sender: AnyObject) {
        
        let rootPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let url = NSURL(string: rootPath)
        let path = (url?.URLByAppendingPathComponent("users.plist").absoluteString)!
        let fileManager = NSFileManager.defaultManager()
        if (!(fileManager.fileExistsAtPath(path)))
        {
            let bundle : NSString! = NSBundle.mainBundle().pathForResource("users", ofType:"plist")
            do {
                try fileManager.copyItemAtPath(bundle as String, toPath: path)
            }
            catch{
                print("Error!!")
            }
        }
        
        var data : NSMutableArray! = NSMutableArray(contentsOfFile: path)
        if (data == nil) {
            data = NSMutableArray()
            data.writeToFile(path, atomically: false)
        }
        
        
        let user = NSMutableDictionary()
        
        func verifica2(username: String)->Int{
            if(self.email.text == username){
                return 1
            }
            else{
                return 0
            }
        }
        
        func ver(){
            for i in data.enumerate() {
                let user = data.objectAtIndex(i.index) as! NSMutableDictionary
                let username = user.valueForKey("email") as! String
                if (verifica2(username) == 1) {
                    teste2 = 1
                }
            }
        }
        
        if((nome.text != "") && (email.text != "") && (senha.text != "") && (confirmaSenha.text != "") && (teste2 == 0)){
            user.setValue(nome.text, forKeyPath: "nome")
            user.setValue(email.text, forKeyPath: "email")
            ver()
            if(teste2 == 0){
                if(senha.text == confirmaSenha.text){
                user.setValue(senha.text, forKeyPath: "senha")
                performSegueWithIdentifier("login", sender: nil)
                print("GOOD 2")
                user.writeToFile(path, atomically: false)
                data.writeToFile(path, atomically: false)
                data.addObject(user)
                }
            }
            
            else if(teste2 == 1){
                ola.text = "E-mail já cadastrado"
                teste2 = 0
            }
            else{
                ola.text = "Preencha os campos abaixo corretamente"
                teste2 = 0
            }
        }
        
        print(path)
        print(data)
        
    }
    
    @IBAction func Limpar(sender: AnyObject) {
        nome.text = ""
        email.text = ""
        senha.text = ""
        confirmaSenha.text = ""
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        senha.text = ""
        confirmaSenha.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

