//
//  TimelineTableViewController.swift
//  TheEmptyJar
//
//  Created by Jesse Anderson on 1/11/17.
//  Copyright © 2017 Jesse Anderson. All rights reserved.
//

import UIKit
import CoreData

class TimelineTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // coreDataManipulation(noteToSave: nil, command: .load)
        coreDataManipulation(noteToSave: nil, timeStamp: nil, command: .load)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
        
        self.refreshControl?.addTarget(self, action: #selector(TimelineTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Pull down to refresh method and reloadTableData after adding in a new post. 
    // Don't need both of them. Should never have to pull down to refresh. But I like having it there.
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func reloadTableData(_ notification: Notification) {
        tableView.reloadData()
    }


    // MARK: - Table view data source

    //[REVIEW] - If you don't add mutliple sections you can delete this entire function
    // Also, delete the #warning line. Just to make clear that you implemented the function properly
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weeklyNotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timelineCell", for: indexPath)

        // Configure the cell...
        
        let textlable = cell.viewWithTag(100) as! UILabel
     
        let note = weeklyNotes[indexPath.row]
        textlable.text = note.value(forKey: "name") as? String

        return cell
    }
 


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            deleteEntry(indexPath: indexPath.row)
            weeklyNotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // print("\(indexPath.row)")
            
        }   
    }
    
    // Override to support selecting an cell and move to seque

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let note = weeklyNotes[indexPath.row]
//        let noteContents = note.value(forKey: "name") as? String
//        
//        let destinationVC = NoteDetailViewController()
//        
//        destinationVC.expandedNoteContents = noteContents!
//        
//        destinationVC.performSegue(withIdentifier: "noteDetailSegue", sender: self)
        
        self.performSegue(withIdentifier: "noteDetailSegue", sender: self)
        
    }

 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //[REVIEW] - Another String!
        if segue.identifier == "noteDetailSegue" {
            
            //[REVIEW] - Force unwrapping is bad!!!
            let destinationVC = segue.destination as! NoteDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow
            
            let noteToPass = weeklyNotes[(indexPath?.row)!]
            
            let noteContents = noteToPass.value(forKey: "name") as? String
            let noteCreatedDate = noteToPass.value(forKey: "date") as? Date
            
            destinationVC.expandedNoteContents = noteContents!
            destinationVC.noteCreatedDate = noteCreatedDate!  
            
        }
        

    }



}
