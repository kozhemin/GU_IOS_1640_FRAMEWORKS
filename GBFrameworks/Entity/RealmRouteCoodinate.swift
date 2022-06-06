//
//  RealmRouteCoodinate.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 18.05.2022.
//

import CoreLocation
import Foundation
import RealmSwift

class RealmRouteCoodinate: Object {
    @Persisted var id: String = ""
    @Persisted var latitude: Double
    @Persisted var longitude: Double
    @Persisted var timestamp: Double

    override class func primaryKey() -> String? {
        "id"
    }

    override class func indexedProperties() -> [String] {
        ["timestamp"]
    }
}

extension RealmRouteCoodinate {
    convenience init(coodinate: CLLocationCoordinate2D) {
        self.init()
        id = UUID().uuidString
        latitude = coodinate.latitude
        longitude = coodinate.longitude
        timestamp = NSDate().timeIntervalSince1970
    }
}

extension RealmRouteCoodinate {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
