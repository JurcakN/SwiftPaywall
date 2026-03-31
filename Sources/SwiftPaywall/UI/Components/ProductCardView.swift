//
//  ProductCardView.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import SwiftUI

//public struct ProductCardView: View {
//    
//    let product: PaywallProduct
//    let isSelected: Bool
//    let theme: PaywallTheme
//    let copy: PaywallCopy
//    let onSelect: () -> Void
//    
//    public init(
//        product: PaywallProduct,
//        isSelected: Bool,
//        theme: PaywallTheme,
//        copy: PaywallCopy,
//        onSelect: @escaping () -> Void
//    ) {
//        self.product = product
//        self.isSelected = isSelected
//        self.theme = theme
//        self.copy = copy
//        self.onSelect = onSelect
//    }
//    
//    public var body: some View {
//        Button(action: onSelect) {
//            HStack {
//                VStack(alignment: .leading, spacing: 4) {
//                    HStack(spacing: 8) {
//                        Text(product.displayName)
//                            .font(.headline)
//                            .foregroundStyle(theme.primaryTextColor)
//                        
//                        if product.type == .annual {
//                            Text(copy.annualBadgeText)
//                                .font(.caption.bold())
//                                .foregroundStyle(theme.ctaTextColor)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 2)
//                                .background(theme.accentColor)
//                                .clipShape(Capsule())
//                        }
//                        
//                        if product.type == .lifetime {
//                            Text("One-time")
//                                .font(.caption.bold())
//                                .foregroundStyle(theme.accentColor)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 2)
//                                .background(theme.accentColor.opacity(0.2))
//                                .clipShape(Capsule())
//                        }
//                    }
//                    
//                    if let perMonth = product.pricePerMonth, product.type == .annual {
//                        Text(perMonth)
//                            .font(.caption)
//                            .foregroundStyle(theme.secondaryTextColor)
//                    }
//                }
//                
//                Spacer()
//                
//                VStack(alignment: .trailing, spacing: 2) {
//                    Text(product.displayPrice)
//                        .font(.headline)
//                        .foregroundStyle(theme.primaryTextColor)
//                }
//                
//                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
//                    .foregroundStyle(isSelected ? theme.accentColor : theme.secondaryTextColor)
//                    .font(.title2)
//                    .padding(.leading, 8)
//            }
//            .padding(16)
//            .background(theme.cardBackgroundColor)
//            .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius))
//            .overlay(
//                RoundedRectangle(cornerRadius: theme.cornerRadius)
//                    .stroke(isSelected ? theme.accentColor : Color.clear, lineWidth: 2)
//            )
//        }
//    }
//}

struct ProductCardView: View {
    
    //MARK: - PROPERTIES
    let product: PaywallProduct
    let isSelected: Bool
    let theme: PaywallTheme
    let copy: PaywallCopy
    let onSelect: () -> Void
    
    //MARK: - INITIALIZATION
    public init(
        product: PaywallProduct,
        isSelected: Bool,
        theme: PaywallTheme,
        copy: PaywallCopy,
        onSelect: @escaping () -> Void
    ) {
        self.product = product
        self.isSelected = isSelected
        self.theme = theme
        self.copy = copy
        self.onSelect = onSelect
    }
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.displayName)
                        .font(.title2.bold())
                    
                    HStack(spacing: 0) {
                        Text(product.displayPrice)
                            .font(.subheadline)
                        
                        if product.type == .monthly {
                            Text(" / month")
                                .font(.caption)
                                .foregroundStyle(Color.secondary)
                        }
                        
                        if product.type == .annual {
                            Text(" / year")
                                .font(.caption)
                                .foregroundStyle(Color.secondary)
                        }
                    }
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isSelected ? theme.accentColor : theme.secondaryTextColor)
            }
        }
        .padding(.horizontal)
        .frame(height: 75)
        .frame(maxWidth: .infinity)
        .background(Color.secondary.opacity(0.25), in: RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.blue.gradient, lineWidth: 2)
                .opacity(isSelected ? 1 : 0)
        )
        .overlay(alignment: .topTrailing) {
            Text(copy.annualBadgeText)
                .font(.caption.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.blue, in: Capsule())
                .offset(x: -20, y: -10)
        }
        .padding(.horizontal)
        .onTapGesture {
            onSelect()
        }
    }
}
