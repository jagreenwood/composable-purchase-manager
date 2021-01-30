//
//  PurchaseManagerDelegate.swift
//  
//
//  Created by Jeremy Greenwood on 1/22/21.
//

import Combine
import ComposableArchitecture
import StoreKit

class PurchaseManagerDelegate: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    private var didRestoreProduct = false
    
    let subscriber: Effect<PurchaseManager.Action, Never>.Subscriber

    init(_ subscriber: Effect<PurchaseManager.Action, Never>.Subscriber) {
      self.subscriber = subscriber
    }
    
    func complete(transaction: SKPaymentTransaction) {
        subscriber.send(.didCompletePurchase(transaction.payment.productIdentifier))

        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    func restore(transaction: SKPaymentTransaction) {
        let productIdentifier: String = {
            if let original = transaction.original {
                return original.payment.productIdentifier
            } else {
                return transaction.payment.productIdentifier
            }
        }()

        didRestoreProduct = true
        subscriber.send(.didRestoreProductID(productIdentifier))
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    func failed(transaction: SKPaymentTransaction, error: PurchaseError) {
        switch transaction.transactionState {
        case .purchasing:
            return
        default:
            if (transaction.error as? SKError)?.code != .paymentCancelled {
                subscriber.send(.didFail(transaction.payment.productIdentifier, error))
            }

            SKPaymentQueue.default().finishTransaction(transaction)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            guard let receipt = Bundle.main.appStoreReceiptURL, let receiptData = try? Data(contentsOf: receipt) else {
                failed(transaction: transaction, error: .cannotFindProduct)
                return
            }

            switch transaction.transactionState {
            case .purchased:
                subscriber.send(
                    .validateReceipt(
                        ReceiptValidation(
                            data: receiptData,
                            success: {
                                self.complete(transaction: transaction)
                            },
                            failure: {
                                self.failed(transaction: transaction, error: .invalidReceipt)
                            })))
            case .failed:
                failed(transaction: transaction, error: .purchaseFailed)
            case .restored:
                subscriber.send(
                    .validateReceipt(
                        ReceiptValidation(
                            data: receiptData,
                            success: {
                                self.restore(transaction: transaction)
                            },
                            failure: {
                                self.failed(transaction: transaction, error: .invalidReceipt)
                            })))
            case .deferred:
                subscriber.send(.didDeferPurchase(transaction.payment.productIdentifier))
            case .purchasing:
                subscriber.send(.isPurchasing(transaction.payment.productIdentifier))
            @unknown default: break
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        subscriber.send(.didFail(nil, .restoreFailed))
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if !didRestoreProduct {
            subscriber.send(.noProductsToRestore)
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.subscriber.send(.didRetrieveProducts(response.products))
        }
    }
}
