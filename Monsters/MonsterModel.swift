//
//  MonsterModel.swift
//  Monsters
//
//  Created by Владислав Бочаров on 12.10.2020.
//

import Foundation
import RealmSwift

class Monsters: Object {
    @objc dynamic var name=""
    @objc dynamic var level=""
    @objc dynamic var image=""
}
