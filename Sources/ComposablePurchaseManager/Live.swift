//
//  Live.swift
//  
//
//  Created by Jeremy Greenwood on 1/22/21.
//

import Combine
import ComposableArchitecture
import StoreKit

extension PurchaseManager {
    public static let live: PurchaseManager = { () -> PurchaseManager in
        var manager = PurchaseManager()
        
        manager.create = { id in
            Effect.run { subscriber in
                let queue = SKPaymentQueue.default()
                var delegate = PurchaseManagerDelegate(subscriber)
                queue.add(delegate)
                
                dependencies[id] = Dependencies(
                    delegate: delegate,
                    queue: queue,
                    request: nil,
                    subscriber: subscriber)
                
                return AnyCancellable {
                    dependencies[id] = nil
                }
            }
        }
        
        manager.destroy = { id in
            .fireAndForget {
                guard let managerDependencies = dependencies[id] else {
                    return
                }
                
                managerDependencies.queue.remove(managerDependencies.delegate)
                managerDependencies.subscriber.send(completion: .finished)
                dependencies[id] = nil
            }
        }
        
        manager.set = { productIdentifiers, id in
            .fireAndForget {
                let request = SKProductsRequest(productIdentifiers: Set(productIdentifiers))
                dependencies[id]?.request = request
                
                request.start()
            }
        }
        
        manager.fetchProducts = { id in
            .fireAndForget {
                dependencies[id]?.request?.start()
            }
        }
        
        return manager
    }()
}

private var dependencies: [AnyHashable: Dependencies] = [:]
