//
//  ThreadVC+Extension.swift
//  MultithreadingReference
//
//  Created by mac on 4/22/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


extension ThreadViewController {
    
    //NOTE: Two ways to perform Multithreading in IOS: GCD (grand central dispatch) and Operations. Advantages of using Operations: you can check the status of execution, pause, resume, or stop download, in the middle of execution.
    
    
    //MARK: Synchronous Task
    
    func doSyncTask() {
        
        //Sync trask willl perform sequentially in the order in which they are queued
        
        DispatchQueue.global().async { [unowned self] in
            
            
            for number in self.arrayOne {
                
                DispatchQueue.main.sync {
                    print(number)
                }
                
            } //end loop
            
            
            
            for number2 in self.arrayTwo {
                
                DispatchQueue.main.sync {
                    print(number2)
                }
                
                
            } //end loop
        }
        
    } //end func
    
    
    //MARK: Async Tasks
    
    func doAsyncTask() {
        
        //Asychronous task will be executed in any order, regardless of when work items are queued
        
        for one in arrayOne {
            
            DispatchQueue.global().async {
                
                print(one)
                
            }
        }
        
        
        for two in arrayTwo {
            DispatchQueue.global().async {
                
                print(two)
                
            }
        }
        
        DispatchQueue.main.async {
            print("Done Asynchronous Task")
        }
        
    } //end func
    
    
    
    //MARK: Block Operation - Operations
    
    func doBlockOperation() {
        
        //Use block operations to execute several lines of code at once without having to create seprate operation objects for each. The order is NOT guaranteed
        
        var blockOperation = [BlockOperation]()
        
        for one in arrayOne {
            
            let operation = BlockOperation(block: {print(one) })
            
            blockOperation.append(operation)
        }
        
        
        //you MUST add the block operation to an operation Queue in orer to be fired (or executed)
        let operationQueue = OperationQueue()
        
        
        //add our block operation to the queue
        blockOperation.forEach { block in
            operationQueue.addOperation(block)
        }
        
    } //end func
    
    
    //MARK: Dispatch Groups
    
    //Uses groups to synchronize pieces of work, Entering and leaving the group is a 1-to-1 relationship
    func doDispatchGroup() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        for one in arrayOne {
            
            print(one)
        }
        
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        for two in arrayTwo {
            
            print(two)
        }
        
        dispatchGroup.leave()
        
        //DG.Notify, will tell us after all groups have finished, used as a completion alert
        dispatchGroup.notify(queue: .global()) {
            print("Finished with Group Tasks!")
        }
        
    } //end func
    
    
    //MARK: Dispatch Barrier
    
    func doDispatchBarrier() {
        
        //All items submitted to the queue prior to the barrier must be completed before the barrier will execute, used to solve Read/Write problems.
        
        //create concurrent queue
        let concurrentQueue = DispatchQueue(label: "concurrent queue", attributes: .concurrent)
        let half = charArray.count / 2
        
        for i in 0..<half {
            
            concurrentQueue.async { [unowned self] in
                
                 print(self.charArray[i])
                
            }
        }
        
        //MARK: Barrier to synchronize tasks
        
        concurrentQueue.async(flags: .barrier) {
            print("-------Synchronized Tasks------")
        }
        
        
        for j in half..<charArray.count {
            
            concurrentQueue.async { [unowned self] in
                print(self.charArray[j])
            }
            
        }
    } // end func
    
    
    
    //MARK: Dispatch Semaphore
    func doDispatchSemeaphore() {
        
        //gives us the ability to control access to a shared resource (FIFO order)
        
        //Multiple Queues with different qualites of service
        let firstKid = DispatchQueue.global(qos: .utility)
        let secondKid = DispatchQueue.global(qos: .userInitiated)
        let thirdKid = DispatchQueue.global() //default QOS
        
        //Dispatch Semaphore
        let semaphore = DispatchSemaphore(value: 1) //how many threads (kids) can use at one time
        
        //1
        firstKid.async {
            
            print("Kid 1 - waiting")
            
            semaphore.wait() //decreases value of semaphore by 1
            
            print("Kid 1 - is playing")
            
            sleep(3)
            print("Kid 1 - is done")
            semaphore.signal() //call signal, after using resource, this increases sempahore value by 1
        } //first queue
        
        //2
        
        secondKid.async {
            
            print("Kid 2 - waiting")
            
            semaphore.wait() //decreases value of semaphore by 1
            
            print("Kid 2 - is playing")
            
            sleep(3)
            print("Kid 2 - is done")
            semaphore.signal() //call signal, after using resource, this increases sempahore value by 1
        } //first queue
        
        
        thirdKid.async {
            
            print("Kid 3 - waiting")
            
            semaphore.wait() //decreases value of semaphore by 1
            
            print("Kid 3 - is playing")
            
            sleep(3)
            print("Kid 3 - is done")
            semaphore.signal() //call signal, after using resource, this increases sempahore value by 1
        } //first queue
        
        
    } //end func
    
    
} //end class
