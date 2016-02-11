//
//  JSONObjectSerializable.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/10/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import SwiftyJSON

public protocol ResponseJSONObjectSerializable {
    init?(json: SwiftyJSON.JSON)
}

public protocol ResponseJSONCollectionSerializable {
    static func collection(json: SwiftyJSON.JSON) -> [Self]
}
