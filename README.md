# composable-purchase-manager

Composable Purchase Lanager is library that bridges [the Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) and [(Original) In-App Purchase](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase).

## Features:

* Fetch Products
* Purchase Product
* Restore Purchases

## Basic Usage

First an `Action` needs to be added in order to handle actions emitted from `ComposablePurchaseManager`

```swift
import ComposablePurchaseManager

enum AppAction {
    case purchaseMananger(PurchaseManager.Action)

    // Your other actions
    ...
}
```

Next add an instance of `PurchaseManager` to your `Environment`

```swift
struct Environment {
    var purchaseManager: () -> PurchaseManager
    
    // Your other dependencies
    ...
    
    static var live = Self(
        purchaseManager: { .live }
    )
}
```

Finally configure the reducer setup the purchase manager, set the product identifer and fetch the product.

```swift
public static let reducer = Reducer<State, Action, Environment> { state, action, environment in
    struct PurchaseManagerId: Hashable {}
            
        switch action {            
        case .onAppear:
            return .merge(
                // set up purchase manager
                environment.purchaseManager()
                    .create(id: PurchaseManagerId())
                    .map(Action.purchaseManager),
                // set product ids
                environment.purchaseManager()
                    .set(
                        productIdentifiers: ["premium-package"],
                        id: PurchaseManagerId())
                    .fireAndForget(),
                // fetch products
                environment.purchaseManager()
                    .fetchProducts(id: PurchaseManagerId())
                    .fireAndForget()
            )
            
        case .purchaseManager(let action):
            // handle purchase manager actions
            switch(action):
                case .validateReceipt(validation):
                    // do some validation
                    validation.success()
            return .none
        }
    }
```

## Validating the Receipt

After a successful purchase or restore, the `PurchaseManager.Action.validateReceipt` action is emitted. This action *must be handled* to complete the purchase. 

`ComposablePurchaseManager` defers the method of receipt validation to the consumer. The action has an associated value of `ReceiptValiation` which is initialized with two closures: `success: @escaping () -> ()` and `failure: @escaping () -> ()`. The consumer should perform its desire receipt valiation method, then call the appropriate closure. If `success` is called, `PurchaseManager.Action.complete` will immediately be emitted, if `failure`, `PurchaseManager.Action.failed` will be emitted. 
