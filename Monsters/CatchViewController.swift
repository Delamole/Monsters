//
//  CatchViewController.swift
//  Monsters
//
//  Created by Владислав Бочаров on 12.10.2020.
//

import UIKit
import ARKit
import SceneKit
import RealmSwift
import PopupDialog

class CatchViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var name = ""
    var level = 0
    var image = ""
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        levelLabel.text = "\(level)"
        nameLabel.text = name
        
        sceneView.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
        addTargetNodes()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configurator = ARWorldTrackingConfiguration()
        sceneView.session.run(configurator)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    

    @IBAction func `catch`(_ sender: Any) {
        let i = Int.random(in: 1...5)
        print("вероятность \(i)")
        
        if i == 5 {
            let title = "Монстр пойман"
            let message = "Монстр добавлен в команду"
        let popup = PopupDialog(title: title, message: message)
            let okButton = DefaultButton(title: "Поймать нового монстра") {
                self.dismiss(animated: true, completion: nil)
        }
            let monster = Monsters()
            monster.name = name
            monster.level = "\(level)"
            monster.image = image

            try! self.realm.write {
                self.realm.add(monster)
            }
            
        popup.addButton(okButton)
        self.present(popup, animated: true, completion: nil)
        } else {
            let j = Int.random(in: 1...3)
            print("вероятность \(i)")
            if j == 3{
        let title = "Монстр не пойман"
        let message = "Монстру не удалось убежать"
        let popup = PopupDialog(title: title, message: message)
        let okButton = DefaultButton(title: "Попробовать снова") {
           print("cancel")
        }
        popup.addButton(okButton)
        self.present(popup, animated: true, completion: nil)
            }else{
                let title = "Монстр не пойман"
                let message = "Монстру удалось убежать"
                let popup = PopupDialog(title: title, message: message)
                let okButton = DefaultButton(title: "Вернуть на карту") {
                    self.dismiss(animated: true, completion: nil)
                }
                popup.addButton(okButton)
                self.present(popup, animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    func addTargetNodes() {

            var node = SCNNode()

          
                let scene = SCNScene(named: "SceneKit.scnassets/table.dae")
                node = (scene?.rootNode.childNode(withName: "Table", recursively: true)!)!
                node.scale = SCNVector3(1,1,1)
                node.name = "table"
            
            node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            node.physicsBody?.isAffectedByGravity = false

            node.position = SCNVector3(0, -1, -1)

            let action: SCNAction = SCNAction.rotate(by: .pi, around: SCNVector3(0,1,0), duration: 1.0)
            let forever = SCNAction.repeatForever(action)
            node.runAction(forever)


            sceneView.scene.rootNode.addChildNode(node)

    }
}
