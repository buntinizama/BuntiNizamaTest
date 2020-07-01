//
//  Item.swift
//  BuntiNizama_Test
//
//  Created by Bunti Nizama on 30/06/20.
//

import Foundation
import RealmSwift


class  Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var itemDescription : String = ""
    @objc dynamic var isSelected : Bool = false
}



