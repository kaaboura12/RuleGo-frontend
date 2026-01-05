//
//  CountrySelector.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

// MARK: - Country Selector Component

struct CountrySelector: View {
    @Binding var selectedCountry: Country?
    @State private var showingCountryList = false
    
    var body: some View {
        Button(action: { showingCountryList = true }) {
            HStack(spacing: 16) {
                // Globe Icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.2, green: 0.6, blue: 0.9).opacity(0.2),
                                    Color(red: 0.2, green: 0.6, blue: 0.9).opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: "globe.americas.fill")
                        .font(.system(size: 26))
                        .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                }
                
                // Text Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(selectedCountry?.name ?? "Select your destination")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(selectedCountry != nil ? "Tap to change" : "Choose a country to see rules")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Arrow or Flag
                if let country = selectedCountry {
                    Text(country.flag)
                        .font(.system(size: 32))
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                }
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
        }
        .sheet(isPresented: $showingCountryList) {
            CountryListView(selectedCountry: $selectedCountry)
        }
    }
}

// MARK: - Country List View

struct CountryListView: View {
    @Binding var selectedCountry: Country?
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    private var filteredCountries: [Country] {
        if searchText.isEmpty {
            return Country.samples
        }
        return Country.samples.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredCountries) { country in
                Button(action: {
                    selectedCountry = country
                    dismiss()
                }) {
                    HStack(spacing: 16) {
                        Text(country.flag)
                            .font(.system(size: 32))
                        
                        Text(country.name)
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if selectedCountry?.id == country.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .searchable(text: $searchText, prompt: "Search countries")
            .navigationTitle("Select Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CountrySelector(selectedCountry: .constant(nil))
        .padding()
        .background(Color.gray.opacity(0.1))
}

