//
//  AddViewController.swift
//  iLoL
//
//  Created by Alex Wong on 8/13/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

// MARK: - AddViewController

class AddViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isImp: UISwitch!
    
    // MARK: - IBActions
    
    @IBAction func addStory(_ sender: Any) {
        print("Story added")
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        task.name = textField.text!
        task.isImportant = isImp.isOn
        
        // Save the data to Core Data
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
 
    }
    
}

// MARK: - UITextFieldDelegate

extension AddViewController: UITextFieldDelegate{

    // MARK: - Dismiss keyboard when touch outside
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    // MARK: - Dismiss keyboard when return button pressed
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addStory(self)
        return true
    }
}
