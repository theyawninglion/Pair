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
        
        names = NameController.shared.names
        
    }
    var names: [Name] = []
    
    //MARK: - button actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        addAlert()
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        
        names.shuffle()
        tableView.reloadData()
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
            let inputName = NameController.shared.create(name: name)
            self.names.append(inputName)
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \([section + 1][0])"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return NameController.shared.sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if NameController.shared.names.count % 2 != 0  && section == NameController.shared.sections - 1 {
            return 1
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        
        let index = indexPath.row + (NameController.shared.sections * indexPath.section)
        let name = names[index]
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

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
