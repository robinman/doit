//
//  TasksViewController.swift
//  Doit
//
//  Created by Robin Tan on 10/4/17.
//  Copyright © 2017 Robin Tan. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print("view did load...")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        getTasks()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tasks[indexPath.row].important {
            cell.textLabel?.text = "🎯 " + tasks[indexPath.row].name!
        } else {
            cell.textLabel?.text = tasks[indexPath.row].name!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        performSegue(withIdentifier: "selectTaskSegue", sender: task)
    }

    

    
    
    @IBAction func plusTapped(_ sender: Any) {
        performSegue(withIdentifier: "plusSegue", sender: nil)
    }
    
    func getTasks() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            tasks = try context.fetch(Task.fetchRequest()) as! [Task]
            print("fetchRequest for task: \(tasks)")
        } catch {
            print("something went wrong fetchRequest for task...")
        }
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        if segue.identifier == "selectTaskSegue" {
            let nextVC = segue.destination as! CompleteTaskViewController
            nextVC.task = sender as? Task
        }

    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    

}

