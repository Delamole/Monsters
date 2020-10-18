//
//  TeamViewController.swift
//  Monsters
//
//  Created by Владислав Бочаров on 08.10.2020.
//

import UIKit
import RealmSwift

class TeamViewController: UIViewController {

    @IBOutlet weak var teamTable: UITableView!
    let realm = try! Realm()
    var collectionMonster = try! Realm().objects(Monsters.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

}

extension TeamViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if collectionMonster.count == 0{
            return 0
        }
        return collectionMonster.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as! TeamTableViewCell
        let item = collectionMonster[indexPath.row]
        cell.name.text = item.name
        cell.desription.text = "level "+item.level
        cell.imageView?.image = UIImage(named: item.image)
        
    
        return cell
    }
        }
