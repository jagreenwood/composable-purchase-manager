//
//  Dependencies.swift
//  
//
//  Created by Jeremy Greenwood on 1/22/21.
//

import Foundation

struct Dependencies {
    let delegate: PurchaseManagerDelegate
    let queue: SKPaymentQueue
    var request: SKProductsRequest?
    let subscriber: Effect<PurchaseManager.Action, Never>.Subscriber
}
