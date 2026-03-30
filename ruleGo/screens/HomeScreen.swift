//
//  HomeScreen.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

private let brandBlue = Color(red: 0.2, green: 0.6, blue: 0.9)

// MARK: - Home Screen

struct HomeScreen: View {
    @State private var selectedCountry: Country?
    
    private var quickRules: [Rule] {
        guard selectedCountry != nil else { return [] }
        return [
            Rule(
                icon: "smoke",
                title: "Smoking Restrictions",
                description: "No smoking in public places",
                category: "Smoking",
                fine: "200 TRY",
                tip: nil
            ),
            Rule(
                icon: "wineglass",
                title: "Alcohol Rules",
                description: "Limited alcohol in public areas",
                category: "Alcohol",
                fine: "300 TRY",
                tip: nil
            ),
            Rule(
                icon: "creditcard",
                title: "Carry ID",
                description: "ID required at all times",
                category: "Cultural",
                fine: nil,
                tip: "Always keep ID with you"
            ),
            Rule(
                icon: "banknote",
                title: "Fines",
                description: "Heavy fines for littering",
                category: "Public Behavior",
                fine: "500 TRY",
                tip: "Use designated bins"
            )
        ]
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
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    HeaderSection()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Select Your Destination")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                        
                        CountrySelector(selectedCountry: $selectedCountry)
                            .padding(.horizontal, 20)
                    }
                    
                    if !quickRules.isEmpty {
                        QuickRulesSection(rules: quickRules, country: selectedCountry!)
                    }
                    
                    CategoriesSection()
                    
                    EmergencySection()
                    
                    FooterSection()
                    
                    Color.clear.frame(height: 100)
                }
                .padding(.top, 16)
            }
        }
    }
}

// MARK: - Header Section

private struct HeaderSection: View {
    var body: some View {
        HStack(spacing: 12) {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 52, height: 52)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            
            Text("Welcome back")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
    }
}

// MARK: - Quick Rules Section

private struct QuickRulesSection: View {
    let rules: [Rule]
    let country: Country
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    Text(country.flag)
                        .font(.system(size: 24))
                    
                    Text(country.name)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack(spacing: 10) {
                    ForEach(rules) { rule in
                        RuleCard(rule: rule)
                    }
                }
                .padding(.horizontal, 20)
                
                Button(action: {}) {
                    HStack(spacing: 8) {
                        Text("View All Rules")
                            .font(.system(size: 15, weight: .semibold))
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(
                            colors: [
                                brandBlue,
                                Color(red: 0.1, green: 0.45, blue: 0.82)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: brandBlue.opacity(0.35), radius: 10, x: 0, y: 4)
                }
                .padding(.horizontal, 20)
                .padding(.top, 6)
                .padding(.bottom, 20)
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Rule Card Component

private struct RuleCard: View {
    let rule: Rule
    
    var body: some View {
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
                
                Text(rule.description)
                    .font(.system(size: 13))
                    .foregroundColor(Color(.systemGray))
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(.systemGray3))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Categories Section

private struct CategoriesSection: View {
    private let categories = RuleCategory.categories
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Browse by Category")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(categories) { category in
                        CategoryCard(category: category)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Category Card Component

private struct CategoryCard: View {
    let category: RuleCategory
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 10) {
                Image(systemName: category.icon)
                    .font(.system(size: 26, weight: .medium))
                    .foregroundColor(brandBlue)
                    .frame(width: 50, height: 50)
                    .background(brandBlue.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(category.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }
}

// MARK: - Emergency Section

private struct EmergencySection: View {
    private let contacts = EmergencyContact.defaultContacts
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.red)
                    
                    Text("Emergency Contacts")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                VStack(spacing: 10) {
                    ForEach(contacts, id: \.number) { contact in
                        EmergencyContactCard(contact: contact)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Emergency Contact Card

private struct EmergencyContactCard: View {
    let contact: EmergencyContact
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: contact.icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.red)
                .frame(width: 44, height: 44)
                .background(Color.red.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 3) {
                Text(contact.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(contact.number)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(.systemGray))
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "phone.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .frame(width: 38, height: 38)
                    .background(
                        LinearGradient(
                            colors: [.red, Color.red.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .red.opacity(0.3), radius: 6, x: 0, y: 3)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Footer Section

private struct FooterSection: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 13))
                    .foregroundColor(brandBlue)
                
                Text("Data sourced from official and trusted sources")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(.systemGray))
            }
            
            HStack(spacing: 6) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 13))
                    .foregroundColor(.orange)
                
                Text("RuleGO does not replace official government advice")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(.systemGray))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 6)
        .padding(.horizontal, 20)
    }
}

#Preview {
    HomeScreen()
}

