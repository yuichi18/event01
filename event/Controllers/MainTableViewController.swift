//
//  MainTableViewController.swift
//  event
//
//  Created by 祐一 on 2019/09/06.
//  Copyright © 2019 yuichi. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTableViewController: UITableViewController,ShopCollectionDelegate {

    let shopCollection = ShopCollection.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopCollection.delegate = self

    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    
    @IBAction func addTappedBtn(_ sender: Any) {
//        self.performSegue(withIdentifier: "showToShopSearchViewController", sender: nil)
               self.performSegue(withIdentifier: "showToClientListViewController", sender: nil)
    }

}

extension MainTableViewController {
    // デリゲート
    func reload() {
        print ("saved")
        self.tableView.reloadData()
    }
}

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shopCollection.shops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print ("Section: " + String(indexPath.section) + " row:" + String(indexPath.row))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = shopCollection.shops[indexPath.row].shopName
        
        return cell
    }
    
    // セルの選択
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let toVC = storyboard?.instantiateViewController(withIdentifier: "ClientDetailViewController") as! ClientDetailViewController
        toVC.selectedShop = shopCollection.shops[indexPath.row]
        self.navigationController?.pushViewController(toVC, animated: true)
        //        performSegue(withIdentifier: "showToTaskViewController", sender: selectedTask)
    }
    
    // スワイプで削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        shopCollection.removeShop(at: indexPath.row)
    }
    
}

