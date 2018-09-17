//
//  TableViewController.swift
//  InputAccessoryView
//
//  Created by HoangLuyen on 9/17/18.
//  Copyright © 2018 HoangLuyen. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var dataComment: [String] = ["One"]
    private var _inputAccessoryView: UIView?
    override var inputAccessoryView: UIView? {
        if _inputAccessoryView == nil {
            _inputAccessoryView = Bundle.main.loadNibNamed("InputAccessoryView", owner: self, options: nil)?.first as? UIView
        }
        return _inputAccessoryView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        (inputAccessoryView as? InputAccessoryView)?.delegate = self
        becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let lasIndex = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lasIndex, at: .bottom, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var canBecomeFirstResponder: Bool { return true }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataComment.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = dataComment[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dataComment.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension TableViewController: InputAccessoryViewDelegate {
    func inputAccessoryDidBeginEditing() {
        let lasIndex = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lasIndex, at: .bottom, animated: true)
    }
    
    func addRow(text: String) {
        dataComment.append(text)
        let lastIndex = IndexPath(row: dataComment.count - 1, section: 0)
        tableView.insertRows(at: [lastIndex], with: .automatic)
    }
    
    func inputAccessoryDidChangeSize() {
        let lasIndex = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lasIndex, at: .bottom, animated: true)
    }
    
    func inputAccessoryDidEndEditing() {
        let lasIndex = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lasIndex, at: .bottom, animated: true)
    }
    
    
}
