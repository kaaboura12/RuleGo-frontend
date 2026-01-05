//
//  SplashScreen.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ZStack {
            if !isActive {
                // Splash Screen
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    Image("ruleGosplash")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                }
            }
            
            if isActive {
                // Navigate to HomePage
                HomePage()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.none) {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}

