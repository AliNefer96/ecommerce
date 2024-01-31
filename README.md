# ecommerce

This is a Flutter app for an E-Commerce platform, featuring product listing, filtering, and details.

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Features](#features)
- [Folder Structure](#folder-structure)
- [Packages Used](#packages-used)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

### Prerequisites

- Make sure you have Flutter and Dart installed. If not, follow the official [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/ecommerce-flutter-app.git
cd ecommerce-flutter-app

Install dependencies: 
flutter pub get

Run the app
flutter run

Features

    Product listing with search and filtering options.
    Detailed product view with modal for additional details.
    Detailed product view with modal for editing product info.
    Category filtering and sorting options. (I didn't manage to fully finish the task, because of my work related responibilites)
    Responsive UI design.

Folder structure
ecommerce-flutter-app/
|-- lib/
|   |-- Helpers/
|   |-- Models/
|   |-- Providers/
|   |-- UI/
|       |-- Widgets/
|-- test/
|-- pubspec.yaml
|-- README.md

    lib/: Contains the main Dart code for the app.
    lib/Helpers/: Helper classes and functions.
    lib/Models/: Dart classes representing data models.
    lib/Providers/: State management using Provider.
    lib/UI/: User interface components.
    lib/UI/Widgets/: Reusable widgets.

Packages Used

    provider: State management library.
    http: HTTP client for making API requests.
    flutter/material.dart: Core Flutter framework.
    flutter/widgets.dart: Widgets for building UI.

To install these packages, add the following to your pubspec.yaml file:
dependencies:
  provider: ^5.0.0
  http: ^0.13.3
  flutter:
    sdk: flutter
  # other dependencies...
