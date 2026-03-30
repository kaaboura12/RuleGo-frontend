# RuleGO 🌍

<div align="center">
  <img src="ruleGo/ruleGo/Assets.xcassets/AppLogo.imageset/AppLogo.png" alt="RuleGO Logo" width="120"/>
  
  ### Know the rules. Travel safely.
  
  Your essential travel companion for understanding local rules, regulations, and cultural norms worldwide.
  
  [![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
  [![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)](https://www.apple.com/ios/)
  [![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green.svg)](https://developer.apple.com/xcode/swiftui/)
  [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
</div>

---

## 📱 About RuleGO

RuleGO is a comprehensive iOS travel application designed to help travelers stay informed about local laws, regulations, and cultural norms across different countries. Whether you're planning a trip or already exploring a new destination, RuleGO ensures you're aware of important rules to avoid fines, misunderstandings, and cultural faux pas.

### ✨ Key Features

- **🌐 Multi-Country Support**: Access rules and regulations for destinations worldwide
- **📋 Categorized Rules**: Browse rules organized by categories (Smoking, Driving, Alcohol, Dress Code, Photography, Cultural)
- **🔍 Smart Search**: Quickly find specific rules with powerful search functionality
- **⭐ Favorites System**: Save important rules for quick access during your travels
- **🚨 Emergency Contacts**: Instant access to emergency numbers for each destination
- **🎨 Beautiful UI**: Modern, intuitive interface with glassmorphism design elements
- **🔐 User Authentication**: Secure sign-in with email, Apple, and Google authentication
- **📱 Offline Ready**: Core Data persistence for offline access to saved rules

---

## 🎯 Core Functionality

### 1. **Home Screen**
- Country selector with searchable list
- Quick access to popular rules
- Category browsing cards
- Emergency contact information
- Personalized welcome experience

### 2. **Rules Explorer**
- Comprehensive rule database
- Category-based filtering
- Search functionality
- Expandable rule cards with detailed information
- Fine amounts and pro tips
- Share rules with fellow travelers

### 3. **Favorites**
- Save important rules for quick reference
- Search within favorites
- Category filtering
- Remove rules from favorites
- Share saved rules

### 4. **User Profile**
- Settings management
- Notification preferences
- Privacy controls
- Account management
- About and support information

### 5. **Authentication**
- Email/password authentication
- Apple Sign-In integration
- Google Sign-In integration
- Guest mode access
- Password recovery flow with OTP verification

---

## 🏗️ Architecture

### Technology Stack

- **Framework**: SwiftUI
- **Minimum iOS Version**: iOS 17.0+
- **Language**: Swift 5.9
- **Data Persistence**: Core Data
- **Architecture Pattern**: MVVM (Model-View-ViewModel)
- **Navigation**: NavigationStack (iOS 16+)

### Project Structure

```
ruleGo/
├── ruleGo/
│   ├── ruleGoApp.swift          # App entry point
│   ├── Persistence.swift         # Core Data stack
│   │
│   ├── screens/                  # Main screens
│   │   ├── SplashScreen.swift   # Launch screen
│   │   ├── HomePage.swift       # Welcome/onboarding
│   │   ├── AuthPage.swift       # Authentication
│   │   ├── ForgetPasswordPage.swift  # Password recovery
│   │   ├── MainTabView.swift    # Tab navigation
│   │   ├── HomeScreen.swift     # Main home view
│   │   ├── RulesScreen.swift    # Rules explorer
│   │   ├── FavoritesPage.swift  # Saved rules
│   │   ├── SettingsPage.swift   # User settings
│   │   └── AboutPage.swift      # App information
│   │
│   ├── components/               # Reusable components
│   │   ├── NavBar.swift         # Bottom navigation bar
│   │   └── CountrySelector.swift # Country picker
│   │
│   ├── models/                   # Data models
│   │   └── Country.swift        # Country, Rule, Category models
│   │
│   └── Assets.xcassets/          # Images and colors
│       ├── AppLogo.imageset/
│       ├── backgroundimage.imageset/
│       └── ruleGosplash.imageset/
│
├── ruleGoTests/                  # Unit tests
└── ruleGoUITests/                # UI tests
```

---

## 🎨 Design Highlights

### Visual Design
- **Color Scheme**: Brand blue (`#3399E6`) with complementary gradients
- **Typography**: SF Pro system font with varied weights
- **UI Style**: Modern glassmorphism with blur effects
- **Animations**: Spring-based animations for smooth interactions
- **Shadows**: Layered shadows for depth perception

### UX Features
- Smooth transitions between screens
- Haptic feedback on interactions
- Pull-to-refresh capabilities
- Skeleton loading states
- Empty state illustrations
- Error handling with user-friendly messages

---

## 📦 Data Models

### Country
```swift
struct Country {
    let name: String
    let flag: String
    let code: String
}
```

### Rule
```swift
struct Rule {
    let icon: String
    let title: String
    let description: String
    let category: String
    let fine: String?
    let tip: String?
    var isFavorite: Bool
}
```

### Categories
- 🚬 Smoking
- 🚗 Driving
- 🍷 Alcohol
- 👕 Dress Code
- 📷 Photography
- 🏛️ Cultural

---

## 🚀 Getting Started

### Prerequisites
- macOS 14.0 or later
- Xcode 15.0 or later
- iOS 17.0+ device or simulator
- Apple Developer account (for device testing)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/kaaboura/rulego.git
   cd rulego
   ```

2. **Open in Xcode**
   ```bash
   open ruleGo/ruleGo.xcodeproj
   ```

3. **Configure signing**
   - Select the project in Xcode
   - Go to "Signing & Capabilities"
   - Select your development team

4. **Build and run**
   - Select your target device/simulator
   - Press `Cmd + R` or click the Run button

### Configuration

No additional configuration or API keys are required for the basic version. The app uses sample data for demonstration purposes.

---

## 📸 Screenshots

*Coming soon - Add screenshots of your app here*

---

## 🔄 App Flow

```
Splash Screen
    ↓
Welcome Page
    ↓
Authentication (Sign In / Sign Up / Guest)
    ↓
Main Tab View
    ├── Home Tab
    │   ├── Country Selection
    │   ├── Quick Rules
    │   ├── Categories
    │   └── Emergency Contacts
    │
    ├── Rules Tab
    │   ├── Search Rules
    │   ├── Filter by Category
    │   └── View Rule Details
    │
    └── Profile Tab
        ├── Settings
        ├── Favorites
        └── About
```

---

## 🛠️ Key Components

### Custom UI Components

#### NavBar
- Modern bottom navigation with glassmorphism effect
- Smooth tab switching animations
- Icon-only design for clean aesthetics
- Matched geometry effect for fluid transitions

#### CountrySelector
- Searchable country list
- Flag emoji display
- Modal presentation
- Selection persistence

#### RuleCard
- Expandable cards with smooth animations
- Category badges
- Fine amount warnings
- Pro tips display
- Favorite toggle
- Share functionality

---

## 🔐 Authentication Features

- **Email/Password**: Traditional authentication
- **Apple Sign-In**: Native iOS authentication
- **Google Sign-In**: Third-party OAuth
- **Guest Mode**: Browse without account
- **Password Recovery**: Multi-step OTP verification flow

---

## 💾 Data Persistence

The app uses Core Data for local storage:
- User preferences
- Favorite rules
- Offline data caching
- Authentication state

---

## 🌟 Future Enhancements

- [ ] Backend API integration
- [ ] Real-time rule updates
- [ ] Push notifications for rule changes
- [ ] Offline mode with full data sync
- [ ] Multi-language support
- [ ] Location-based rule suggestions
- [ ] Travel itinerary planning
- [ ] Community-contributed rules
- [ ] AR features for on-site rule display
- [ ] Apple Watch companion app

---

## 🧪 Testing

### Unit Tests
```bash
# Run unit tests
Cmd + U in Xcode
```

### UI Tests
```bash
# Run UI tests
Select ruleGoUITests scheme and press Cmd + U
```

---

## 📝 Code Style

The project follows Swift best practices:
- SwiftLint configuration (recommended)
- Clear naming conventions
- Comprehensive comments for complex logic
- MARK comments for code organization
- Modular component architecture

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Contribution Guidelines
- Follow the existing code style
- Add unit tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Developer

**Developed by Kaaboura**

- GitHub: [@kaaboura](https://github.com/kaaboura)
- Email: support@rulego.app

---

## 🙏 Acknowledgments

- SF Symbols for beautiful iconography
- SwiftUI community for inspiration
- Apple Human Interface Guidelines
- All contributors and testers

---

## 📞 Support

For support, feature requests, or bug reports:
- Email: support@rulego.app
- GitHub Issues: [Create an issue](https://github.com/kaaboura/rulego/issues)
- Feedback: feedback@rulego.app

---

## 📊 Project Status

**Version**: 1.0.0  
**Build**: 2026.01.05  
**Status**: Active Development  
**Last Updated**: January 2026

---

## ⚠️ Disclaimer

RuleGO provides information sourced from official and trusted sources. However, it does not replace official government advice. Always verify current regulations with official authorities before traveling. Users are responsible for their own compliance with local laws.

---

<div align="center">
  
### Made with ❤️ for travelers worldwide
  
**Know the rules. Travel safely. Go anywhere.**

[Download on App Store](#) | [View Documentation](#) | [Report Bug](https://github.com/kaaboura/rulego/issues)

</div>
