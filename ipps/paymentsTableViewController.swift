//
//  paymentsTableViewController.swift
//  ipps
//
//  Created by Rene Zablah on 9/7/19.
//  Copyright © 2019 BASE2 LLC. All rights reserved.
//

import UIKit

class paymentsTableViewController: UITableViewController {
    
    var address = String()
    var city = String()
    var state = String()
    var zipcode = String()
    var region = String()
    var procedure = String()
    var totalDischarges = Int()
    var avgCoveredCharge = Float()
    var avgTotalPayments = Float()
    var avgMedicarePayments = Float()
    var hospitalSelection = String()
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch (section) {
        case 0:
            return "Address"
        case 1:
            return "Region"
        case 2:
            return "Procedure"
        case 3:
            return "Total Discharges"
        case 4:
            return "Average Covered Charge"
        case 5:
            return "Average Total Payments"
        case 6:
            return "Average Medicare Payments"
        default:
            return "error in label"
        }
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = hospitalSelection

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "payments", for: indexPath)

        let formatter = NumberFormatter()
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currencyAccounting
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        switch (indexPath.section) {
        case 0:
            cell.textLabel?.text = String("\(address)\n \(city), \(state), \(zipcode)")
        case 1:
            cell.textLabel?.text = String(region)
        case 2:
            cell.textLabel?.text = String(procedure)
        case 3:
            cell.textLabel?.text = String(totalDischarges)
        case 4:
            //cell.textLabel?.text = String(format: "%.2f", avgCoveredCharge)
            cell.textLabel?.text = formatter.string(from: NSNumber(value: avgCoveredCharge))
        case 5:
            //cell.textLabel?.text = String(format: "%.2f", avgTotalPayments)
            cell.textLabel?.text = formatter.string(from: NSNumber(value: avgTotalPayments))
        case 6:
            //cell.textLabel?.text = String(format: "%.2f", avgMedicarePayments)
            cell.textLabel?.text = formatter.string(from: NSNumber(value: avgMedicarePayments))
        default:
            cell.textLabel?.text = "error"
        }

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

    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
