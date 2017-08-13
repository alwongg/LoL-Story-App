//
//  ToReadViewController.swift
//  iLoL
//
//  Created by Alex Wong on 8/13/17.
//  Copyright © 2017 Alex Wong. All rights reserved.
//

import UIKit

class ToReadViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var tasks: [Task] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // get the data from CoreData
        
        getData()
        
        // Reload the table view
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    
    // MARK: - IBActions
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try tasks = context.fetch(Task.fetchRequest())
        } catch  {
            print("Fetching failed")
        }
        
    }
    
}

// MARK: - TableView: DataSource and Delegate

extension ToReadViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        if task.isImportant{
            
            cell.textLabel?.text = "😱\(task.name!)"
            
        } else {
            
            cell.textLabel?.text = "\(task.name!)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete{
            
            let task = tasks[indexPath.row]
            
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                try tasks = context.fetch(Task.fetchRequest())
            } catch  {
                print("Fetching failed")
            }
        }
        tableView.reloadData()
    }
    
}
