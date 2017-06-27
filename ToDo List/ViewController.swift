//
//  ViewController.swift
//  ToDo List
//
//  Created by Young Park on 6/27/17.
//  Copyright © 2017 Young Park. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var important: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    var toDoItems : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getToDoItems()
    }
    
    func getToDoItems() {
        // get to do item from core data
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                // set them to class property
                toDoItems = try context.fetch(ToDoItem.fetchRequest())
            } catch {}
        }
        // update to the table
        tableView.reloadData()
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
            (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
            textField.stringValue = ""
            important.state = 0
            
            getToDoItems()
        }
    }
    
    // MARK: - TableView Stuff
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if tableColumn?.identifier == "importantColumn" {
            if let cell = tableView.make(withIdentifier: "importantCell", owner: self) as? NSTableCellView {
                let toDoItem = toDoItems[row]
                if toDoItem.important == true {
                    cell.textField?.stringValue = "⚠️"
                } else {
                    cell.textField?.stringValue = ""
                }
                return cell
            }
        } else {
            if let cell = tableView.make(withIdentifier: "textCell", owner: self) as? NSTableCellView {
                let toDoItem = toDoItems[row]
                cell.textField?.stringValue = toDoItem.name!
                return cell
            }
        }
        return nil
    }
}

