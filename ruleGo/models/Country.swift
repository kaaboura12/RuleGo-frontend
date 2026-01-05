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
    let category: String
    let fine: String?
    let tip: String?
    var isFavorite: Bool = false
    
    static let sampleRules: [Rule] = [
        Rule(
            icon: "smoke",
            title: "No Smoking in Public Indoor Spaces",
            description: "Smoking is prohibited in all indoor public areas including restaurants, cafes, and shopping malls.",
            category: "Smoking",
            fine: "200 TRY",
            tip: "Some outdoor areas in malls are also restricted.",
            isFavorite: true
        ),
        Rule(
            icon: "car.fill",
            title: "Speed Limits on Highways",
            description: "Maximum speed limit is 120 km/h on highways and 90 km/h on rural roads.",
            category: "Driving",
            fine: "500-1000 TRY",
            tip: "Speed cameras are common. Always check road signs.",
            isFavorite: true
        ),
        Rule(
            icon: "wineglass",
            title: "Alcohol Consumption Laws",
            description: "Drinking alcohol in public parks and streets is prohibited. Only allowed in licensed venues.",
            category: "Alcohol",
            fine: "300 TRY",
            tip: "Always consume responsibly and check venue licenses."
        ),
        Rule(
            icon: "tshirt",
            title: "Dress Code at Religious Sites",
            description: "When visiting mosques, women should cover their heads and everyone should remove shoes.",
            category: "Dress Code",
            fine: nil,
            tip: "Carry a scarf if you plan to visit religious sites.",
            isFavorite: true
        ),
        Rule(
            icon: "camera.fill",
            title: "Photography Restrictions",
            description: "Photography is restricted at military installations and some government buildings.",
            category: "Photography",
            fine: "Detention possible",
            tip: "Always ask permission before photographing people."
        ),
        Rule(
            icon: "building.columns",
            title: "Respect Cultural Norms",
            description: "Public displays of affection should be modest. Be respectful in traditional areas.",
            category: "Cultural",
            fine: nil,
            tip: "Follow local customs to show respect."
        ),
        Rule(
            icon: "car.circle",
            title: "Seat Belt Required",
            description: "All passengers must wear seat belts. Children under 12 must use appropriate car seats.",
            category: "Driving",
            fine: "200 TRY per person",
            tip: "Check car seat availability when renting."
        ),
        Rule(
            icon: "pedestrian.gate.closed",
            title: "Pedestrian Crossings",
            description: "Always use designated pedestrian crossings. Jaywalking is prohibited.",
            category: "Driving",
            fine: "100 TRY",
            tip: "Wait for the green light even if roads appear clear."
        )
    ]
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

