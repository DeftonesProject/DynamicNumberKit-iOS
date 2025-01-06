
# DynamicNumberKit-iOS

**DynamicNumberKit-iOS** is a powerful library designed for iOS developers, enabling seamless integration of virtual phone number functionality into mobile applications. With this library, you can quickly add support for purchasing virtual numbers and receiving SMS verification codes via VoIP from almost any online service.

## Key Features

- **Virtual Number Management**: Easily integrate the ability to purchase and manage virtual phone numbers directly within your app.
- **SMS Reception via VoIP**: Receive SMS messages with verification codes through a fast and reliable VoIP service.
- **Broad Compatibility**: Works with verification systems of most online services, including popular platforms and apps.
- **Seamless Integration**: Minimal setup and clean API for effortless integration into your iOS projects.
- **Scalable and Reliable**: Built with scalability in mind to handle high volumes of SMS messages and virtual number transactions.

## Installation

DynamicNumberKit-iOS supports installation via popular dependency managers like CocoaPods or Swift Package Manager.

### CocoaPods

Add the following line to your Podfile:

```ruby
pod 'DynamicNumberKit-iOS'
```

Run `pod install` to integrate the library into your project.

### Swift Package Manager

Add DynamicNumberKit-iOS to your `Package.swift` file:

```swift
.package(url: "DynamicNumberKit-iOS", from: "1.0.0")
```

Then include it as a dependency in your target.

## Getting Started

### 1. Import the Library

```swift
import DynamicNumberKit
```

### 2. Initialize the SDK

Set up the library in your app by initializing it with your API key and configuration:

```swift
DynamicNumberKit.initialize(apiKey: "YOUR_API_KEY")
```

### 3. Purchase a Virtual Number

Use the library's simple API to purchase a virtual number:

```swift
DynamicNumberKit.purchaseNumber(region: "US") { result in
    switch result {
    case .success(let virtualNumber):
        print("Purchased virtual number: \(virtualNumber)")
    case .failure(let error):
        print("Failed to purchase number: \(error.localizedDescription)")
    }
}
```

### 4. Receive SMS Messages

Listen for incoming SMS messages via VoIP:

```swift
DynamicNumberKit.onSMSReceived = { message in
    print("Received SMS: \(message.content)")
}
```

## Use Cases

- **Verification Support**: Enable users to verify accounts on platforms without exposing their personal phone numbers.
- **Temporary Numbers**: Provide disposable virtual numbers for enhanced privacy.
- **Global Reach**: Allow users to access services in different regions with regional phone numbers.

## Documentation

Comprehensive documentation is available to help you get started and make the most out of DynamicNumberKit-iOS.

## Contributing

We welcome contributions to improve DynamicNumberKit-iOS! Please read our Contributing Guide for more details.

## License

DynamicNumberKit-iOS is available under the MIT License. See the LICENSE file for more information.

## Contact

For support or inquiries, please contact us at [support@dynamicnumberkit.com](mailto:support@dynamicnumberkit.com).

---

Elevate your iOS app's functionality with **DynamicNumberKit-iOS** and provide a streamlined experience for virtual number integration and SMS verification!
