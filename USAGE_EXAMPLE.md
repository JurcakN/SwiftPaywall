# Real-World Usage Example

This shows exactly how you'd integrate and customize SwiftPaywall in your app.

## Step 1: Add Package to Your App

In Xcode:
1. File → Add Package Dependencies
2. Enter your package URL or local path
3. Add `SwiftPaywall` to your target

## Step 2: Create Your Paywall Configuration

Create a dedicated file in **your app** (not in the package):

```swift
// File: YourApp/Configuration/PaywallConfig.swift

import SwiftUI
import SwiftPaywall

struct AppPaywallConfig {
    
    // Your App Store product IDs
    static let productIDs = [
        "com.yourapp.subscription.monthly",
        "com.yourapp.subscription.annual"
    ]
    
    // Main configuration with your branding
    static var configuration: PaywallConfiguration {
        PaywallConfiguration(
            productIDs: productIDs,
            theme: customTheme,
            copy: customCopy,
            privacyPolicy: .url(URL(string: "https://yourapp.com/privacy")!),
            terms: .url(URL(string: "https://yourapp.com/terms")!)
        )
    }
    
    // Customize colors to match your brand
    private static var customTheme: PaywallTheme {
        PaywallTheme(
            accentColor: .indigo,                    // Your brand color
            backgroundColor: .black,
            primaryTextColor: .white,
            secondaryTextColor: .gray.opacity(0.8),
            cardBackgroundColor: .indigo.opacity(0.2),
            ctaTextColor: .white,
            cornerRadius: 20
        )
    }
    
    // Customize text to match your messaging
    private static var customCopy: PaywallCopy {
        PaywallCopy(
            title: "Unlock Premium",
            subtitle: "Get unlimited access to all features",
            ctaText: "Start 7-Day Free Trial",
            restoreText: "Already subscribed? Restore",
            cancelText: "Cancel anytime in App Store Settings",
            privacyText: "Privacy Policy",
            termsText: "Terms of Service",
            pendingText: "Purchase pending approval...",
            annualBadgeText: "Save 50%"
        )
    }
}
```

## Step 3: Show Paywall in Your Views

### Example A: Simple Sheet Presentation

```swift
// File: YourApp/Views/ContentView.swift

import SwiftUI
import SwiftPaywall

struct ContentView: View {
    @State private var showPaywall = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Your App")
                    .font(.largeTitle)
                
                Button("Upgrade to Premium") {
                    showPaywall = true
                }
                .buttonStyle(.borderedProminent)
            }
            .sheet(isPresented: $showPaywall) {
                PaywallView(configuration: AppPaywallConfig.configuration)
            }
        }
    }
}
```

### Example B: Full Screen Cover

```swift
import SwiftUI
import SwiftPaywall

struct HomeView: View {
    @State private var showPaywall = false
    
    var body: some View {
        ZStack {
            // Your main content
            ScrollView {
                // Your content here
            }
            
            // Show paywall button
            VStack {
                Spacer()
                Button("Go Premium") {
                    showPaywall = true
                }
            }
        }
        .fullScreenCover(isPresented: $showPaywall) {
            PaywallView(configuration: AppPaywallConfig.configuration)
        }
    }
}
```

### Example C: Conditional Based on Subscription Status

```swift
import SwiftUI
import SwiftPaywall

struct MainAppView: View {
    @StateObject private var entitlementManager = EntitlementManager()
    @State private var showPaywall = false
    
    var body: some View {
        Group {
            if entitlementManager.isSubscribed {
                // Premium content
                PremiumContentView()
            } else {
                // Free content with upgrade button
                FreeContentView(onUpgrade: { showPaywall = true })
            }
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView(configuration: AppPaywallConfig.configuration)
        }
        .task {
            await entitlementManager.refresh()
        }
    }
}
```

### Example D: Forced Paywall on Launch

```swift
import SwiftUI
import SwiftPaywall

@main
struct YourApp: App {
    @StateObject private var entitlementManager = EntitlementManager()
    
    var body: some Scene {
        WindowGroup {
            if entitlementManager.isSubscribed {
                MainAppView()
            } else {
                PaywallView(configuration: AppPaywallConfig.configuration)
            }
        }
    }
}
```

## Step 4: Quick Customization Without Config File

If you just want to quickly customize inline:

```swift
import SwiftUI
import SwiftPaywall

struct QuickPaywallView: View {
    var body: some View {
        PaywallView(
            configuration: PaywallConfiguration(
                productIDs: ["monthly", "annual"]
            )
            .withTheme(.dark.withAccentColor(.purple))
            .withCopy(
                PaywallCopy()
                    .withTitle("Go Pro")
                    .withCtaText("Subscribe Now")
            )
        )
    }
}
```

## Step 5: Multiple Paywall Configurations

You might want different paywalls for different contexts:

```swift
// File: YourApp/Configuration/PaywallConfigs.swift

import SwiftPaywall
import SwiftUI

enum PaywallConfigs {
    
    // Onboarding paywall (softer sell)
    static var onboarding: PaywallConfiguration {
        PaywallConfiguration(
            productIDs: ["monthly", "annual"]
        )
        .withCopy(
            PaywallCopy()
                .withTitle("Welcome!")
                .withSubtitle("Try premium free for 7 days")
                .withCtaText("Start Free Trial")
        )
        .withTheme(.dark.withAccentColor(.blue))
    }
    
    // Feature gate paywall (direct)
    static var featureGate: PaywallConfiguration {
        PaywallConfiguration(
            productIDs: ["monthly", "annual"]
        )
        .withCopy(
            PaywallCopy()
                .withTitle("Premium Feature")
                .withSubtitle("Upgrade to unlock this feature")
                .withCtaText("Upgrade Now")
        )
        .withTheme(.dark.withAccentColor(.red))
    }
    
    // Settings paywall (informative)
    static var settings: PaywallConfiguration {
        PaywallConfiguration(
            productIDs: ["monthly", "annual"]
        )
        .withCopy(
            PaywallCopy()
                .withTitle("Manage Subscription")
                .withSubtitle("Choose your premium plan")
                .withCtaText("Subscribe")
        )
        .withTheme(.light.withAccentColor(.green))
    }
}

// Usage:
PaywallView(configuration: PaywallConfigs.onboarding)
PaywallView(configuration: PaywallConfigs.featureGate)
PaywallView(configuration: PaywallConfigs.settings)
```

## Step 6: Dynamic Customization Based on User

```swift
import SwiftPaywall
import SwiftUI

struct DynamicPaywallView: View {
    let userPreferredColor: Color
    let isReturningUser: Bool
    
    var body: some View {
        PaywallView(configuration: configuration)
    }
    
    private var configuration: PaywallConfiguration {
        let baseConfig = PaywallConfiguration(
            productIDs: ["monthly", "annual"]
        )
        
        // Customize based on user context
        return baseConfig
            .withTheme(
                .dark.withAccentColor(userPreferredColor)
            )
            .withCopy(
                PaywallCopy()
                    .withTitle(isReturningUser ? "Welcome Back!" : "Get Started")
                    .withSubtitle(isReturningUser ? "Continue where you left off" : "Unlock all features")
            )
    }
}
```

## Step 7: Handling Paywall Dismissal

```swift
import SwiftUI
import SwiftPaywall

struct PaywallPresenterView: View {
    @State private var showPaywall = false
    @StateObject private var entitlementManager = EntitlementManager()
    
    var body: some View {
        Button("Show Paywall") {
            showPaywall = true
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView(configuration: AppPaywallConfig.configuration)
                .onDisappear {
                    // Refresh entitlements when paywall closes
                    Task {
                        await entitlementManager.refresh()
                        
                        if entitlementManager.isSubscribed {
                            // User purchased! Show success
                            showThankYouMessage()
                        }
                    }
                }
        }
    }
    
    private func showThankYouMessage() {
        // Your thank you UI
    }
}
```

## Complete Real-World Example

Here's a full app structure:

```swift
// YourApp/YourApp.swift
import SwiftUI
import SwiftPaywall

@main
struct YourApp: App {
    @StateObject private var entitlementManager = EntitlementManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(entitlementManager)
                .task {
                    await entitlementManager.refresh()
                }
        }
    }
}

// YourApp/Views/ContentView.swift
import SwiftUI
import SwiftPaywall

struct ContentView: View {
    @EnvironmentObject var entitlementManager: EntitlementManager
    @State private var showPaywall = false
    
    var body: some View {
        TabView {
            HomeTab()
                .tabItem { Label("Home", systemImage: "house") }
            
            SettingsTab(onShowPaywall: { showPaywall = true })
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView(configuration: AppPaywallConfig.configuration)
        }
    }
}

// YourApp/Views/HomeTab.swift
import SwiftUI

struct HomeTab: View {
    @EnvironmentObject var entitlementManager: EntitlementManager
    
    var body: some View {
        NavigationView {
            List {
                Section("Free Features") {
                    Text("Basic Feature 1")
                    Text("Basic Feature 2")
                }
                
                if entitlementManager.isSubscribed {
                    Section("Premium Features") {
                        Text("Premium Feature 1")
                        Text("Premium Feature 2")
                        Text("Premium Feature 3")
                    }
                }
            }
            .navigationTitle("Your App")
        }
    }
}

// YourApp/Views/SettingsTab.swift
import SwiftUI

struct SettingsTab: View {
    @EnvironmentObject var entitlementManager: EntitlementManager
    let onShowPaywall: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Subscription") {
                    if entitlementManager.isSubscribed {
                        Label("Premium Active", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        
                        Text(statusText)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        Button("Upgrade to Premium") {
                            onShowPaywall()
                        }
                    }
                }
                
                Section("Account") {
                    Button("Restore Purchases") {
                        Task {
                            await entitlementManager.refresh()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    private var statusText: String {
        switch entitlementManager.subscriptionState {
        case .active(let expiresOn):
            return "Renews \(expiresOn.formatted(date: .abbreviated, time: .omitted))"
        case .lifetime:
            return "Lifetime access"
        case .gracePeriod(let until):
            return "Grace period until \(until.formatted(date: .abbreviated, time: .omitted))"
        case .expired:
            return "Subscription expired"
        case .revoked:
            return "Subscription revoked"
        case .none:
            return "Not subscribed"
        }
    }
}

// YourApp/Configuration/AppPaywallConfig.swift
import SwiftUI
import SwiftPaywall

struct AppPaywallConfig {
    static var configuration: PaywallConfiguration {
        PaywallConfiguration(
            productIDs: ["com.yourapp.monthly", "com.yourapp.annual"],
            theme: PaywallTheme.dark.withAccentColor(.cyan),
            copy: PaywallCopy()
                .withTitle("Unlock Everything")
                .withCtaText("Start Free Trial"),
            privacyPolicy: .url(URL(string: "https://yourapp.com/privacy")!),
            terms: .url(URL(string: "https://yourapp.com/terms")!)
        )
    }
}
```

## Key Points

1. **Package stays untouched** - all customization in your app code
2. **Centralized config** - easy to maintain and change
3. **Reusable** - import same config across all views
4. **Type-safe** - compiler catches mistakes
5. **Flexible** - change colors, text, behavior without touching package

That's it! Your paywall is now fully customized and integrated into your app! 🎉
