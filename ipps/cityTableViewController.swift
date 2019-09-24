//
//  cityTableViewController.swift
//  ipps
//
//  Created by Rene Zablah on 8/1/19.
//  Copyright © 2019 BASE2 LLC. All rights reserved.
//

import UIKit

struct Location: Decodable {
    let city: String
    let state: String
}

class cityTableViewController: UITableViewController {
    
    var urlStr = String()
    var modURLStr = String()
    var stateSelection = String()
    var medparArrayByCitySelected = [IPPS]()
    var citiesArray = [String]()
    let indicator = UIActivityIndicatorView(style: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = stateSelection
        
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
                        JSONDecoder().decode([Location].self, from: data)

                    for item in medpar{
                        self.citiesArray.append(item.city)
                    }
                    self.citiesArray = Array(Set(self.citiesArray))
                    self.citiesArray.sort()
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
        return self.citiesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cities", for: indexPath)
        
        cell.textLabel?.text = citiesArray[indexPath.row]
        
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
        let destController: hospitalTableViewController = segue.destination as! hospitalTableViewController
        
        // Pass the selected object to the new view controller.
        let index = tableView.indexPathForSelectedRow?.row
        
        // Remove all items in case this is not the first city we are  looking at
        self.medparArrayByCitySelected.removeAll()
        
        destController.citySelection = citiesArray[index!]
        modURLStr = "https://www.base2.tech/ipps/\(stateSelection)/\(citiesArray[index!])"
        destController.urlStr = modURLStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
