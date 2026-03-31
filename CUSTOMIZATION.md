# SwiftPaywall Customization Guide

## Overview

SwiftPaywall is designed to be fully customizable from your app. All configuration options have sensible defaults, so you only need to customize what you want to change.

## Quick Start

### Minimal Setup (Uses All Defaults)

```swift
import SwiftPaywall

let configuration = PaywallConfiguration(
    productIDs: ["monthly_sub", "annual_sub"]
)

PaywallView(configuration: configuration)
```

## Customization Options

### 1. Theme Customization

#### Using Presets

```swift
// Dark theme (default)
let config = PaywallConfiguration(
    productIDs: ["monthly_sub", "annual_sub"],
    theme: .dark
)

// Light theme
let config = PaywallConfiguration(
    productIDs: ["monthly_sub", "annual_sub"],
    theme: .light
)
```

#### Custom Colors - Direct Init

```swift
let customTheme = PaywallTheme(
    accentColor: .purple,
    backgroundColor: .black,
    primaryTextColor: .white,
    secondaryTextColor: .gray,
    cardBackgroundColor: .purple.opacity(0.15),
    ctaTextColor: .white,
    cornerRadius: 20
)
```

#### Custom Colors - Builder Pattern

```swift
let customTheme = PaywallTheme.dark
    .withAccentColor(.purple)
    .withCardBackgroundColor(.purple.opacity(0.15))
    .withCornerRadius(20)
```

**Available Theme Properties:**
- `accentColor` - Main brand color
- `backgroundColor` - Paywall background
- `primaryTextColor` - Titles and headings
- `secondaryTextColor` - Subtitles and descriptions
- `cardBackgroundColor` - Product card backgrounds
- `ctaTextColor` - Button text color
- `cornerRadius` - Card/button corner radius

### 2. Copy Customization

#### Direct Init

```swift
let customCopy = PaywallCopy(
    title: "Upgrade to Pro",
    subtitle: "Get unlimited access",
    ctaText: "Start Free Trial",
    restoreText: "Already purchased? Restore",
    cancelText: "Cancel anytime",
    privacyText: "Privacy",
    termsText: "Terms",
    pendingText: "Waiting for approval...",
    annualBadgeText: "Save 50%"
)
```

#### Builder Pattern

```swift
let customCopy = PaywallCopy()
    .withTitle("Upgrade to Pro")
    .withSubtitle("Get unlimited access")
    .withCtaText("Start Free Trial")
    .withAnnualBadgeText("Best Value")
```

**Available Copy Properties:**
- `title` - Main heading
- `subtitle` - Description below title
- `ctaText` - Purchase button text
- `restoreText` - Restore purchases button
- `cancelText` - Cancellation info
- `privacyText` - Privacy link text
- `termsText` - Terms link text
- `pendingText` - Pending purchase message
- `annualBadgeText` - Badge on annual products

### 3. Legal Links

#### URL Links (Opens Safari)

```swift
let config = PaywallConfiguration(
    productIDs: ["monthly_sub", "annual_sub"],
    privacyPolicy: .url(URL(string: "https://yourapp.com/privacy")!),
    terms: .url(URL(string: "https://yourapp.com/terms")!)
)
```

#### Custom Sheet Views

```swift
let config = PaywallConfiguration(
    productIDs: ["monthly_sub", "annual_sub"],
    privacyPolicy: .sheet(AnyView(PrivacyPolicyView())),
    terms: .sheet(AnyView(TermsView()))
)
```

#### No Links

```swift
let config = PaywallConfiguration(
    productIDs: ["monthly_sub", "annual_sub"],
    privacyPolicy: .none,
    terms: .none
)
```

## Complete Examples

### Example 1: Simple Customization

```swift
let configuration = PaywallConfiguration(
    productIDs: ["com.yourapp.monthly", "com.yourapp.annual"]
)
.withTheme(.dark.withAccentColor(.mint))
.withCopy(.init().withTitle("Go Premium"))
.withPrivacyPolicyURL(URL(string: "https://yourapp.com/privacy")!)
```

### Example 2: Full Customization

```swift
struct MyPaywall: View {
    var body: some View {
        PaywallView(configuration: configuration)
    }
    
    private var configuration: PaywallConfiguration {
        PaywallConfiguration(
            productIDs: ["com.app.monthly", "com.app.annual"],
            theme: customTheme,
            copy: customCopy,
            privacyPolicy: .url(URL(string: "https://myapp.com/privacy")!),
            terms: .url(URL(string: "https://myapp.com/terms")!)
        )
    }
    
    private var customTheme: PaywallTheme {
        PaywallTheme(
            accentColor: .indigo,
            backgroundColor: .black,
            primaryTextColor: .white,
            secondaryTextColor: .gray,
            cardBackgroundColor: .indigo.opacity(0.2),
            ctaTextColor: .white,
            cornerRadius: 24
        )
    }
    
    private var customCopy: PaywallCopy {
        PaywallCopy(
            title: "Unlock Premium Features",
            subtitle: "Get unlimited access to everything",
            ctaText: "Start 7-Day Free Trial",
            restoreText: "Restore Previous Purchase",
            cancelText: "Cancel anytime in Settings",
            annualBadgeText: "Best Deal - Save 50%"
        )
    }
}
```

### Example 3: Using Builder Pattern

```swift
let configuration = PaywallConfiguration(
    productIDs: ["monthly", "annual"]
)
.withTheme(
    .dark
        .withAccentColor(.orange)
        .withCardBackgroundColor(.orange.opacity(0.15))
)
.withCopy(
    PaywallCopy()
        .withTitle("Premium Access")
        .withCtaText("Subscribe Now")
)
```

## Best Practices

1. **Centralize Configuration**: Create your configuration once and reuse it
2. **Brand Consistency**: Use your app's brand colors
3. **Test Themes**: Verify your colors work in both light/dark modes
4. **Legal Links**: Always provide privacy/terms if collecting data
5. **Clear CTA**: Be explicit about what users get (e.g., "Start Free Trial")

## Mutable Properties

All properties are `public var`, so you can also modify them directly:

```swift
var config = PaywallConfiguration(productIDs: ["monthly", "annual"])
config.theme.accentColor = .purple
config.copy.title = "Go Pro"
config.privacyPolicy = .url(URL(string: "https://myapp.com/privacy")!)
```

## Need More Help?

Check the inline documentation in each configuration file or refer to the example implementations in the package.
