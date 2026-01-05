//
//  RulesScreen.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

// MARK: - Rules Screen

struct RulesScreen: View {
    @State private var searchText = ""
    @State private var selectedCategory: String = "All"
    @State private var rules: [Rule] = Rule.sampleRules
    @State private var selectedCountry: Country = Country.samples[0] // Turkey by default
    
    private let categories = ["All", "Smoking", "Driving", "Alcohol", "Dress Code", "Photography", "Cultural"]
    
    private var filteredRules: [Rule] {
        rules.filter { rule in
            let matchesSearch = searchText.isEmpty || 
                rule.title.localizedCaseInsensitiveContains(searchText) ||
                rule.description.localizedCaseInsensitiveContains(searchText)
            
            let matchesCategory = selectedCategory == "All" || rule.category == selectedCategory
            
            return matchesSearch && matchesCategory
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
                RulesHeader(country: selectedCountry)
                
                // Search Bar
                SearchBar(searchText: $searchText)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                
                // Category Tabs
                CategoryTabsView(
                    categories: categories,
                    selectedCategory: $selectedCategory
                )
                .padding(.bottom, 12)
                
                // Rules List
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredRules) { rule in
                            RuleDetailCard(
                                rule: rule,
                                onFavorite: { toggleFavorite(rule: rule) }
                            )
                        }
                        
                        // Empty state
                        if filteredRules.isEmpty {
                            EmptyStateView(searchText: searchText)
                        }
                        
                        // Bottom spacing for navbar
                        Color.clear.frame(height: 100)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                }
            }
        }
    }
    
    private func toggleFavorite(rule: Rule) {
        if let index = rules.firstIndex(where: { $0.id == rule.id }) {
            rules[index].isFavorite.toggle()
        }
    }
}

// MARK: - Rules Header

private struct RulesHeader: View {
    let country: Country
    
    var body: some View {
        HStack(spacing: 12) {
            Text(country.flag)
                .font(.system(size: 32))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(country.name) Rules")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Know before you go")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
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
            
            TextField("Search rules...", text: $searchText)
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

// MARK: - Category Tabs View

private struct CategoryTabsView: View {
    let categories: [String]
    @Binding var selectedCategory: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    CategoryTab(
                        title: category,
                        isSelected: selectedCategory == category
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Category Tab

private struct CategoryTab: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    private var categoryIcon: String {
        switch title {
        case "Smoking": return "smoke"
        case "Driving": return "car.fill"
        case "Alcohol": return "wineglass"
        case "Dress Code": return "tshirt"
        case "Photography": return "camera.fill"
        case "Cultural": return "building.columns"
        default: return "list.bullet"
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if title != "All" {
                    Image(systemName: categoryIcon)
                        .font(.system(size: 14, weight: .medium))
                }
                
                Text(title)
                    .font(.system(size: 14, weight: isSelected ? .semibold : .medium))
            }
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                isSelected 
                    ? Color(red: 0.2, green: 0.6, blue: 0.9)
                    : Color.white.opacity(0.95)
            )
            .cornerRadius(20)
            .shadow(
                color: isSelected 
                    ? Color(red: 0.2, green: 0.6, blue: 0.9).opacity(0.3)
                    : Color.black.opacity(0.05),
                radius: isSelected ? 8 : 4,
                x: 0,
                y: 2
            )
        }
    }
}

// MARK: - Rule Detail Card

private struct RuleDetailCard: View {
    let rule: Rule
    let onFavorite: () -> Void
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
                
                // Favorite Button
                Button(action: onFavorite) {
                    Image(systemName: rule.isFavorite ? "star.fill" : "star")
                        .font(.system(size: 20))
                        .foregroundColor(rule.isFavorite ? .yellow : .secondary)
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
                
                Button(action: {}) {
                    HStack(spacing: 6) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 14))
                        Text("Official Source")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.secondary)
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

// MARK: - Empty State View

private struct EmptyStateView: View {
    let searchText: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.secondary.opacity(0.5))
            
            Text(searchText.isEmpty ? "No rules in this category" : "No rules found")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            
            Text(searchText.isEmpty 
                ? "Try selecting a different category" 
                : "Try a different search term")
                .font(.system(size: 15))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}

// MARK: - Share Sheet

struct ShareSheet: UIViewControllerRepresentable {
    let text: String
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    RulesScreen()
}

