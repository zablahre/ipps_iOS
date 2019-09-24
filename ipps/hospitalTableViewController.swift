//
//  hospitalTableViewController.swift
//  ipps
//
//  Created by Rene Zablah on 9/4/19.
//  Copyright © 2019 BASE2 LLC. All rights reserved.
//

import UIKit

class hospitalTableViewController: UITableViewController {
    
    var urlStr = String()
    var citySelection = String()
    var hospitalArray = [String]()
    var medparArrayByHospitalSelected = [IPPS]()
    let indicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = citySelection
        indicator.color = UIColor.black
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        self.view.addSubview(indicator)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let url = URL(string: urlStr)!
        
        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    print("error is null")
                }
                
                guard let mime = response?.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }
                
                guard let data = data else {return}
                
                do {
                    let medpar = try
                        JSONDecoder().decode([IPPS].self, from: data)
                    
                    for item in medpar{
                        self.hospitalArray.append(item.name)
                        self.medparArrayByHospitalSelected.append(item)
                    }
                    self.hospitalArray = Array(Set(self.hospitalArray))
                    self.hospitalArray.sort()
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.indicator.stopAnimating()
                    self.indicator.removeFromSuperview()
                }
            }.resume()
        }
    }

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
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destController: procedureTableViewController = segue.destination as! procedureTableViewController
        
        // Pass the selected object to the new view controller.
        let index = tableView.indexPathForSelectedRow?.row
        destController.ippsArray = self.medparArrayByHospitalSelected
        destController.hospitalSelection = hospitalArray[index!]
    }
 

}
