//
//  ViewController.swift
//  MultithreadingReference
//
//  Created by mac on 4/22/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ThreadViewController: UIViewController {
    
    //MARK: similar to Outlets
    var tableView: UITableView!
    
    //MARK: Test Arrays
    let arrayOne = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let arrayTwo = [21, 22, 23, 24, 25, 26, 27, 28, 29]
    
    let charArray = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
    
    let identifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       multithreadingTable()
        
    }
    
    
    func multithreadingTable() {
        
        title = "Multithreading Reference"
        
        //what frame should TableView be at
        tableView = UITableView(frame: view.frame)
        tableView.backgroundColor = .white
        
        //you have to add the object as a subview to the View
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }


} //end class

extension ThreadViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var deqeueCell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        //check if the cell is nil or not
        if deqeueCell == nil {
            
            deqeueCell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
            
        }
        
        //create a variable with our dequeued cell
        let cell = deqeueCell!
        
        
        cell.textLabel?.numberOfLines = 0 //as much as it needs
        cell.detailTextLabel?.numberOfLines = 0
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Dispatch.main.sync"
            cell.detailTextLabel?.text = "Performs tasks sequentially on main thread"
        case 1:
            cell.textLabel?.text = "Dispatch.global.async"
            cell.detailTextLabel?.text = "Performs tasks concurrently on global thread"
        case 2:
            cell.textLabel?.text = "Operation Blocks"
            cell.detailTextLabel?.text = "Execute several blocks concurrently"
        case 3:
            cell.textLabel?.text = "Dispatch Groups"
            cell.detailTextLabel?.text = "Perform groups of task synchronously and be notified upon completion"
        case 4:
            cell.textLabel?.text = "Dispatch Barrier"
            cell.detailTextLabel?.text = "Create a synchronization point within a concurrent queue"
        case 5:
            cell.textLabel?.text = "Dispatch Semaphore"
            cell.detailTextLabel?.text = "Can be used to control access to a resource across multiple threads"
        default:
            break
        }
        
        return cell
    }
} //end ext


extension ThreadViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            doSyncTask()
        case 1:
            doAsyncTask()
        case 2:
            doBlockOperation()
        case 3:
            doDispatchGroup()
        case 4:
            doDispatchBarrier()
        case 5:
            doDispatchSemeaphore()
        default:
            break
        }
    }
    
}//end ext
