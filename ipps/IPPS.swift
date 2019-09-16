//
//  IPPS.swift
//  ipps
//
//  Created by Rene Zablah on 9/4/19.
//  Copyright © 2019 BASE2 LLC. All rights reserved.
//

import UIKit


struct IPPS: Decodable {
    let drgdef: String
    let id: Int
    
    let name: String
    let address: String
    let city: String
    let state: String
    let zipcode: String
    let region: String
    let totaldischarges: Int
    let avgcoveredcharge: Float
    let avgtotalpayments: Float
    let avgmedicarepayments: Float
}
