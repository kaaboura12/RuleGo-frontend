//
//  FavoritesPage.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

private let brandBlue = Color(red: 0.2, green: 0.6, blue: 0.9)

// MARK: - Favorites Page

struct FavoritesPage: View {
    @Environment(\.dismiss) private var dismiss
    @State private var favoriteRules: [Rule] = Rule.sampleRules.filter { $0.isFavorite }
    @State private var searchText = ""
    @State private var selectedCategory: String = "All"
    
    private var categories: [String] {
        var cats = ["All"]
        cats.append(contentsOf: Set(favoriteRules.map { $0.category }).sorted())
        return cats
    }
    
    private var filteredRules: [Rule] {
        var rules = favoriteRules
        
        if selectedCategory != "All" {
            rules = rules.filter { $0.category == selectedCategory }
        }
        
        if !searchText.isEmpty {
            rules = rules.filter { rule in
                rule.title.localizedCaseInsensitiveContains(searchText) ||
                rule.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return rules
    }
    
    var body: some View {
        ZStack {
            Image("backgroundimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.01)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                FavoritesHeader(favoriteCount: favoriteRules.count, onBack: { dismiss() })
                    .padding(.top, 8)
                
                if favoriteRules.isEmpty {
                    EmptyFavoritesView()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            SearchBar(searchText: $searchText)
                                .padding(.horizontal, 20)
                            
                            if categories.count > 2 {
                                CategoryFilterSection(
                                    categories: categories,
                                    selectedCategory: $selectedCategory
                                )
                            }
                            
                            if filteredRules.isEmpty {
                                NoSearchResultsView()
                                    .padding(.top, 60)
                            } else {
                                FavoritesListSection(
                                    rules: filteredRules,
                                    onUnfavorite: unfavoriteRule
                                )
                            }
                            
                            Color.clear.frame(height: 100)
                        }
                        .padding(.top, 12)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func unfavoriteRule(rule: Rule) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            favoriteRules.removeAll { $0.id == rule.id }
        }
    }
}

// MARK: - Favorites Header

private struct FavoritesHeader: View {
    let favoriteCount: Int
    let onBack: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.black.opacity(0.3))
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 2)
            }
            
            Image(systemName: "star.fill")
                .font(.system(size: 24))
                .foregroundColor(.yellow)
                .frame(width: 48, height: 48)
                .background(
                    LinearGradient(
                        colors: [Color.yellow.opacity(0.2), Color.orange.opacity(0.15)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .yellow.opacity(0.3), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("My Favorites")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
                
                Text("\(favoriteCount) saved \(favoriteCount == 1 ? "rule" : "rules")")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.85))
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}

// MARK: - Search Bar

private struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(.systemGray))
                .font(.system(size: 15, weight: .medium))
            
            TextField("Search favorites...", text: $searchText)
                .font(.system(size: 15))
                .foregroundColor(.primary)
            
            if !searchText.isEmpty {
                Button(action: { 
                    withAnimation(.easeInOut(duration: 0.2)) {
                        searchText = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(.systemGray3))
                        .font(.system(size: 16))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 6)
    }
}

// MARK: - Category Filter Section

private struct CategoryFilterSection: View {
    let categories: [String]
    @Binding var selectedCategory: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    CategoryFilterChip(
                        title: category,
                        isSelected: selectedCategory == category,
                        action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedCategory = category
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Category Filter Chip

private struct CategoryFilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .semibold : .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 9)
                .background(
                    isSelected ?
                    AnyView(
                        LinearGradient(
                            colors: [brandBlue, Color(red: 0.1, green: 0.45, blue: 0.82)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    ) :
                    AnyView(Color(.systemBackground))
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(
                    color: isSelected ? brandBlue.opacity(0.3) : .black.opacity(0.08),
                    radius: isSelected ? 8 : 6,
                    x: 0,
                    y: isSelected ? 4 : 3
                )
        }
    }
}

// MARK: - Favorites List Section

private struct FavoritesListSection: View {
    let rules: [Rule]
    let onUnfavorite: (Rule) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 10) {
                ForEach(rules) { rule in
                    FavoriteRuleCard(
                        rule: rule,
                        onUnfavorite: { onUnfavorite(rule) }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 20)
    }
}

// MARK: - Favorite Rule Card

private struct FavoriteRuleCard: View {
    let rule: Rule
    let onUnfavorite: () -> Void
    @State private var showShareSheet = false
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 14) {
                Image(systemName: rule.icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(brandBlue)
                    .frame(width: 44, height: 44)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(rule.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text(rule.category)
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(.systemGray3))
                        .frame(width: 28, height: 28)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 14) {
                    Text(rule.description)
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemGray))
                        .lineSpacing(3)
                        .padding(.top, 12)
                    
                    if let fine = rule.fine {
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.red)
                            
                            Text("Fine: \(fine)")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.red)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    if let tip = rule.tip {
                        HStack(spacing: 8) {
                            Image(systemName: "lightbulb.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.orange)
                            
                            Text(tip)
                                .font(.system(size: 13))
                                .foregroundColor(Color(.systemGray))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.orange.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    HStack(spacing: 12) {
                        Button(action: { showShareSheet = true }) {
                            HStack(spacing: 6) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 13))
                                Text("Share")
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .foregroundColor(brandBlue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(brandBlue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Button(action: onUnfavorite) {
                            HStack(spacing: 6) {
                                Image(systemName: "star.slash")
                                    .font(.system(size: 13))
                                Text("Remove")
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.red.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(text: rule.title)
        }
    }
}

// MARK: - Empty Favorites View

private struct EmptyFavoritesView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.yellow.opacity(0.15),
                                    Color.orange.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 120, height: 120)
                        .blur(radius: 20)
                    
                    Circle()
                        .fill(Color(.systemBackground))
                        .frame(width: 100, height: 100)
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                    
                    Image(systemName: "star.slash")
                        .font(.system(size: 44, weight: .medium))
                        .foregroundColor(Color(.systemGray2))
                }
                
                VStack(spacing: 10) {
                    Text("No Favorites Yet")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Start exploring rules and tap the star icon\nto save your favorites here.")
                        .font(.system(size: 15))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                
                Button(action: {}) {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Explore Rules")
                            .font(.system(size: 15, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(
                            colors: [brandBlue, Color(red: 0.1, green: 0.45, blue: 0.82)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: brandBlue.opacity(0.35), radius: 10, x: 0, y: 4)
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 40)
            .background(Color(.systemBackground).opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 30)
            
            Spacer()
            Spacer()
        }
    }
}

// MARK: - No Search Results View

private struct NoSearchResultsView: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color(.systemBackground))
                        .frame(width: 90, height: 90)
                        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 8)
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 38, weight: .medium))
                        .foregroundColor(Color(.systemGray2))
                }
                
                VStack(spacing: 8) {
                    Text("No Results Found")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Try adjusting your search or filter")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 36)
            .background(Color(.systemBackground).opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.12), radius: 16, x: 0, y: 8)
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    FavoritesPage()
}

