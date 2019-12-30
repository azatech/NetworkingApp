//
//  Devices.swift
//  Networking
//
//  Created by Azat Chorekliev on 12/29/19.
//  Copyright © 2019 Azat Chorekliev. All rights reserved.
//

import UIKit

struct Devices: Decodable {

    let id: Int
    let name: String
    let serial: String
    let link: String
    let link_Image: String
    let price: Int
}
