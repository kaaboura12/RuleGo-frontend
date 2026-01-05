//
//  SettingsPage.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

// MARK: - Settings Page

struct SettingsPage: View {
    @Environment(\.dismiss) private var dismiss
    @State private var notificationsEnabled = true
    @State private var emailNotifications = false
    @State private var pushNotifications = true
    
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
                    Color.black.opacity(0.3),
                    Color.black.opacity(0.1),
                    Color.clear
                ],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
            
            // Content
            VStack(spacing: 0) {
                // Header
                SettingsHeader()
                
                // Settings Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Account Section
                        AccountSection()
                        
                        // Notifications Section
                        NotificationsSection(
                            notificationsEnabled: $notificationsEnabled,
                            emailNotifications: $emailNotifications,
                            pushNotifications: $pushNotifications
                        )
                        
                        // Privacy & Security
                        PrivacySection()
                        
                        // Support Section
                        SupportSection()
                        
                        // App Info
                        AppInfoSection()
                        
                        // Logout Button
                        LogoutButton()
                        
                        // Bottom spacing
                        Color.clear.frame(height: 40)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                }
            }
            
            // Back Button
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.3))
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 2)
                    }
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Settings Header

private struct SettingsHeader: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 28))
                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Settings")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Customize your experience")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
        .padding(.top, 40)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Account Section

private struct AccountSection: View {
    var body: some View {
        SettingsSection(title: "Account", icon: "person.circle.fill") {
            VStack(spacing: 12) {
                SettingsRow(
                    icon: "person.fill",
                    iconColor: .blue,
                    title: "Profile",
                    subtitle: "Manage your profile information"
                )
                
                SettingsRow(
                    icon: "envelope.fill",
                    iconColor: .green,
                    title: "Email",
                    subtitle: "user@example.com"
                )
                
                SettingsRow(
                    icon: "lock.fill",
                    iconColor: .orange,
                    title: "Change Password",
                    subtitle: "Update your password"
                )
            }
        }
    }
}

// MARK: - Notifications Section

private struct NotificationsSection: View {
    @Binding var notificationsEnabled: Bool
    @Binding var emailNotifications: Bool
    @Binding var pushNotifications: Bool
    
    var body: some View {
        SettingsSection(title: "Notifications", icon: "bell.fill") {
            VStack(spacing: 12) {
                SettingsToggle(
                    icon: "bell.badge.fill",
                    iconColor: .red,
                    title: "Enable Notifications",
                    subtitle: "Receive important updates",
                    isOn: $notificationsEnabled
                )
                
                if notificationsEnabled {
                    SettingsToggle(
                        icon: "envelope.badge.fill",
                        iconColor: .purple,
                        title: "Email Notifications",
                        subtitle: "Get updates via email",
                        isOn: $emailNotifications
                    )
                    
                    SettingsToggle(
                        icon: "app.badge.fill",
                        iconColor: .blue,
                        title: "Push Notifications",
                        subtitle: "Real-time alerts",
                        isOn: $pushNotifications
                    )
                }
            }
        }
    }
}

// MARK: - Privacy Section

private struct PrivacySection: View {
    var body: some View {
        SettingsSection(title: "Privacy & Security", icon: "lock.shield.fill") {
            VStack(spacing: 12) {
                SettingsRow(
                    icon: "hand.raised.fill",
                    iconColor: .purple,
                    title: "Privacy Policy",
                    subtitle: "Read our privacy policy"
                )
                
                SettingsRow(
                    icon: "doc.text.fill",
                    iconColor: .orange,
                    title: "Terms of Service",
                    subtitle: "View terms and conditions"
                )
                
                SettingsRow(
                    icon: "eye.slash.fill",
                    iconColor: .red,
                    title: "Data Privacy",
                    subtitle: "Control your data"
                )
            }
        }
    }
}

// MARK: - Support Section

private struct SupportSection: View {
    var body: some View {
        SettingsSection(title: "Support", icon: "questionmark.circle.fill") {
            VStack(spacing: 12) {
                SettingsRow(
                    icon: "message.fill",
                    iconColor: .blue,
                    title: "Contact Support",
                    subtitle: "Get help from our team"
                )
                
                SettingsRow(
                    icon: "star.fill",
                    iconColor: .yellow,
                    title: "Rate App",
                    subtitle: "Share your feedback"
                )
                
                SettingsRow(
                    icon: "exclamationmark.bubble.fill",
                    iconColor: .orange,
                    title: "Report a Problem",
                    subtitle: "Help us improve"
                )
            }
        }
    }
}

// MARK: - App Info Section

private struct AppInfoSection: View {
    var body: some View {
        SettingsSection(title: "App Information", icon: "info.circle.fill") {
            VStack(spacing: 12) {
                HStack {
                    Text("Version")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                Divider()
                    .padding(.horizontal, 16)
                
                HStack {
                    Text("Build")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("2026.01.05")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
        }
    }
}

// MARK: - Logout Button

private struct LogoutButton: View {
    @State private var showLogoutAlert = false
    
    var body: some View {
        Button(action: { showLogoutAlert = true }) {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 18, weight: .semibold))
                
                Text("Logout")
                    .font(.system(size: 17, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.red)
            .cornerRadius(14)
            .shadow(color: .red.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .alert("Logout", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Logout", role: .destructive) {
                // Handle logout
            }
        } message: {
            Text("Are you sure you want to logout?")
        }
    }
}

// MARK: - Settings Section Component

private struct SettingsSection<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section Header
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 4)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            
            // Section Content
            VStack(spacing: 0) {
                content
            }
            .background(Color.white.opacity(0.95))
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
        }
    }
}

// MARK: - Settings Row Component

private struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    var showChevron: Bool = true
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                // Icon
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(iconColor)
                    .frame(width: 36, height: 36)
                    .background(iconColor.opacity(0.15))
                    .cornerRadius(8)
                
                // Text Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Chevron
                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary.opacity(0.5))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Settings Toggle Component

private struct SettingsToggle: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(iconColor)
                .frame(width: 36, height: 36)
                .background(iconColor.opacity(0.15))
                .cornerRadius(8)
            
            // Text Content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Toggle
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Color(red: 0.2, green: 0.6, blue: 0.9))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    SettingsPage()
}

