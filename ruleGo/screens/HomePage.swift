//
//  HomePage.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

struct HomePage: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ZStack {
            // Background Image
            Image("backgroundimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            // Content Layer
            VStack {
                Spacer()
                
                // Welcome Section
                VStack(spacing: 16) {
                    Text("Welcome to RuleGo")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    Text("Your travel companion")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                }
                .padding(.horizontal, 40)
                
                Spacer()
                Spacer()
                
                // Action Button
                NavigationButton(
                    title: "Get Started",
                    backgroundColor: Color(red: 0.2, green: 0.6, blue: 0.9),
                    action: {
                        // Navigate to main content
                    }
                )
                .padding(.horizontal, 40)
                .padding(.bottom, 60)
            }
        }
    }
}

// MARK: - Supporting Views

struct NavigationButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(backgroundColor)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    HomePage()
}

