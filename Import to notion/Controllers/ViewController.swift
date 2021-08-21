//
//  ViewController.swift
//  Import to notion
//
//  Created by Роман далинкевич on 01.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var notionTableView: UITableView!
    
    let model = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.queryFromDatabase()
    }
    
    @IBAction func downloadFromNotion(_ sender: Any) {
        notionTableView.reloadData()
        print(model.users.count)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotionCell") as! NotionTableViewCell
        cell.nameLabel.text = "\(model.users[indexPath.row].properties.Name.title[0].plain_text)"
        cell.emailLabel.text = "\(model.users[indexPath.row].properties.Email.rich_text[0].plain_text)"
       
        return cell
    }
    
}
