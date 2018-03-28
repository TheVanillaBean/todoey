//
//  Category.swift
//  Todoey
//
//  Created by Alex on 3/4/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
