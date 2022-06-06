//
//  RouteManager.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 18.05.2022.
//

import CoreLocation
import Foundation
import RealmSwift

protocol RouteManagerProtocol: AnyObject {
    func start()
    func stop()
    func track(coodinate: CLLocationCoordinate2D)
    func canViewLastTrack() -> Bool
    func getLastTrack(completion: @escaping (Results<RealmRouteCoodinate>?) -> Void)
}

enum RouereStage {
    case run
    case stop
}

class RouteManager: RouteManagerProtocol {
    var stage: RouereStage = .stop
    var coodinates = [RealmRouteCoodinate]()
    let queue = DispatchQueue.global(qos: .utility)

    func start() {
        stage = .run
        coodinates.removeAll()
    }

    func stop() {
        if stage != .run {
            return
        }
        stage = .stop

        queue.async {
            try? RealmService.deleteAll()
            try? RealmService.save(items: self.coodinates)
        }
    }

    func track(coodinate: CLLocationCoordinate2D) {
        if stage != .run {
            return
        }

        let realmData = RealmRouteCoodinate(coodinate: coodinate)
        coodinates.append(realmData)
    }

    func canViewLastTrack() -> Bool {
        stage == .stop
    }

    func getLastTrack(completion: @escaping (Results<RealmRouteCoodinate>?) -> Void) {
        let retData = try? RealmService.load(typeOf: RealmRouteCoodinate.self)
        completion(retData)
    }
}
