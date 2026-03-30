//
//  AuthPage.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

private let brandBlue = Color(red: 0.2, green: 0.6, blue: 0.9)

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

            Color.black.opacity(0.01)
                .edgesIgnoringSafeArea(.all)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // MARK: Logo & Brand
                    VStack(spacing: 8) {
                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                            .shadow(color: .black.opacity(0.3), radius: 14, x: 0, y: 6)

                        Text("Know the rules. Go anywhere.")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.white.opacity(0.82))
                            .tracking(0.4)
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 14)

                    // MARK: Auth Card
                    VStack(spacing: 0) {

                        // Tab Selector
                        HStack(spacing: 0) {
                            AuthTabButton(title: "Sign In", isSelected: isLoginMode) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                    isLoginMode = true
                                }
                            }
                            AuthTabButton(title: "Sign Up", isSelected: !isLoginMode) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                    isLoginMode = false
                                }
                            }
                        }
                        .padding(4)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .padding(.horizontal, 24)
                        .padding(.top, 28)

                        // Form Fields
                        VStack(spacing: 14) {
                            if isLoginMode {
                                AuthInputField(
                                    icon: "envelope",
                                    placeholder: "Email or username",
                                    text: $email,
                                    keyboardType: .emailAddress
                                )
                                AuthSecureField(
                                    icon: "lock",
                                    placeholder: "Password",
                                    text: $password,
                                    isVisible: $isPasswordVisible
                                )

                                HStack {
                                    Spacer()
                                    NavigationLink(destination: ForgotPasswordPage()) {
                                        Text("Forgot password?")
                                            .font(.system(size: 13, weight: .medium))
                                            .foregroundColor(brandBlue)
                                    }
                                }
                                .padding(.top, 2)

                            } else {
                                AuthInputField(
                                    icon: "envelope",
                                    placeholder: "Email address",
                                    text: $email,
                                    keyboardType: .emailAddress
                                )
                                AuthInputField(
                                    icon: "person",
                                    placeholder: "Username",
                                    text: $username
                                )
                                AuthInputField(
                                    icon: "phone",
                                    placeholder: "Phone number",
                                    text: $contactNumber,
                                    keyboardType: .phonePad
                                )
                                AuthSecureField(
                                    icon: "lock",
                                    placeholder: "Password",
                                    text: $password,
                                    isVisible: $isPasswordVisible
                                )
                                AuthSecureField(
                                    icon: "checkmark.shield",
                                    placeholder: "Confirm password",
                                    text: $confirmPassword,
                                    isVisible: $isConfirmPasswordVisible
                                )
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)

                        // Primary CTA Button
                        Button(action: handleAuth) {
                            Text(isLoginMode ? "Sign In" : "Create Account")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
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
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                .shadow(color: brandBlue.opacity(0.45), radius: 12, x: 0, y: 6)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)

                        // Divider
                        HStack(spacing: 12) {
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .frame(height: 1)
                            Text("or continue with")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(.systemGray2))
                                .fixedSize()
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .frame(height: 1)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)

                        // Social Auth Buttons
                        HStack(spacing: 14) {
                            SocialAuthButton(
                                imageName: "apple-logo",
                                label: "Apple",
                                isTemplate: true,
                                backgroundColor: Color(.label),
                                labelColor: Color(.systemBackground)
                            ) {
                                // Handle Apple Sign In
                            }

                            SocialAuthButton(
                                imageName: "google",
                                label: "Google",
                                isTemplate: false,
                                backgroundColor: Color(.systemBackground),
                                labelColor: Color(.label),
                                hasBorder: true
                            ) {
                                // Handle Google Sign In
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 16)

                        // Guest / Demo
                        NavigationLink(destination: MainTabView()) {
                            Text("Continue as Guest")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color(.systemGray))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .strokeBorder(Color(.systemGray4), lineWidth: 1)
                                )
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 30)
                    }
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 26))
                    .shadow(color: .black.opacity(0.2), radius: 32, x: 0, y: 16)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 110)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func handleAuth() {
        if isLoginMode {
            print("Sign in: \(email)")
        } else {
            print("Sign up: \(email), \(username)")
        }
    }
}

// MARK: - Tab Button

struct AuthTabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .primary : Color(.systemGray))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    Group {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.09), radius: 4, x: 0, y: 2)
                        }
                    }
                )
        }
    }
}

// MARK: - Input Field

struct AuthInputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundColor(Color(.systemGray2))
                .frame(width: 22)

            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(.system(size: 15))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Secure Field

struct AuthSecureField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    @Binding var isVisible: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundColor(Color(.systemGray2))
                .frame(width: 22)

            Group {
                if isVisible {
                    TextField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                } else {
                    SecureField(placeholder, text: $text)
                }
            }
            .font(.system(size: 15))

            Button(action: { isVisible.toggle() }) {
                Image(systemName: isVisible ? "eye.slash" : "eye")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.systemGray2))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Social Auth Button

struct SocialAuthButton: View {
    let imageName: String
    let label: String
    let isTemplate: Bool
    let backgroundColor: Color
    let labelColor: Color
    var hasBorder: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 9) {
                if isTemplate {
                    Image(imageName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(labelColor)
                } else {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                }

                Text(label)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(labelColor)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                Group {
                    if hasBorder {
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(Color(.systemGray4), lineWidth: 1)
                    }
                }
            )
            .shadow(color: .black.opacity(0.07), radius: 6, x: 0, y: 3)
        }
    }
}

// MARK: - Compatibility Aliases

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        AuthInputField(icon: "textformat", placeholder: placeholder, text: $text, keyboardType: keyboardType)
    }
}

struct CustomSecureField: View {
    let placeholder: String
    @Binding var text: String
    @Binding var isVisible: Bool

    var body: some View {
        AuthSecureField(icon: "lock", placeholder: placeholder, text: $text, isVisible: $isVisible)
    }
}

struct SocialLoginButton: View {
    let icon: String
    let color: Color

    var body: some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .frame(width: 52, height: 52)
                .background(color)
                .clipShape(Circle())
        }
    }
}

#Preview {
    AuthPage()
}
