# Weather App - Flutter BLoC Pattern Implementation

A modern Flutter weather application built using Clean Architecture and the BLoC pattern. This app demonstrates best practices for state management, API integration, and user interface design.

## 🎓 How I Learned BLoC Pattern

### My Learning Journey

Learning the BLoC (Business Logic Component) pattern was an exciting journey that transformed how I think about Flutter app architecture. Here's how I approached it:

#### 1. **Understanding the Fundamentals**
- Started with the official BLoC documentation and examples
- Watched YouTube tutorials from Flutter developers
- Read articles about reactive programming and streams
- Practiced with simple counter examples to understand the basic flow

#### 2. **Key Concepts I Mastered**
- **Events**: Input actions that trigger state changes (user taps, API calls)
- **States**: Output data that represents the current UI state
- **BLoC**: The business logic component that transforms events into states
- **Streams**: Reactive programming foundation that BLoC is built upon

#### 3. **Learning Resources**
- [BLoC Official Documentation](https://bloclibrary.dev/)
- [Effective BLoC pattern](https://medium.com/codechai/effective-bloc-pattern-45c36d76d5fe)
- [BLoC - GFG](https://www.geeksforgeeks.org/flutter/bloc-pattern-flutter/)
- [Clean Architecture in Flutter | MVVM | BloC | Dio](https://medium.com/@yamen.abd98/clean-architecture-in-flutter-mvvm-bloc-dio-79b1615530e1)

#### 4. **Practical Application**
- Built small projects to practice BLoC implementation
- Gradually increased complexity from simple state management to API integration
- Learned to handle async operations and error states
- Understood the importance of proper state management for complex UIs

#### 5. **Best Practices I Learned**
- Keep BLoCs focused and single-purpose
- Use proper event naming conventions
- Handle loading, success, and error states consistently
- Implement proper error handling and user feedback
- Write comprehensive tests for BLoC logic

## 🌟 Features

### Core Features
- **City Weather Search**: Search for weather information by city name
- **Current Location Weather**: Get weather for your current location
- **Real-time Weather Data**: Temperature, weather conditions, humidity, and wind speed
- **Pull-to-Refresh**: Refresh weather data with a simple pull gesture

### Advanced Features
- **Dark/Light Theme Toggle**: Switch between light and dark themes
- **Local Caching**: Weather data is cached locally for offline access
- **Search History**: Track your recent searches
- **Error Handling**: Graceful error handling for network issues and invalid cities
- **Responsive Design**: Beautiful UI that adapts to different screen sizes

### Technical Features
- **Clean Architecture**: Separation of concerns with domain, data, and presentation layers
- **BLoC Pattern**: State management using flutter_bloc
- **Repository Pattern**: Abstraction layer for data sources
- **Dependency Injection**: Manual dependency injection for better testability
- **Unit Testing Ready**: Architecture designed for easy testing

## 🏗️ Architecture

This project follows Clean Architecture principles with the BLoC pattern:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants and configuration
│   ├── errors/             # Error handling and failure classes
│   ├── network/            # Network connectivity checking
│   └── usecases/           # Base use case interface
├── features/
│   └── weather/            # Weather feature
│       ├── data/           # Data layer
│       │   ├── datasources/    # Remote and local data sources
│       │   ├── models/         # Data models
│       │   └── repositories/   # Repository implementations
│       ├── domain/         # Domain layer
│       │   ├── entities/       # Business entities
│       │   ├── repositories/   # Repository interfaces
│       │   └── usecases/       # Business logic use cases
│       └── presentation/   # Presentation layer
│           ├── bloc/           # BLoC classes (events, states, bloc)
│           ├── pages/          # UI pages
│           └── widgets/        # Reusable UI components
```

## 🚀 Setup Instructions

### Prerequisites
- **Flutter SDK**: Version 3.8.1 or higher
- **Dart SDK**: Latest stable version
- **IDE**: Android Studio / VS Code with Flutter extensions
- **OpenWeatherMap API Key**: Free account at [OpenWeatherMap](https://home.openweathermap.org/users/sign_up)

### Step-by-Step Installation

#### 1. **Clone and Navigate**
   ```bash
   git clone <repository-url>
   cd hudle_task
   ```

#### 2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

#### 3. **Environment Configuration**
   ```bash
   # Copy the example environment file
   cp .env.example .env
   
   # Edit the .env file with your API key
   nano .env  # or use your preferred editor
   ```
   
   Add your configuration:
   ```env
   OPENWEATHER_API_KEY=your_actual_api_key_here
   DEFAULT_CITY=London
   ```

#### 4. **Verify Setup**
   ```bash
   # Check if Flutter is properly configured
   flutter doctor
   
   # Run the app in debug mode
   flutter run
   ```

#### 5. **Testing Setup**
   ```bash
   # Run all tests
   flutter test
   
   # Run with coverage
   flutter test --coverage
   
   # Generate mock files (if needed)
   flutter packages pub run build_runner build
   ```

### Platform-Specific Setup

#### Android
- Ensure Android SDK is installed
- Set up Android emulator or connect physical device
- Run: `flutter run -d android`

#### iOS (macOS only)
- Install Xcode and iOS Simulator
- Run: `flutter run -d ios`

#### Web
- Run: `flutter run -d chrome`

## 📱 Usage

1. **Search by City**: Enter a city name in the search bar and press enter
2. **Get Current Location**: Tap the location icon to get weather for your current location
3. **Refresh Data**: Pull down on the screen to refresh weather data
4. **Toggle Theme**: Use the theme toggle button in the app bar to switch between light and dark themes

## 🛠️ Dependencies

### State Management
- `flutter_bloc`: BLoC pattern implementation
- `equatable`: Value equality for Dart objects

### Network & API
- `dio`: HTTP client for API calls
- `geolocator`: Location services
- `permission_handler`: Permission handling

### Local Storage
- `shared_preferences`: Local data persistence

### UI & Animations
- `flutter_animate`: Smooth animations
- `cached_network_image`: Image caching

### Utils
- `intl`: Internationalization and formatting
- `dartz`: Functional programming utilities

### Testing
- `flutter_test`: Flutter testing framework
- `bloc_test`: BLoC testing utilities
- `mockito`: Mocking framework for testing

## 🧪 Testing

The project includes comprehensive testing:

```bash
# Run all tests
flutter test

# Run specific test files
flutter test test/widget_test.dart
flutter test test/bloc/theme_bloc_test.dart

# Run with coverage
flutter test --coverage

# Generate test reports
genhtml coverage/lcov.info -o coverage/html
```

### Test Structure
- **Unit Tests**: Business logic and use cases
- **Widget Tests**: UI component testing
- **BLoC Tests**: State management testing
- **Integration Tests**: End-to-end functionality

## 📁 Project Structure

### Core Layer
- **Constants**: App-wide constants and configuration
- **Errors**: Custom failure classes for error handling
- **Network**: Network connectivity checking
- **UseCases**: Base use case interface

### Domain Layer
- **Entities**: Core business objects (Weather)
- **Repositories**: Abstract repository interfaces
- **UseCases**: Business logic implementation

### Data Layer
- **DataSources**: Remote (API) and local (cache) data sources
- **Models**: Data transfer objects
- **Repositories**: Repository implementations

### Presentation Layer
- **BLoC**: State management (Events, States, BLoC)
- **Pages**: Main UI screens
- **Widgets**: Reusable UI components

## 🔧 Configuration

### Environment Configuration
The app uses environment variables for configuration. Create a `.env` file in the root directory:

```bash
# Copy the example file
cp .env.example .env

# Edit the .env file with your actual values
OPENWEATHER_API_KEY=your_actual_api_key_here
DEFAULT_CITY=your_default_city
```

**Important**: Never commit your `.env` file to version control. It's already added to `.gitignore`.

### Theme Configuration
Themes are defined in `lib/main.dart` with Material 3 design system.

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is created as part of the Hudle Flutter Developer Task.

## 🆘 Support

For any issues or questions:
- Create an issue in the repository
- Contact: manav@hudle.in

## 🎯 BLoC Pattern Deep Dive

### What is BLoC?
BLoC (Business Logic Component) is a design pattern that helps separate business logic from the UI layer. It's based on streams and reactive programming.

### Key Concepts:
1. **Events**: Input to the BLoC (user actions, API calls)
2. **States**: Output from the BLoC (UI state)
3. **BLoC**: Business logic that transforms events into states

### Benefits:
- **Separation of Concerns**: UI logic separated from business logic
- **Testability**: Easy to unit test business logic
- **Reusability**: BLoCs can be reused across different widgets
- **Predictable State**: Unidirectional data flow

### Implementation in this project:
- `WeatherBloc`: Manages weather data state
- `ThemeBloc`: Manages app theme state
- Events: `FetchWeatherByCity`, `ToggleTheme`, etc.
- States: `WeatherLoading`, `WeatherLoaded`, `WeatherError`, etc.

## 🏆 Challenges Faced & Solutions

### 1. **Understanding BLoC Pattern Initially**
**Challenge**: The concept of events and states was confusing at first. I struggled with understanding when to emit states and how to handle async operations.

**Solution**: 
- Started with simple examples (counter app) to understand the basic flow
- Created a mental model: "Events are actions, States are results"
- Practiced with different scenarios to build confidence
- Used `bloc_test` package to write tests, which helped me understand the flow better

### 2. **Implementing Clean Architecture with BLoC**
**Challenge**: Organizing code into proper layers while maintaining BLoC pattern was complex. I had trouble deciding what goes where.

**Solution**:
- Studied Clean Architecture principles thoroughly
- Created clear boundaries between domain, data, and presentation layers
- Used dependency injection to manage dependencies
- Created abstract interfaces for repositories and use cases

### 3. **Handling Complex State Management**
**Challenge**: Managing multiple states (loading, success, error) and handling edge cases like network failures, invalid cities, etc.

**Solution**:
- Created comprehensive state classes for all scenarios
- Implemented proper error handling with custom failure classes
- Used `Either` type from `dartz` package for functional error handling
- Added proper loading states and user feedback

### 4. **API Integration and Error Handling**
**Challenge**: Integrating with OpenWeatherMap API and handling various types of errors (network, API, invalid data).

**Solution**:
- Used `dio` package for HTTP requests with proper interceptors
- Created custom exception classes for different error types
- Implemented retry logic for network failures
- Added proper error messages for user feedback

### 5. **Local Caching Implementation**
**Challenge**: Implementing offline-first approach with proper data synchronization.

**Solution**:
- Used `SharedPreferences` for simple data storage
- Implemented repository pattern to abstract data sources
- Created proper serialization/deserialization for weather data
- Added cache invalidation logic

### 6. **Testing BLoC Logic**
**Challenge**: Writing comprehensive tests for BLoC classes and ensuring proper coverage.

**Solution**:
- Used `bloc_test` package for testing BLoC behavior
- Created mock classes using `mockito` for dependencies
- Wrote tests for all events and state transitions
- Implemented proper test setup and teardown

### 7. **UI/UX Design and Animations**
**Challenge**: Creating a modern, responsive interface with smooth animations.

**Solution**:
- Used Material 3 design system for consistent UI
- Implemented `flutter_animate` for smooth transitions
- Created custom widgets for better reusability
- Added proper loading states and error handling in UI

### 8. **Environment Configuration**
**Challenge**: Managing API keys and environment variables securely.

**Solution**:
- Used `flutter_dotenv` package for environment management
- Created `.env.example` file for documentation
- Added proper `.gitignore` rules to prevent committing sensitive data
- Implemented proper error handling for missing environment variables

### 9. **Performance Optimization**
**Challenge**: Ensuring the app performs well with smooth animations and fast loading.

**Solution**:
- Implemented proper caching strategies
- Used `cached_network_image` for image caching
- Optimized widget rebuilds with proper state management
- Added loading indicators and skeleton screens

### 10. **Cross-Platform Compatibility**
**Challenge**: Ensuring the app works consistently across different platforms (Android, iOS, Web).

**Solution**:
- Used platform-agnostic packages where possible
- Implemented proper permission handling for location services
- Tested on multiple devices and platforms
- Used responsive design principles

---

**Built with ❤️ using Flutter and BLoC Pattern**
