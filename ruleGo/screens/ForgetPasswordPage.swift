//
//  ForgetPasswordPage.swift
//  ruleGo
//
//  Created by sayari amin on 5/1/2026.
//

import SwiftUI

// MARK: - Flow Step

private enum FPStep {
    case email, verify, reset, success
}

// MARK: - Main View

struct ForgotPasswordPage: View {
    @Environment(\.dismiss) private var dismiss

    @State private var step: FPStep = .email
    @State private var email = ""
    @State private var otpCode = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var isNewPasswordVisible = false
    @State private var isConfirmPasswordVisible = false

    private let blue = Color(red: 0.2, green: 0.6, blue: 0.9)

    var body: some View {
        ZStack {
            Image("backgroundimage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)

            Color.black.opacity(0.18)
                .edgesIgnoringSafeArea(.all)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // MARK: Logo
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

                    // MARK: Card
                    VStack(spacing: 0) {

                        // Back button
                        HStack {
                            Button(action: handleBack) {
                                HStack(spacing: 5) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 13, weight: .semibold))
                                    Text(step == .success ? "Sign In" : "Back")
                                        .font(.system(size: 14, weight: .medium))
                                }
                                .foregroundColor(blue)
                            }
                            Spacer()

                            // Step indicator dots (hidden on success)
                            if step != .success {
                                HStack(spacing: 6) {
                                    ForEach(0..<3, id: \.self) { i in
                                        Capsule()
                                            .fill(dotColor(for: i))
                                            .frame(width: stepIndex == i ? 18 : 6, height: 6)
                                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: stepIndex)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)

                        // Step content with slide transition
                        Group {
                            switch step {
                            case .email:   emailStep
                            case .verify:  verifyStep
                            case .reset:   resetStep
                            case .success: successStep
                            }
                        }
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: step)
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

    // MARK: - Step Index

    private var stepIndex: Int {
        switch step {
        case .email:   return 0
        case .verify:  return 1
        case .reset:   return 2
        case .success: return 2
        }
    }

    private func dotColor(for index: Int) -> Color {
        index <= stepIndex ? blue : Color(.systemGray4)
    }

    // MARK: - Step 1: Email

    private var emailStep: some View {
        VStack(spacing: 0) {
            stepHeader(
                icon: "lock.rotation",
                title: "Forgot Password?",
                subtitle: "Enter the email address linked to your account and we'll send you a verification code."
            )

            AuthInputField(
                icon: "envelope",
                placeholder: "Email address",
                text: $email,
                keyboardType: .emailAddress
            )
            .padding(.horizontal, 24)

            ctaButton("Send Code") {
                withAnimation { step = .verify }
            }

            Spacer().frame(height: 28)
        }
    }

    // MARK: - Step 2: Verify OTP

    private var verifyStep: some View {
        VStack(spacing: 0) {
            stepHeader(
                icon: "envelope.badge",
                title: "Check Your Email",
                subtitle: "We sent a 6-digit code to\n\(email.isEmpty ? "your email" : email)"
            )

            OTPInputView(code: $otpCode)
                .padding(.horizontal, 24)

            HStack(spacing: 4) {
                Text("Didn't receive the code?")
                    .font(.system(size: 13))
                    .foregroundColor(Color(.systemGray))
                Button("Resend") { otpCode = "" }
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(blue)
            }
            .padding(.top, 16)

            ctaButton("Verify Code") {
                withAnimation { step = .reset }
            }

            Spacer().frame(height: 28)
        }
    }

    // MARK: - Step 3: Reset Password

    private var resetStep: some View {
        VStack(spacing: 0) {
            stepHeader(
                icon: "lock.fill",
                title: "New Password",
                subtitle: "Your new password must be at least 8 characters and different from your previous one."
            )

            VStack(spacing: 14) {
                AuthSecureField(
                    icon: "lock",
                    placeholder: "New password",
                    text: $newPassword,
                    isVisible: $isNewPasswordVisible
                )
                AuthSecureField(
                    icon: "checkmark.shield",
                    placeholder: "Confirm new password",
                    text: $confirmPassword,
                    isVisible: $isConfirmPasswordVisible
                )
            }
            .padding(.horizontal, 24)

            ctaButton("Reset Password") {
                withAnimation { step = .success }
            }

            Spacer().frame(height: 28)
        }
    }

    // MARK: - Step 4: Success

    private var successStep: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(red: 0.18, green: 0.78, blue: 0.44).opacity(0.14))
                    .frame(width: 90, height: 90)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 46))
                    .foregroundColor(Color(red: 0.18, green: 0.78, blue: 0.44))
            }
            .padding(.top, 32)

            Text("Password Reset!")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.primary)

            Text("Your password has been reset successfully.\nYou can now sign in with your new password.")
                .font(.system(size: 14))
                .foregroundColor(Color(.systemGray))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 16)

            ctaButton("Back to Sign In") { dismiss() }

            Spacer().frame(height: 32)
        }
    }

    // MARK: - Shared Components

    @ViewBuilder
    private func stepHeader(icon: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(blue.opacity(0.12))
                    .frame(width: 68, height: 68)
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(blue)
            }
            .padding(.top, 24)

            Text(title)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(.primary)

            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(Color(.systemGray))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 16)
        }
        .padding(.bottom, 24)
    }

    @ViewBuilder
    private func ctaButton(_ label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: [blue, Color(red: 0.1, green: 0.45, blue: 0.82)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: blue.opacity(0.4), radius: 12, x: 0, y: 6)
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }

    // MARK: - Back Navigation

    private func handleBack() {
        switch step {
        case .email:   dismiss()
        case .verify:  withAnimation { step = .email }
        case .reset:   withAnimation { step = .verify }
        case .success: dismiss()
        }
    }
}

// MARK: - OTP Input

struct OTPInputView: View {
    @Binding var code: String
    @FocusState private var isFocused: Bool
    private let length = 6
    private let blue = Color(red: 0.2, green: 0.6, blue: 0.9)

    var body: some View {
        ZStack {
            // Invisible capture field
            TextField("", text: Binding(
                get: { code },
                set: { code = String($0.filter(\.isNumber).prefix(length)) }
            ))
            .keyboardType(.numberPad)
            .focused($isFocused)
            .frame(width: 1, height: 1)
            .opacity(0.001)

            // Visual boxes
            HStack(spacing: 10) {
                ForEach(0..<length, id: \.self) { i in
                    otpBox(at: i)
                        .onTapGesture { isFocused = true }
                }
            }
        }
        .onAppear { isFocused = true }
    }

    private func otpBox(at index: Int) -> some View {
        let digits = Array(code)
        let filled = index < digits.count
        let active = index == digits.count && isFocused

        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .frame(width: 46, height: 56)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(
                            active ? blue : (filled ? blue.opacity(0.5) : Color.clear),
                            lineWidth: active ? 2 : 1.5
                        )
                )
                .animation(.easeInOut(duration: 0.15), value: active)

            if filled {
                Text(String(digits[index]))
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.primary)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: filled)
    }
}

#Preview {
    NavigationView {
        ForgotPasswordPage()
    }
}
