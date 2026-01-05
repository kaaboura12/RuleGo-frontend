//
//  Country.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import Foundation

// MARK: - Country Model

struct Country: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let flag: String
    let code: String
    
    static let samples: [Country] = [
        Country(name: "Turkey", flag: "🇹🇷", code: "TR"),
        Country(name: "Tunisia", flag: "🇹🇳", code: "TN"),
        Country(name: "France", flag: "🇫🇷", code: "FR"),
        Country(name: "Spain", flag: "🇪🇸", code: "ES"),
        Country(name: "Italy", flag: "🇮🇹", code: "IT"),
        Country(name: "Germany", flag: "🇩🇪", code: "DE"),
        Country(name: "United Kingdom", flag: "🇬🇧", code: "GB"),
        Country(name: "United States", flag: "🇺🇸", code: "US")
    ]
}

// MARK: - Rule Model

struct Rule: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
}

// MARK: - Rule Category Model

struct RuleCategory: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let color: String
    
    static let categories: [RuleCategory] = [
        RuleCategory(icon: "smoke", title: "Smoking", color: "red"),
        RuleCategory(icon: "car.fill", title: "Driving", color: "blue"),
        RuleCategory(icon: "wineglass", title: "Alcohol", color: "purple"),
        RuleCategory(icon: "tshirt", title: "Dress Code", color: "pink"),
        RuleCategory(icon: "camera.fill", title: "Photography", color: "orange"),
        RuleCategory(icon: "building.columns", title: "Cultural", color: "green")
    ]
}

// MARK: - Emergency Contact Model

struct EmergencyContact {
    let icon: String
    let title: String
    let number: String
    
    static let defaultContacts: [EmergencyContact] = [
        EmergencyContact(icon: "phone.fill", title: "Emergency", number: "112"),
        EmergencyContact(icon: "shield.fill", title: "Police", number: "155"),
        EmergencyContact(icon: "cross.fill", title: "Medical", number: "911")
    ]
}

