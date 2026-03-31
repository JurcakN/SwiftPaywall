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

    @Published public var selectedProduct: PaywallProduct?
    @Published public var showPrivacySheet: Bool = false
    @Published public var showTermsSheet: Bool = false
    @Published public var privacySheetContent: AnyView? = nil
    @Published public var termsSheetContent: AnyView? = nil

    private let manager: PaywallManager
    public let configuration: PaywallConfiguration

    // These now pass through @Published from manager correctly
    public var products: [PaywallProduct] { manager.products }
    public var isLoading: Bool { manager.isLoading }
    public var error: PaywallError? { manager.error }
    public var theme: PaywallTheme { configuration.theme }
    public var copy: PaywallCopy { configuration.copy }

    public init(manager: PaywallManager, configuration: PaywallConfiguration) {
        self.manager = manager
        self.configuration = configuration
    }

    public func purchase() async {
        guard let selected = selectedProduct else { return }
        await manager.purchase(selected.product)
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
