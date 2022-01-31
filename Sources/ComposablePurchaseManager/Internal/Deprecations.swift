//
//  Deprecations.swift
//
//
//  Created by Jeremy Greenwood on 1/31/22.
//

#if DEBUG
import ComposableArchitecture
import StoreKit

@available(*, unavailable, message: "Use 'PurchaseManager.failing', instead")
extension PurchaseManager {
    public static func unimplemented(
        create: @escaping (AnyHashable) -> Effect<Action, Never> = { _ in _unimplemented("create") },
        destroy: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("destroy") },
        set: @escaping ([String], AnyHashable) -> Effect<Never, Never> = { _, _ in _unimplemented("set") },
        fetchProducts: @escaping (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("fetchProducts") },
        purchase: @escaping (SKProduct, AnyHashable) -> Effect<Never, Never> = { _, _  in _unimplemented("purchase") },
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

public func _unimplemented(
    _ function: StaticString, file: StaticString = #file, line: UInt = #line
) -> Never {
    fatalError(
    """
    `\(function)` was called but is not implemented. Be sure to provide an implementation for
    this endpoint when creating the mock.
    """,
    file: file,
    line: line
    )
}
#endif

