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
    public static func unimplemented(
        create: @escaping (AnyHashable) -> Effect<Action, Never> = { _ in _unimplemented("create") },
        destroy: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("destroy") },
        set: @escaping ([String], AnyHashable) -> Effect<Never, Never> = { _, _ in _unimplemented("set") },
        fetchProducts: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("fetchProducts") },
        purchase: @escaping (String, AnyHashable) -> Effect<Never, Never> = { _, _  in _unimplemented("purchase") },
        restore: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("restore") }
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
