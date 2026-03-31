//
//  PaywallViewModel.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

#if canImport(UIKit)
import UIKit
#endif
import SwiftUI

@MainActor
public final class PaywallViewModel: ObservableObject {
    // ... existing @Published properties ...
    
    @Published public var isLoading: Bool = false
    @Published public var products: [PaywallProduct] = []
    @Published public var error: PaywallError? = nil
    
    private let manager: PaywallManager
    public let configuration: PaywallConfiguration
    
    public init(manager: PaywallManager, configuration: PaywallConfiguration) {
        self.manager = manager
        self.configuration = configuration
        
        // Bind manager's published properties to view model
        manager.$isLoading.assign(to: &$isLoading)
        manager.$products.assign(to: &$products)
        manager.$error.assign(to: &$error)
    }

    public func purchase() async {
        guard let selected = selectedProduct else { return }
        await manager.purchase(selected)
    }

    public func restore() async {
        await manager.restore()
    }

    public func selectProduct(_ product: PaywallProduct) {
        selectedProduct = product
    }

    public func handlePrivacyTap() {
        switch configuration.privacyPolicy {
        case .url(let url):
            #if canImport(UIKit)
            UIApplication.shared.open(url)
            #endif
        case .sheet(let view):
            privacySheetContent = view
            showPrivacySheet = true
        case .none:
            break
        }
    }

    public func handleTermsTap() {
        switch configuration.terms {
        case .url(let url):
            #if canImport(UIKit)
            UIApplication.shared.open(url)
            #endif
        case .sheet(let view):
            termsSheetContent = view
            showTermsSheet = true
        case .none:
            break
        }
    }

    public func autoSelectBestProduct() {
        let annual = products.first { $0.type == .annual }
        selectedProduct = annual ?? products.first
    }
}
