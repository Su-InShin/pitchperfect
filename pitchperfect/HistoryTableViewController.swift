//
//  HistoryTableViewController.swift
//  pitchperfect
//
//  Created by 신수인 on 2017. 1. 15..
//  Copyright © 2017년 신수인. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var filelist = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - Make List of Files
        //디렉토리내에 존재하는 모든 파일의 이름을 읽어와서 배열에 저장해주는 부분
        let filemanager = FileManager.default
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        do{
            filelist = try filemanager.contentsOfDirectory(atPath: dirPath)
        }catch{
            print("Making the file list was failed")
        }
        //끝
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filelist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableCell", for: indexPath) as! HistoryTableViewCell

        // Configure the cell...
        let row = indexPath.row
        cell.HistoryFileName.text = filelist[row]

        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // MARK: - Segue with the selected cell
        //셀을 선택할 시 PlaySoundView로 세그가 넘어가도록 설정해주는 부분. 해당 셀의 파일 URL을 같이 보내준다.
        if segue.identifier == "PlaySelectedFile"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            let pathArray = [dirPath, filelist[row]]
            let filePath = URL(string: pathArray.joined(separator: "/"))
            let recordedAudioURL = filePath
            playSoundsVC.recordedAudioURL = recordedAudioURL
            
            
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
