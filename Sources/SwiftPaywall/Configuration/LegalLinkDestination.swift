//
//  LegalLinkDestination.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import SwiftUI

public enum LegalLinkDestination: @unchecked Sendable {
    case url(URL)
    case sheet(AnyView)
    case none
}
