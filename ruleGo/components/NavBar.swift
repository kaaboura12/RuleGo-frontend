//
//  NavBar.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

// MARK: - Tab Item Model

enum TabItem: String, CaseIterable {
    case home = "Home"
    case rules = "Rules"
    case profile = "Profile"
    
    var unselectedIcon: String {
        switch self {
        case .home: return "house"
        case .rules: return "list.bullet.clipboard"
        case .profile: return "person"
        }
    }
    
    var selectedIcon: String {
        switch self {
        case .home: return "house.fill"
        case .rules: return "list.bullet.clipboard.fill"
        case .profile: return "person.fill"
        }
    }
}

// MARK: - NavBar Component

struct NavBar: View {
    @Binding var selectedTab: TabItem
    @Namespace private var animation
    
    // Design Constants
    private let activeBlue = Color(red: 0.2, green: 0.6, blue: 0.9)
    private let barCornerRadius: CGFloat = 22
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                TabButton(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    accentColor: activeBlue,
                    namespace: animation
                ) {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: barCornerRadius, style: .continuous))
        .overlay(alignment: .top) {
            // iOS-style soft highlight that makes the glass feel "real"
            RoundedRectangle(cornerRadius: barCornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.55),
                            Color.white.opacity(0.14),
                            Color.clear
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .blendMode(.overlay)
                .allowsHitTesting(false)
        }
        .overlay {
            // Hairline border (modern iOS glass)
            RoundedRectangle(cornerRadius: barCornerRadius, style: .continuous)
                .stroke(Color.white.opacity(0.22), lineWidth: 0.75)
                .allowsHitTesting(false)
        }
        .shadow(color: .black.opacity(0.10), radius: 18, x: 0, y: 10)
        .shadow(color: .black.opacity(0.04), radius: 6, x: 0, y: 2)
        .padding(.horizontal, 32)
        .padding(.bottom, 20)
    }
}

// MARK: - Tab Button Component

private struct TabButton: View {
    let tab: TabItem
    let isSelected: Bool
    let accentColor: Color
    let namespace: Namespace.ID
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // Active background (tinted glass, not a flat block)
                if isSelected {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(accentColor.opacity(0.18))
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay {
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(accentColor.opacity(0.28), lineWidth: 1)
                        }
                        .shadow(color: accentColor.opacity(0.16), radius: 10, x: 0, y: 4)
                        .matchedGeometryEffect(id: "TAB_ACTIVE", in: namespace)
                }
                
                // Icon only
                Image(systemName: isSelected ? tab.selectedIcon : tab.unselectedIcon)
                    .font(.system(size: 19, weight: isSelected ? .semibold : .regular))
                    .foregroundStyle(isSelected ? AnyShapeStyle(accentColor) : AnyShapeStyle(.secondary.opacity(0.55)))
                    .scaleEffect(isSelected ? 1.06 : 1.0)
                    .animation(.easeInOut(duration: 0.18), value: isSelected)
            }
            .frame(width: 50, height: 36)
            .padding(.vertical, 4) // keeps tappable height comfortable without looking tall
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PressableButtonStyle())
    }
}

// MARK: - Pressable Button Style

private struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview {
    VStack {
        Spacer()
        NavBar(selectedTab: .constant(.home))
    }
    .background(
        LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
}

