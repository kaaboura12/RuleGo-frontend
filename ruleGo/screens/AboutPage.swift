//
//  AboutPage.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

// MARK: - About Page

struct AboutPage: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Background Image
            Image("backgroundimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            // Overlay for better readability
            LinearGradient(
                colors: [
                    Color.black.opacity(0.4),
                    Color.black.opacity(0.2),
                    Color.clear
                ],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
            
            // Content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    // App Logo/Header
                    AppLogoSection()
                    
                    // About Section
                    AboutSection()
                    
                    // Features Section
                    FeaturesSection()
                    
                    // Version & Info
                    VersionInfoSection()
                    
                    // Legal Section
                    LegalSection()
                    
                    // Contact Section
                    ContactSection()
                    
                    // Spacing for bottom
                    Color.clear.frame(height: 40)
                }
                .padding(.top, 60)
                .padding(.horizontal, 24)
            }
            
            // Back Button
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(Color.black.opacity(0.3))
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                    .padding(20)
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - App Logo Section

private struct AppLogoSection: View {
    var body: some View {
        VStack(spacing: 16) {
            // App Icon Placeholder
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.2, green: 0.6, blue: 0.9),
                                Color(red: 0.3, green: 0.85, blue: 0.4)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                
                Text("Rule")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                + Text("GO")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0.3, green: 0.85, blue: 0.4))
            }
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            
            Text("Rule")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
            + Text("GO")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(Color(red: 0.3, green: 0.85, blue: 0.4))
            
            Text("Know the rules. Travel safely.")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
        }
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

// MARK: - About Section

private struct AboutSection: View {
    var body: some View {
        InfoCard(
            icon: "info.circle.fill",
            iconColor: Color(red: 0.2, green: 0.6, blue: 0.9),
            title: "About RuleGO",
            content: """
            RuleGO is your essential travel companion, providing you with important rules, regulations, and cultural norms for destinations worldwide.
            
            Stay informed, travel responsibly, and avoid unnecessary fines or misunderstandings by knowing the rules before you go.
            """
        )
    }
}

// MARK: - Features Section

private struct FeaturesSection: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Features")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            
            VStack(spacing: 12) {
                FeatureRow(icon: "globe.americas.fill", title: "Multiple Countries", description: "Access rules for destinations worldwide")
                FeatureRow(icon: "list.bullet.clipboard.fill", title: "Categorized Rules", description: "Easy-to-browse rule categories")
                FeatureRow(icon: "magnifyingglass", title: "Smart Search", description: "Find specific rules quickly")
                FeatureRow(icon: "star.fill", title: "Favorites", description: "Save important rules for quick access")
                FeatureRow(icon: "exclamationmark.triangle.fill", title: "Emergency Info", description: "Important contacts at your fingertips")
            }
        }
    }
}

// MARK: - Feature Row

private struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                .frame(width: 48, height: 48)
                .background(Color.white.opacity(0.95))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.white.opacity(0.95))
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Version Info Section

private struct VersionInfoSection: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Version")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Text("1.0.0")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text("Build")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Text("2026.01.05")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                }
            }
            .padding(20)
            .background(Color.white.opacity(0.95))
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
        }
    }
}

// MARK: - Legal Section

private struct LegalSection: View {
    var body: some View {
        InfoCard(
            icon: "doc.text.fill",
            iconColor: .orange,
            title: "Disclaimer",
            content: """
            Data sourced from official and trusted sources. RuleGO does not replace official government advice.
            
            Always verify current regulations with official authorities before traveling.
            
            We strive for accuracy but cannot guarantee completeness. Users are responsible for their own compliance with local laws.
            """
        )
    }
}

// MARK: - Contact Section

private struct ContactSection: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Contact & Support")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            
            VStack(spacing: 12) {
                ContactRow(icon: "envelope.fill", title: "Email", value: "support@rulego.app")
                ContactRow(icon: "globe", title: "Website", value: "www.rulego.app")
                ContactRow(icon: "message.fill", title: "Feedback", value: "feedback@rulego.app")
            }
        }
    }
}

// MARK: - Contact Row

private struct ContactRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                    .frame(width: 44, height: 44)
                    .background(Color.white.opacity(0.95))
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Text(value)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .background(Color.white.opacity(0.95))
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
        }
    }
}

// MARK: - Info Card Component

private struct InfoCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let content: String
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(iconColor)
                
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            Text(content)
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .lineSpacing(6)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .background(Color.white.opacity(0.95))
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
    }
}

#Preview {
    AboutPage()
}

