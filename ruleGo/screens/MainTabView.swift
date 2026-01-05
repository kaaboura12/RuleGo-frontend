//
//  MainTabView.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .home
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ZStack {
            // Content based on selected tab
            Group {
                switch selectedTab {
                case .home:
                    HomeScreen()
                case .rules:
                    RulesScreen()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Navigation Bar
            VStack {
                Spacer()
                NavBar(selectedTab: $selectedTab)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Home Content View

struct HomeContentView: View {
    var body: some View {
        ZStack {
            Image("backgroundimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome to Rule")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                + Text("Go")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color(red: 0.3, green: 0.85, blue: 0.4))
                
                Text("Your travel companion")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 8)
            }
        }
    }
}

// MARK: - Rules View

struct RulesView: View {
    var body: some View {
        ZStack {
            Image("backgroundimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Travel Rules")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                
                ScrollView {
                    VStack(spacing: 16) {
                        RulesViewCard(
                            icon: "checkmark.shield.fill",
                            title: "Safety First",
                            description: "Always keep your documents safe"
                        )
                        
                        RulesViewCard(
                            icon: "map.fill",
                            title: "Plan Ahead",
                            description: "Research your destination"
                        )
                        
                        RulesViewCard(
                            icon: "clock.fill",
                            title: "Be Punctual",
                            description: "Arrive early at airports"
                        )
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top, 60)
            .padding(.bottom, 100)
        }
    }
}

// MARK: - Rules View Card Component

private struct RulesViewCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(Color(red: 0.3, green: 0.85, blue: 0.4))
                .frame(width: 60, height: 60)
                .background(Color.white.opacity(0.9))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

// MARK: - Profile View

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundimage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 24) {
                // Profile Header
                VStack(spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                    
                    Text("Traveler")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("explorer@rulego.com")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 60)
                
                // Profile Options
                VStack(spacing: 12) {
                    // Settings with Navigation
                    NavigationLink(destination: SettingsPage()) {
                        HStack {
                            Image(systemName: "gear")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                                .frame(width: 40)
                            
                            Text("Settings")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                    }
                    
                    ProfileOption(icon: "bell.fill", title: "Notifications")
                    
                    // Favorites with Navigation
                    NavigationLink(destination: FavoritesPage()) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                                .frame(width: 40)
                            
                            Text("Favorites")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                    }
                    
                    // About with Navigation
                    NavigationLink(destination: AboutPage()) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                                .frame(width: 40)
                            
                            Text("About")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom, 100)
        }
        .navigationBarHidden(true)
        }
    }
}

// MARK: - Profile Option Component

struct ProfileOption: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                    .frame(width: 40)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(12)
        }
    }
}

#Preview {
    MainTabView()
}

