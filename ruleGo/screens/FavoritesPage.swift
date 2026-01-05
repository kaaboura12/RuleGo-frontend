//
//  FavoritesPage.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

// MARK: - Favorites Page

struct FavoritesPage: View {
    @Environment(\.dismiss) private var dismiss
    @State private var favoriteRules: [Rule] = Rule.sampleRules.filter { $0.isFavorite }
    @State private var searchText = ""
    
    private var filteredRules: [Rule] {
        if searchText.isEmpty {
            return favoriteRules
        }
        return favoriteRules.filter { rule in
            rule.title.localizedCaseInsensitiveContains(searchText) ||
            rule.description.localizedCaseInsensitiveContains(searchText)
        }
    }
    
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
                FavoritesHeader()
                
                // Search Bar
                if !favoriteRules.isEmpty {
                    SearchBar(searchText: $searchText)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                }
                
                // Rules List or Empty State
                if favoriteRules.isEmpty {
                    EmptyFavoritesView()
                } else if filteredRules.isEmpty {
                    NoSearchResultsView()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredRules) { rule in
                                FavoriteRuleCard(
                                    rule: rule,
                                    onUnfavorite: { unfavoriteRule(rule: rule) }
                                )
                            }
                            
                            // Bottom spacing
                            Color.clear.frame(height: 40)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                    }
                }
                
                Spacer()
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
    
    private func unfavoriteRule(rule: Rule) {
        withAnimation {
            favoriteRules.removeAll { $0.id == rule.id }
        }
    }
}

// MARK: - Favorites Header

private struct FavoritesHeader: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "star.fill")
                .font(.system(size: 28))
                .foregroundColor(.yellow)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Favorites")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Your saved rules")
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

// MARK: - Search Bar

private struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .font(.system(size: 16))
            
            TextField("Search favorites...", text: $searchText)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .font(.system(size: 16))
                }
            }
        }
        .padding(14)
        .background(Color.white.opacity(0.95))
        .background(.ultraThinMaterial)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Favorite Rule Card

private struct FavoriteRuleCard: View {
    let rule: Rule
    let onUnfavorite: () -> Void
    @State private var showShareSheet = false
    
    private var categoryColor: Color {
        switch rule.category {
        case "Smoking": return .red
        case "Driving": return .blue
        case "Alcohol": return .purple
        case "Dress Code": return .pink
        case "Photography": return .orange
        case "Cultural": return .green
        default: return .gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with Icon and Title
            HStack(spacing: 12) {
                // Icon
                Image(systemName: rule.icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(categoryColor)
                    .frame(width: 48, height: 48)
                    .background(categoryColor.opacity(0.15))
                    .cornerRadius(12)
                
                // Title and Category
                VStack(alignment: .leading, spacing: 4) {
                    Text(rule.title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text(rule.category)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(categoryColor)
                }
                
                Spacer()
                
                // Unfavorite Button
                Button(action: onUnfavorite) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.yellow)
                }
            }
            
            // Description
            Text(rule.description)
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .lineSpacing(4)
            
            // Fine (if exists)
            if let fine = rule.fine {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                    
                    Text("Fine: \(fine)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.red)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
            }
            
            // Tip (if exists)
            if let tip = rule.tip {
                HStack(spacing: 8) {
                    Image(systemName: "lightbulb.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.orange)
                    
                    Text(tip)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(8)
            }
            
            // Actions
            HStack(spacing: 16) {
                Button(action: { showShareSheet = true }) {
                    HStack(spacing: 6) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 14))
                        Text("Share")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                }
                
                Spacer()
                
                Button(action: onUnfavorite) {
                    HStack(spacing: 6) {
                        Image(systemName: "star.slash")
                            .font(.system(size: 14))
                        Text("Remove")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .padding(20)
        .background(Color.white.opacity(0.95))
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(text: rule.title)
        }
    }
}

// MARK: - Empty Favorites View

private struct EmptyFavoritesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "star.slash")
                    .font(.system(size: 56))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Text("No Favorites Yet")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            
            Text("Start exploring rules and tap the star icon to save your favorites here.")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 48)
            
            Spacer()
            Spacer()
        }
    }
}

// MARK: - No Search Results View

private struct NoSearchResultsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.white.opacity(0.5))
            
            Text("No Results Found")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
            
            Text("Try a different search term")
                .font(.system(size: 15))
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
            Spacer()
        }
        .padding(.top, 60)
    }
}

#Preview {
    FavoritesPage()
}

