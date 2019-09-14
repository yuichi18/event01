//
//  MainTimelineTableViewController.swift
//  event
//
//  Created by 祐一 on 2019/09/12.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTimelineTableViewController: UITableViewController,PostCollectionDelegate {
    
    let postCollection = PostCollection.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postCollection.delegate = self
    }
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
    
    //    @IBAction func addTappedBtn(_ sender: Any) {
    //        //        self.performSegue(withIdentifier: "showToShopSearchViewController", sender: nil)
    //        self.performSegue(withIdentifier: "showToClientListViewController", sender: nil)
    //    }
    
}

extension MainTimelineTableViewController {
    // デリゲート
    func reload() {
        self.tableView.reloadData()
    }
}


extension MainTimelineTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postCollection.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print ("Section: " + String(indexPath.section) + " row:" + String(indexPath.row))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = postCollection.posts[indexPath.row].title
        
        return cell
    }
    
    // セルの選択
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let VC = storyboard?.instantiateViewController(withIdentifier: "TimeLIneDetailViewController") as! TimeLIneDetailViewController
        VC.selectedPost = postCollection.posts[indexPath.row]
        self.navigationController?.pushViewController(VC, animated: true)
        //        performSegue(withIdentifier: "showToTaskViewController", sender: selectedTask)
    }
    
    //    // スワイプで削除
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        shopCollection.removeShop(at: indexPath.row)
    //    }
    
}

