//
//  FavoriteTableViewController.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/17.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    let db = DBHelper.shared
    var indexList:Array<Int> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100
        indexList = db.fun_selectAll()
        print(indexList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indexList = db.fun_selectAll()
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return indexList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.lbFavoriteTitleText?.text = dataList[indexList[indexPath.row]][1]
        cell.lbFavoriteSubTitleText?.text = dataList[indexList[indexPath.row]][4]
        cell.lbFavoriteSubTitleText.numberOfLines = 0

        // Configure the cell...

        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteSegue"{
            if let vc = segue.destination as? PopupViewController{
                if let index = self.tableView.indexPathForSelectedRow?.row{
                    print(indexList[index])
                    vc.index = indexList[index]
                }
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
