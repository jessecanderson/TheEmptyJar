//
//  NoteDetailViewController.swift
//  TheEmptyJar
//
//  Created by Jesse Anderson on 1/18/17.
//  Copyright © 2017 Jesse Anderson. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var noteContents: UILabel!
    @IBOutlet weak var noteCreatedDateLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    var expandedNoteContents = String()
    var noteCreatedDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = false
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        noteCreatedDateLabel.text = dateFormatter.string(from: noteCreatedDate)
        
        noteContents.text = expandedNoteContents
    
        
        // print("\(expandedNoteContents)")
    }

    //[REVIEW] - If you don't implement a function delete it
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //[REVIEW] - Same as above
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
