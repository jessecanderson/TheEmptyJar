//
//  FirstViewController.swift
//  TheEmptyJar
//
//  Created by Jesse Anderson on 1/11/17.
//  Copyright © 2017 Jesse Anderson. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var notesText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.bringSubview(toFront: notesText)
        self.notesText.delegate = self
        notesText.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveNote(_ sender: Any) {
        
        let timeStamp = Date()
        
        if let notesText = notesText.text, !notesText.isEmpty {
            // We will replace the array with a core data function to save the timestamp and text data into some file later. This is just to get us up and working for now.
            
            //save(noteToSave: notesText.text)
            // coreDataManipulation(noteToSave: notesText, command: .save)
            coreDataManipulation(noteToSave: notesText, timeStamp: timeStamp, command: .save)
            // weeklyNotes[timestamp] = notesText.text
            print(timeStamp)
            
            // Validate the dictionary has data in it every time an entry is made.
            // print("\(weeklyNotes)")
        } else {
            //[REVIEW] - Something like this is a good opportunity for an extension on UIViewController
            let message = "You didn't write a note, please go back and include a note for this week!"
            let title = "Empty Note"
            showAlert(withTitle: title, message: message)
            
//            let alert = UIAlertController(title: "Empty Note", message: message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }
        
        notesText.text = ""
        

    }
    
    
}
    
//Just another example. You could for example add another argument for the button title.
extension UIViewController {
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
 
 

