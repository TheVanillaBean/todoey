//
//  Item.swift
//  Todoey
//
//  Created by Alex on 2/19/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

class Item: Codable {
    
    private(set) public var title: String
    private var _isDone: Bool
    public var isDone: Bool {
        get {
            return _isDone
        }
        
        set(toggle){
            _isDone = toggle
        }
        
    }
    
    init(title: String, isDone: Bool) {
        self.title = title
        self._isDone = isDone
    }
    
    init(title: String) {
        self.title = title
        self._isDone = false
    }
    
    convenience init() {
        self.init(title: "", isDone: false)
    }
    
    
    
}
