# Test Mode Guide

## Overview
The Enhanced POS System now includes a **Test Mode** feature that allows testing all application features without requiring authentication. This makes it easy to explore and test the system's capabilities.

## How to Enable Test Mode

### Method 1: Configuration File
1. Open `lib/core/constants/variables.dart`
2. Set `isTestMode = true`
3. Restart the application

```dart
class Variables {
  static const String baseUrl = 'https://582149604db5.ngrok-free.app';
  static const String imageBaseUrl = '$baseUrl/storage/';
  
  // Test mode configuration
  static const bool isTestMode = true; // Set to true to enable test mode
  static const String testModeMessage = 'Test Mode: All features available without login';
}
```

### Method 2: Runtime Toggle (if implemented)
- Use the "Use Login" button on the test mode welcome screen to switch to normal authentication mode

## Features Available in Test Mode

### ✅ Core POS Features
- **Product Management**: View and manage product catalog
- **Category Management**: Organize products by categories
- **Order Processing**: Create and process customer orders
- **Payment Handling**: Process payments and generate receipts
- **Transaction History**: View past transactions and order history
- **Sales Reporting**: Access sales analytics and reports

### ✅ Workshop Management Features
- **Service Jobs**: 
  - Create new service requests
  - Track repair progress
  - Update job status
  - Manage service timelines
  
- **Customer Management**:
  - Add new customers
  - View customer profiles
  - Manage customer vehicles
  - Track customer history
  
- **Service Management**:
  - Define available services
  - Set service categories
  - Manage service pricing
  - Configure service workflows
  
- **Outlet Management**:
  - Manage multiple workshop locations
  - Configure branch settings
  - Track outlet performance

### ✅ Advanced Features
- **Responsive Design**: Works on both mobile and tablet
- **Real-time Updates**: Live status tracking
- **Search and Filter**: Advanced search across all modules
- **Error Handling**: Comprehensive error management
- **Loading States**: Proper loading indicators

## Visual Indicators

When test mode is active, you'll see:
- 🟠 **Orange "TEST MODE" badges** on app bars
- 🧪 **Test mode welcome screen** with feature overview
- ⚠️ **Warning messages** indicating test mode is active
- 🔄 **Toggle option** to switch to normal login mode

## Test Mode vs Normal Mode

| Feature | Test Mode | Normal Mode |
|---------|-----------|-------------|
| Authentication | ❌ Not Required | ✅ Required |
| All Features | ✅ Accessible | ✅ Accessible |
| Data | 🔄 Dummy/Test Data | 📊 Real Data |
| API Calls | 🔄 Mock/Dummy | 🌐 Real Backend |
| User Management | ❌ Bypassed | ✅ Active |

## Testing Workflow

1. **Enable Test Mode** (set `isTestMode = true`)
2. **Launch Application** - You'll see the test mode welcome screen
3. **Click "Start Testing"** - Navigate to main features
4. **Explore Features**:
   - POS: Create orders, process payments
   - Service Jobs: Create and manage repair jobs
   - Customers: Add and manage customer profiles
   - Services: Configure available services
   - Outlets: Manage workshop locations
5. **Check Responsiveness** - Test on different screen sizes
6. **Verify Navigation** - Ensure all features are accessible

## Switching Between Modes

### To Enable Test Mode:
```dart
// In lib/core/constants/variables.dart
static const bool isTestMode = true;
```

### To Disable Test Mode:
```dart
// In lib/core/constants/variables.dart
static const bool isTestMode = false;
```

## Benefits of Test Mode

### For Developers:
- 🚀 **Rapid Testing**: No login required
- 🔧 **Feature Verification**: Test all functionality quickly
- 🐛 **Bug Detection**: Identify issues without authentication barriers
- 📱 **UI Testing**: Focus on user interface and experience

### For Testers:
- ✅ **Complete Access**: Test all features without credentials
- 🔄 **Easy Reset**: Simple toggle between modes
- 📊 **Feature Coverage**: Ensure all modules work properly
- 🎯 **Focus Testing**: Concentrate on functionality, not authentication

### For Demonstrations:
- 🎪 **Live Demos**: Show features without login delays
- 👥 **Client Presentations**: Demonstrate capabilities quickly
- 📋 **Feature Showcase**: Highlight all available functionality
- ⚡ **Quick Setup**: No need for test credentials

## Important Notes

⚠️ **Security**: Test mode should NEVER be enabled in production environments

⚠️ **Data**: Test mode uses dummy data - real data requires normal authentication mode

⚠️ **Performance**: Some features may behave differently with dummy data vs real API calls

⚠️ **Persistence**: Test mode settings require app restart to take effect

## Troubleshooting

### Test Mode Not Working?
1. Check `Variables.isTestMode` is set to `true`
2. Restart the application completely
3. Verify no caching issues

### Features Not Loading?
1. Check BLoC providers are properly initialized
2. Verify dummy data sources are working
3. Check for console errors

### Visual Indicators Missing?
1. Verify imports include `Variables` class
2. Check conditional rendering logic
3. Restart app to refresh UI

## Disabling Test Mode for Production

Before deploying to production:

1. Set `isTestMode = false` in `variables.dart`
2. Test authentication flow
3. Verify all real API connections
4. Remove test mode documentation from user-facing docs

---

**Note**: This test mode feature is designed for development, testing, and demonstration purposes only. Always use proper authentication in production environments.