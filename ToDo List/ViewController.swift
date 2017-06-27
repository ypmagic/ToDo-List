//
//  ViewController.swift
//  ToDo List
//
//  Created by Young Park on 6/27/17.
//  Copyright © 2017 Young Park. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var important: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addToDo(_ sender: Any) {
        if !textField.stringValue.isEmpty {
            if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
                let toDoItem = ToDoItem(context: context)
                if important.state == 0 {
                    toDoItem.important = false
                } else {
                    toDoItem.important = true
                }
                toDoItem.name = textField.stringValue
            }
        }
    }
}

