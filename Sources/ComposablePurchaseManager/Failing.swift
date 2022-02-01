//
//  Mock.swift
//  
//
//  Created by Jeremy Greenwood on 1/23/21.
//

#if DEBUG
import ComposableArchitecture
import StoreKit

extension PurchaseManager {
    public static func failing(
        create: @escaping (AnyHashable) -> Effect<Action, Never> = { _ in .failing("create") },
        destroy: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in .failing("destroy") },
        set: @escaping ([String], AnyHashable) -> Effect<Never, Never> = { _, _ in .failing("set") },
        fetchProducts: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in .failing("fetchProducts") },
        purchase: @escaping (SKProduct, AnyHashable) -> Effect<Never, Never> = { _, _  in .failing("purchase") },
        restore: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in .failing("restore") }
    ) -> PurchaseManager {
        PurchaseManager(
            create: create,
            destroy: destroy,
            set: set,
            fetchProducts: fetchProducts,
            purchase: purchase,
            restore: restore)
    }
}
#endif
