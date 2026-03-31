//
//  PaywallView.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import SwiftUI
import StoreKit

public struct PaywallView: View {
    
    @StateObject private var viewModel: PaywallViewModel
    
    public init(manager: PaywallManager, configuration: PaywallConfiguration) {
        _viewModel = StateObject(
            wrappedValue: PaywallViewModel(
                manager: manager,
                configuration: configuration
            )
        )
    }
    
    public var body: some View {
        ZStack {
            viewModel.theme.backgroundColor
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Header
                    PaywallHeaderView(
                        theme: viewModel.theme,
                        copy: viewModel.copy
                    )
                    
                    // Products
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(viewModel.theme.accentColor)
                            .padding(.top, 40)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(viewModel.products) { product in
                                ProductCardView(
                                    product: product,
                                    isSelected: viewModel.selectedProduct?.id == product.id,
                                    theme: viewModel.theme,
                                    copy: viewModel.copy
                                ) {
                                    viewModel.selectProduct(product)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    
                    // Error
                    if let error = viewModel.error {
                        Text(error.localizedDescription)
                            .font(.caption)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    
                    // CTA Button
                    Button {
                        Task { await viewModel.purchase() }
                    } label: {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(viewModel.theme.ctaTextColor)
                            } else {
                                Text(viewModel.copy.ctaText)
                                    .font(.headline)
                                    .foregroundStyle(viewModel.theme.ctaTextColor)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(viewModel.theme.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: viewModel.theme.cornerRadius))
                        .padding(.horizontal, 24)
                    }
                    .disabled(viewModel.isLoading || viewModel.selectedProduct == nil)
                    
                    // Footer
                    LegalFooterView(
                        theme: viewModel.theme,
                        copy: viewModel.copy,
                        configuration: viewModel.configuration,
                        onRestoreTap: {
                            Task { await viewModel.restore() }
                        },
                        onPrivacyTap: { viewModel.handlePrivacyTap() },
                        onTermsTap: { viewModel.handleTermsTap() }
                    )
                }
            }
        }
        .sheet(isPresented: $viewModel.showPrivacySheet) {
            if let content = viewModel.privacySheetContent {
                content
            }
        }
        .sheet(isPresented: $viewModel.showTermsSheet) {
            if let content = viewModel.termsSheetContent {
                content
            }
        }
        .task {
            viewModel.autoSelectBestProduct()
        }
    }
}
