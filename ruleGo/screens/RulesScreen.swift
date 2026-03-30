//
//  RulesScreen.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

private let brandBlue = Color(red: 0.2, green: 0.6, blue: 0.9)

// MARK: - Rules Screen

struct RulesScreen: View {
    @State private var searchText = ""
    @State private var selectedCategory: String = "All"
    @State private var rules: [Rule] = Rule.sampleRules
    @State private var selectedCountry: Country = Country.samples[0]
    
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
            Image("backgroundimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.01)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                RulesHeader(country: selectedCountry)
                
                VStack(spacing: 12) {
                    SearchBar(searchText: $searchText)
                    
                    CategoryTabsView(
                        categories: categories,
                        selectedCategory: $selectedCategory
                    )
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        if filteredRules.isEmpty {
                            EmptyStateView(searchText: searchText, selectedCategory: selectedCategory)
                        } else {
                            ForEach(filteredRules) { rule in
                                RuleDetailCard(
                                    rule: rule,
                                    onFavorite: { toggleFavorite(rule: rule) }
                                )
                            }
                        }
                        
                        Color.clear.frame(height: 100)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 4)
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
                .font(.system(size: 28))
                .frame(width: 44, height: 44)
                .background(Color(.systemBackground))
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(country.name)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Travel Rules & Regulations")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white.opacity(0.85))
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}

// MARK: - Search Bar

private struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15))
                .foregroundColor(Color(.systemGray2))
                .frame(width: 22)
            
            TextField("Search rules...", text: $searchText)
                .font(.system(size: 15))
                .foregroundColor(.primary)
                .autocapitalization(.none)
            
            if !searchText.isEmpty {
                Button(action: { 
                    withAnimation(.easeInOut(duration: 0.2)) {
                        searchText = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color(.systemGray3))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Category Tabs View

private struct CategoryTabsView: View {
    let categories: [String]
    @Binding var selectedCategory: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(categories, id: \.self) { category in
                    CategoryTab(
                        title: category,
                        isSelected: selectedCategory == category
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                            selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal, 2)
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
        default: return "square.grid.2x2"
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: categoryIcon)
                    .font(.system(size: 13, weight: .medium))
                
                Text(title)
                    .font(.system(size: 13, weight: isSelected ? .semibold : .medium))
            }
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(
                Group {
                    if isSelected {
                        LinearGradient(
                            colors: [
                                brandBlue,
                                Color(red: 0.1, green: 0.45, blue: 0.82)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    } else {
                        Color(.systemBackground)
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(
                color: isSelected ? brandBlue.opacity(0.3) : .black.opacity(0.08),
                radius: isSelected ? 8 : 4,
                x: 0,
                y: isSelected ? 4 : 2
            )
        }
    }
}

// MARK: - Rule Detail Card

private struct RuleDetailCard: View {
    let rule: Rule
    let onFavorite: () -> Void
    @State private var showShareSheet = false
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                    isExpanded.toggle()
                }
            }) {
                HStack(spacing: 14) {
                    Image(systemName: rule.icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(brandBlue)
                        .frame(width: 44, height: 44)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(rule.title)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                        
                        HStack(spacing: 6) {
                            Text(rule.category)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(brandBlue)
                            
                            if rule.fine != nil {
                                Text("•")
                                    .foregroundColor(Color(.systemGray3))
                                    .font(.system(size: 10))
                                
                                HStack(spacing: 3) {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(.system(size: 10))
                                    Text("Fine")
                                        .font(.system(size: 12, weight: .medium))
                                }
                                .foregroundColor(.red)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(.systemGray3))
                }
                .padding(16)
            }
            .buttonStyle(PlainButtonStyle())
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 14) {
                    Divider()
                        .padding(.horizontal, 16)
                    
                    Text(rule.description)
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemGray))
                        .lineSpacing(3)
                        .padding(.horizontal, 16)
                    
                    if let fine = rule.fine {
                        HStack(spacing: 10) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.red)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Penalty")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(Color(.systemGray2))
                                
                                Text(fine)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 16)
                    }
                    
                    if let tip = rule.tip {
                        HStack(spacing: 10) {
                            Image(systemName: "lightbulb.fill")
                                .font(.system(size: 13))
                                .foregroundColor(.orange)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Pro Tip")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(Color(.systemGray2))
                                
                                Text(tip)
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(.systemGray))
                            }
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.orange.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 16)
                    }
                    
                    HStack(spacing: 12) {
                        Button(action: onFavorite) {
                            HStack(spacing: 6) {
                                Image(systemName: rule.isFavorite ? "star.fill" : "star")
                                    .font(.system(size: 13))
                                Text(rule.isFavorite ? "Saved" : "Save")
                                    .font(.system(size: 13, weight: .medium))
                            }
                            .foregroundColor(rule.isFavorite ? .orange : Color(.systemGray))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 9)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                        Button(action: { showShareSheet = true }) {
                            HStack(spacing: 6) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 13))
                                Text("Share")
                                    .font(.system(size: 13, weight: .medium))
                            }
                            .foregroundColor(brandBlue)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 9)
                            .background(brandBlue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(text: rule.title)
        }
    }
}

// MARK: - Empty State View

private struct EmptyStateView: View {
    let searchText: String
    let selectedCategory: String
    
    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: searchText.isEmpty ? "tray" : "magnifyingglass")
                .font(.system(size: 56, weight: .light))
                .foregroundColor(brandBlue.opacity(0.6))
                .padding(.top, 40)
            
            VStack(spacing: 8) {
                Text(searchText.isEmpty ? "No Rules Found" : "No Results")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(searchText.isEmpty 
                    ? "There are no rules in the \(selectedCategory) category" 
                    : "Try adjusting your search or filters")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 50)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
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

