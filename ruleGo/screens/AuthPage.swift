//
//  AuthPage.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

struct AuthPage: View {
    @State private var isLoginMode = true
    @State private var email = ""
    @State private var username = ""
    @State private var contactNumber = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    
    var body: some View {
        ZStack {
            // Background Image
            Image("backgroundimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            // Content
            VStack {
                Spacer()
                
                // Auth Card
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 12) {
                        Text("RuleGo")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                        
                        if !isLoginMode {
                            VStack(spacing: 4) {
                                Text("If you already have an account")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                
                                Button(action: {
                                    withAnimation(.spring()) {
                                        isLoginMode = true
                                    }
                                }) {
                                    Text("Login here!")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                                }
                            }
                        }
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 24)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        if isLoginMode {
                            // Login Form
                            CustomTextField(
                                placeholder: "Enter email or username",
                                text: $email
                            )
                            
                            CustomSecureField(
                                placeholder: "Password",
                                text: $password,
                                isVisible: $isPasswordVisible
                            )
                        } else {
                            // Sign Up Form
                            CustomTextField(
                                placeholder: "Enter Email",
                                text: $email
                            )
                            
                            CustomTextField(
                                placeholder: "Create Username",
                                text: $username
                            )
                            
                            CustomTextField(
                                placeholder: "Contact Number",
                                text: $contactNumber,
                                keyboardType: .phonePad
                            )
                            
                            CustomSecureField(
                                placeholder: "Password",
                                text: $password,
                                isVisible: $isPasswordVisible
                            )
                            
                            CustomSecureField(
                                placeholder: "Confirm Password",
                                text: $confirmPassword,
                                isVisible: $isConfirmPasswordVisible
                            )
                        }
                    }
                    .padding(.horizontal, 32)
                    
                    // Action Button
                    Button(action: handleAuth) {
                        Text(isLoginMode ? "Login" : "Sign Up")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(red: 0.2, green: 0.6, blue: 0.9))
                            .cornerRadius(25)
                            .shadow(color: Color(red: 0.2, green: 0.6, blue: 0.9).opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                    
                    // Switch Mode
                    if isLoginMode {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    isLoginMode = false
                                }
                            }) {
                                Text("Register here!")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.9))
                            }
                        }
                        .padding(.top, 16)
                    }
                    
                    // Social Login
                    VStack(spacing: 16) {
                        Text("or continue with")
                            .font(.system(size: 14))
                            .foregroundColor(.gray.opacity(0.7))
                        
                        HStack(spacing: 24) {
                            SocialLoginButton(icon: "logo.facebook", color: .blue)
                            SocialLoginButton(icon: "apple.logo", color: .black)
                            SocialLoginButton(icon: "g.circle.fill", color: .red)
                        }
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 32)
                }
                .background(Color.white)
                .cornerRadius(30)
                .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
    private func handleAuth() {
        // Handle authentication logic
        if isLoginMode {
            print("Login with email: \(email)")
        } else {
            print("Sign up with email: \(email), username: \(username)")
        }
    }
}

// MARK: - Custom TextField

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .font(.system(size: 16))
                .foregroundColor(.primary)
                .padding(.bottom, 8)
            
            Rectangle()
                .fill(Color(red: 0.2, green: 0.6, blue: 0.9).opacity(0.5))
                .frame(height: 1)
        }
    }
}

// MARK: - Custom Secure Field

struct CustomSecureField: View {
    let placeholder: String
    @Binding var text: String
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if isVisible {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                } else {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                }
                
                Button(action: { isVisible.toggle() }) {
                    Image(systemName: isVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray.opacity(0.6))
                }
            }
            .padding(.bottom, 8)
            
            Rectangle()
                .fill(Color(red: 0.2, green: 0.6, blue: 0.9).opacity(0.5))
                .frame(height: 1)
        }
    }
}

// MARK: - Social Login Button

struct SocialLoginButton: View {
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {
            // Handle social login
        }) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(color)
                .clipShape(Circle())
                .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    AuthPage()
}

