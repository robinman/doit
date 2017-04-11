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
    var selectedTaskIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tasks = makeTasks()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print("view did load...")
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tasks[indexPath.row].important {
            cell.textLabel?.text = "🎯 " + tasks[indexPath.row].name
        } else {
            cell.textLabel?.text = tasks[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        selectedTaskIndex = indexPath.row
        performSegue(withIdentifier: "selectTaskSegue", sender: task)
    }

    
    func makeTasks() -> [Task] {
        
        let task1 = Task()
        task1.name = "Run at least once a week"
        task1.important = true
        
        let task2 = Task()
        task2.name = "Sneaker shopping"
        task2.important = false

        let task3 = Task()
        task3.name = "Finish building the quadcopter"
        task3.important = false
        
        return [task1, task2, task3]
        
    }
    
    
    @IBAction func plusTapped(_ sender: Any) {
        performSegue(withIdentifier: "plusSegue", sender: nil)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "plusSegue" {
            let nextVC = segue.destination as! CreateTaskViewController
            nextVC.previousVC = self
        }
        
        if segue.identifier == "selectTaskSegue" {
            let nextVC = segue.destination as! CompleteTaskViewController
            nextVC.task = sender as! Task
            nextVC.previousVC = self
        }

    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    

}

