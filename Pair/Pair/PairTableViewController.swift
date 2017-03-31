//
//  PairTableViewController.swift
//  Pair
//
//  Created by Taylor Phillips on 3/31/17.
//  Copyright © 2017 Taylor Phillips. All rights reserved.
//

import UIKit
import GameKit
class PairTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    var names: Array<Any> = []
    
    //MARK: - button actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        addAlert()
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        let shuffledArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: names)
        names.append(contentsOf: shuffledArray)
    }
    
    func addAlert() {
        let alertController = UIAlertController(title: "Add Name", message: "Add something new to the list", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        var nameTextField: UITextField?
        alertController.addTextField { (textField) in
            nameTextField = textField
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            guard let name = nameTextField?.text else { return }
            NameController.shared.create(name: name)
            self.names.append(name)
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        let sections = NameController.shared.names.count
//        if sections > 1 {
//            return 1
//        } else {
//            return sections
//        }
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NameController.shared.names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        let name = NameController.shared.names[indexPath.row]
        cell.textLabel?.text = name.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let name = NameController.shared.names[indexPath.row]
            NameController.shared.delete(name: name)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
