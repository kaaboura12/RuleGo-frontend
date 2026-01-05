//
//  HomeScreen.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

// MARK: - Home Screen

struct HomeScreen: View {
    @State private var selectedCountry: Country?
    
    // Sample data for selected country
    private var quickRules: [Rule] {
        guard selectedCountry != nil else { return [] }
        return [
            Rule(icon: "smoke", title: "Smoking Restrictions", description: "No smoking in public places"),
            Rule(icon: "wineglass", title: "Alcohol Rules", description: "Limited alcohol in public areas"),
            Rule(icon: "creditcard", title: "Carry ID", description: "ID required at all times"),
            Rule(icon: "banknote", title: "Fines", description: "Heavy fines for littering")
        ]
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
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header Section
                    HeaderSection()
                    
                    // Country Selector
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Destination")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                        
                        CountrySelector(selectedCountry: $selectedCountry)
                            .padding(.horizontal, 24)
                    }
                    
                    // Quick Rules Preview
                    if !quickRules.isEmpty {
                        QuickRulesSection(rules: quickRules, country: selectedCountry!)
                    }
                    
                    // Categories Section
                    CategoriesSection()
                    
                    // Emergency Section
                    EmergencySection()
                    
                    // Footer
                    FooterSection()
                    
                    // Bottom spacing for navbar
                    Color.clear.frame(height: 100)
                }
                .padding(.top, 20)
            }
        }
    }
}

// MARK: - Header Section

private struct HeaderSection: View {
    var body: some View {
        VStack(spacing: 8) {
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
        .padding(.vertical, 12)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Quick Rules Section

private struct QuickRulesSection: View {
    let rules: [Rule]
    let country: Country
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Header
            HStack {
                Text("Quick Rules - \(country.flag) \(country.name)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                
                Spacer()
            }
            .padding(.horizontal, 24)
            
            // Rules Cards
            VStack(spacing: 12) {
                ForEach(rules) { rule in
                    RuleCard(rule: rule)
                }
            }
            .padding(.horizontal, 24)
            
            // View All Button
            Button(action: {}) {
                HStack {
                    Text("View all rules")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(red: 0.2, green: 0.6, blue: 0.9).opacity(0.1))
                .cornerRadius(14)
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Rule Card Component

private struct RuleCard: View {
    let rule: Rule
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            Image(systemName: rule.icon)
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                .frame(width: 48, height: 48)
                .background(Color.white.opacity(0.95))
                .cornerRadius(12)
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(rule.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(rule.description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.secondary.opacity(0.5))
        }
        .padding(16)
        .background(Color.white.opacity(0.95))
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
    }
}

// MARK: - Categories Section

private struct CategoriesSection: View {
    private let categories = RuleCategory.categories
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Browse by Category")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                .padding(.horizontal, 24)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(categories) { category in
                    CategoryCard(category: category)
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Category Card Component

private struct CategoryCard: View {
    let category: RuleCategory
    
    private var categoryColor: Color {
        switch category.color {
        case "red": return .red
        case "blue": return .blue
        case "purple": return .purple
        case "pink": return .pink
        case "orange": return .orange
        case "green": return .green
        default: return .gray
        }
    }
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 12) {
                Image(systemName: category.icon)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(categoryColor)
                
                Text(category.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .background(Color.white.opacity(0.95))
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
        }
    }
}

// MARK: - Emergency Section

private struct EmergencySection: View {
    private let contacts = EmergencyContact.defaultContacts
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                
                Text("Emergency Contacts")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
            .padding(.horizontal, 24)
            
            VStack(spacing: 12) {
                ForEach(contacts, id: \.number) { contact in
                    EmergencyContactCard(contact: contact)
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Emergency Contact Card

private struct EmergencyContactCard: View {
    let contact: EmergencyContact
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: contact.icon)
                .font(.system(size: 20))
                .foregroundColor(.red)
                .frame(width: 44, height: 44)
                .background(Color.red.opacity(0.1))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(contact.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(contact.number)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "phone.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.95))
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
    }
}

// MARK: - Footer Section

private struct FooterSection: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("📚 Data sourced from official and trusted sources")
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
            
            Text("⚠️ RuleGO does not replace official government advice")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 20)
        .background(Color.black.opacity(0.2))
        .cornerRadius(16)
        .padding(.horizontal, 24)
    }
}

#Preview {
    HomeScreen()
}

