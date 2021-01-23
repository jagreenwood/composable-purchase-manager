import Combine
import ComposableArchitecture
import StoreKit

public struct PurchaseManager {
    public enum Action: Equatable {
        case didRetrieveProducts([SKProduct])
        case didCompletePurchase(String)
        case didDeferPurchase(String)
        case isPurchasing(String)
        case didFail(String?, PurchaseError)
        case validateReceipt(ReceiptValidation)
    }
    
    var create: (AnyHashable) -> Effect<Action, Never> = { _ in _unimplemented("create") }

    var destroy: (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("destroy") }
    
    var set: ([String], AnyHashable) -> Effect<Never, Never> = { _, _ in _unimplemented("set") }
    
    var fetchProducts: (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("fetchProducts") }
    
    var purchase: (String, AnyHashable) -> Effect<Never, Never> = { _, _  in _unimplemented("purchase") }
    
    var restore: (AnyHashable) -> Effect<Never, Never> = { _ in _unimplemented("restore") }
}

public extension PurchaseManager {
    func create(id: AnyHashable) -> Effect<Action, Never> {
      self.create(id)
    }

    func destroy(id: AnyHashable) -> Effect<Never, Never> {
      self.destroy(id)
    }
    
    func set(productIdentifiers: [String], id: AnyHashable) -> Effect<Never, Never> {
        self.set(productIdentifiers, id)
    }
    
    func fetchProducts(id: AnyHashable) -> Effect<Never, Never> {
        self.fetchProducts(id)
    }
    
    func purchase(productID: String, id: AnyHashable) -> Effect<Never, Never> {
        self.purchase(productID, id)
    }
    
    func restore(id: AnyHashable) -> Effect<Never, Never> {
        self.restore(id)
    }
}

func _unimplemented(
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
