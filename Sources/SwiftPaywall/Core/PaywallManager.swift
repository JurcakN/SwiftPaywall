//
//  PaywallManager.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import StoreKit

@MainActor
public final class PaywallManager: ObservableObject, Sendable {
    
    // MARK: - Public state
    @Published public var products: [PaywallProduct] = []
    @Published public var isLoading: Bool = false
    @Published public var error: PaywallError? = nil
    
    // MARK: - Dependencies
    public let entitlements: EntitlementManager
    private let listener: TransactionListener
    private let configuration: PaywallConfiguration
    
    // MARK: - Computed
    public var isSubscribed: Bool {
        entitlements.isSubscribed
    }
    
    public var subscriptionState: SubscriptionState {
        entitlements.subscriptionState
    }
    
    // MARK: - Init
    
    public init(configuration: PaywallConfiguration) {
        self.configuration = configuration
        self.entitlements = EntitlementManager()
        self.listener = TransactionListener()
    }
    
    // MARK: - Lifecycle
    
    /// Call this at app launch — starts the transaction listener and checks entitlements
    public func start() async {
        listener.start { [weak self] result in
            await self?.handle(transactionResult: result)
        }
        await entitlements.refresh()
        await loadProducts()
    }
    
    // MARK: - Products
    
    public func loadProducts() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let skProducts = try await Product.products(for: configuration.productIDs)
            products = skProducts.map { PaywallProduct(product: $0) }
        } catch {
            self.error = .productLoadFailed(error)
        }
    }
    
    // MARK: - Purchase
    
    public func purchase(_ paywallProduct: PaywallProduct) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await paywallProduct.product.purchase()
            
            switch result {
            case .success(let verification):
                await handle(transactionResult: verification)
            case .pending:
                self.error = .purchasePending
            case .userCancelled:
                break
            @unknown default:
                break
            }
        } catch {
            self.error = .purchaseFailed(error)
        }
    }
    
    // MARK: - Restore
    
    public func restore() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await AppStore.sync()
            await entitlements.refresh()
        } catch {
            self.error = .restoreFailed(error)
        }
    }
    
    // MARK: - Transaction handling
    
    private func handle(transactionResult: VerificationResult<Transaction>) async {
        guard case .verified(let transaction) = transactionResult else {
            self.error = .verificationFailed
            return
        }
        
        await entitlements.refresh()
        await transaction.finish()
    }
}
