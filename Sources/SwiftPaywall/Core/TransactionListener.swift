//
//  TransactionListener.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import StoreKit

@MainActor
public final class TransactionListener: Sendable {
    
    private var task: Task<Void, Never>?
    
    public init() {}
    
    // MARK: - Lifecycle
    
    public func start(onUpdate: @escaping @Sendable (VerificationResult<Transaction>) async -> Void) {
        task = Task.detached {
            for await result in Transaction.updates {
                await onUpdate(result)
            }
        }
    }
    
    public func stop() {
        task?.cancel()
        task = nil
    }
}
