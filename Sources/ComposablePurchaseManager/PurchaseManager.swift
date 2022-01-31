import Combine
import ComposableArchitecture
import StoreKit

public struct PurchaseManager {
    public enum Action: Equatable {
        case didCompletePurchase(String)
        case didDeferPurchase(String)
        case didFail(String?, PurchaseError)
        case didRestoreProductID(String)
        case didRetrieveProducts([SKProduct])
        case isPurchasing(String)
        case noProductsToRestore
        case validateReceipt(ReceiptValidation)
    }
    
    var create: (AnyHashable) -> Effect<Action, Never> = { _ in .failing("create") }

    var destroy: (AnyHashable) -> Effect<Never, Never> = { _ in .failing("destroy") }
    
    var set: ([String], AnyHashable) -> Effect<Never, Never> = { _, _ in .failing("set") }
    
    var fetchProducts: (AnyHashable) -> Effect<Never, Never> = { _ in .failing("fetchProducts") }
    
    var purchase: (SKProduct, AnyHashable) -> Effect<Never, Never> = { _, _  in .failing("purchase") }
    
    var restore: (AnyHashable) -> Effect<Never, Never> = { _ in .failing("restore") }
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
    
    func purchase(product: SKProduct, id: AnyHashable) -> Effect<Never, Never> {
        self.purchase(product, id)
    }
    
    func restore(id: AnyHashable) -> Effect<Never, Never> {
        self.restore(id)
    }
}
