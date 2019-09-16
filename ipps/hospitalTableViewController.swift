//
//  hospitalTableViewController.swift
//  ipps
//
//  Created by Rene Zablah on 9/4/19.
//  Copyright © 2019 BASE2 LLC. All rights reserved.
//

import UIKit

class hospitalTableViewController: UITableViewController {
    
    var ippsArray = [IPPS]()
    var citySelection = String()
    
    var hospitalArray = [String]()
    var medparArrayByHospitalSelected = [IPPS]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = citySelection

        // Clear all objects before looking a other cities
        //self.hospitalArray.removeAll()
        
        for item in ippsArray{
            self.hospitalArray.append(item.name)
        }
        self.hospitalArray = Array(Set(self.hospitalArray))
        self.hospitalArray.sort()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.hospitalArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hospitals", for: indexPath)
        
        cell.textLabel?.text = hospitalArray[indexPath.row]
        
        return cell
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destController: procedureTableViewController = segue.destination as! procedureTableViewController
        
        // Pass the selected object to the new view controller.
        let index = tableView.indexPathForSelectedRow?.row
        
        //print(sortedKeys)
        print(hospitalArray[index!])
        
        // Remove all items in case this is not the first city we are  looking at
       // self.medparArrayByCitySelected.removeAll()
        
        for item in ippsArray{
            if (item.name == hospitalArray[index!]){
                self.medparArrayByHospitalSelected.append(item)
            }
        }
        
        destController.ippsArray = self.medparArrayByHospitalSelected
        destController.hospitalSelection = hospitalArray[index!]
    }
 

}
