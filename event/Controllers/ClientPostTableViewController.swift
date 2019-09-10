//
//  ClientPostTableViewController.swift
//  event
//
//  Created by 祐一 on 2019/09/11.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import FirebaseAuth

class ClientPostTableViewController: UITableViewController, ClientPostCollectionDelegate {

    let clientPostCollection = ClientPostCollection.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clientPostCollection.delegate = self
        
    }
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
    
    @IBAction func addTappedBtn(_ sender: Any) {
        //        self.performSegue(withIdentifier: "showToShopSearchViewController", sender: nil)
        self.performSegue(withIdentifier: "showToClientPostViewController", sender: nil)
    }
    
}

extension ClientPostTableViewController {
    // デリゲート
    func reload() {
        print ("saved")
        self.tableView.reloadData()
    }
}

extension ClientPostTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return clientPostCollection.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print ("Section: " + String(indexPath.section) + " row:" + String(indexPath.row))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = clientPostCollection.posts[indexPath.row].title
        
        return cell
    }
    
    // セルの選択
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let toVC = storyboard?.instantiateViewController(withIdentifier: "ClientPostViewController") as! ClientPostViewController
        toVC.selectedPost = clientPostCollection.posts[indexPath.row]
        self.navigationController?.pushViewController(toVC, animated: true)
        //        performSegue(withIdentifier: "showToTaskViewController", sender: selectedTask)
    }
    
    // スワイプで削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        clientPostCollection.removePost(at: indexPath.row)
    }
    
}

