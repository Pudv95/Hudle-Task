# Weather App - Flutter BLoC Pattern Implementation

A modern Flutter weather application built using Clean Architecture and the BLoC pattern. This app demonstrates best practices for state management, API integration, and user interface design.

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

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- OpenWeatherMap API Key

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd hudle_task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables**
   - Copy `.env.example` to `.env`: `cp .env.example .env`
   - Sign up for a free API key at [OpenWeatherMap](https://home.openweathermap.org/users/sign_up)
   - Update the `.env` file with your actual API key:
     ```
     OPENWEATHER_API_KEY=your_actual_api_key_here
     DEFAULT_CITY=your_default_city
     ```

4. **Run the app**
   ```bash
   flutter run
   ```

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

## 🧪 Testing

The project is structured to support comprehensive testing:

```bash
# Run unit tests
flutter test

# Run widget tests
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

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

## 🎯 Learning BLoC Pattern

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

### 1. Clean Architecture Implementation
**Challenge**: Setting up proper separation of concerns
**Solution**: Organized code into domain, data, and presentation layers with clear interfaces

### 2. BLoC Pattern Learning
**Challenge**: Understanding event-driven state management
**Solution**: Started with simple events and states, gradually added complexity

### 3. API Integration
**Challenge**: Handling different types of API errors
**Solution**: Created custom failure classes and proper error handling in repository

### 4. Local Caching
**Challenge**: Implementing offline-first approach
**Solution**: Used SharedPreferences for local storage with proper serialization

### 5. UI/UX Design
**Challenge**: Creating a modern, responsive interface
**Solution**: Used Material 3 design system with custom animations and gradients

## 🔮 Future Enhancements

- [ ] Weather forecasts for multiple days
- [ ] Multiple temperature units (Celsius/Fahrenheit toggle)
- [ ] Weather maps integration
- [ ] Push notifications for weather alerts
- [ ] Widget support for home screen
- [ ] Multiple language support
- [ ] Advanced animations and transitions
- [ ] Weather history and trends
- [ ] Social sharing features
