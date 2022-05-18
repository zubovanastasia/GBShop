//
//  MapRoute.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 18.05.2022.
//

import Foundation

struct MapPath: Decodable {
    var routes: [Route]?
}
struct Route: Decodable {
    var overviewPolyline: OverView?
}
struct OverView: Decodable {
    var points: String?
}
