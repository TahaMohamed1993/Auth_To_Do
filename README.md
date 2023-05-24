# My To-Do Application

This is a simple to-do application built using Flutter. It utilizes the BLoC pattern for state management, Firebase for data synchronization and authentication, and Sqflite for local data persistence.

## Features

- Create, update, and delete tasks
- Mark tasks as complete
- Filter tasks by status (complete/incomplete)
- User authentication with Firebase
- Data synchronization across devices with Firebase Realtime Database
- Local data persistence with Sqflite


## Screenshots

![Screenshot_1684454559](https://github.com/TahaMohamed1993/Auth_To_Do/assets/91631512/8091cca2-0d10-4869-9ffe-b88a29150b3a)
![Screenshot 2023-05-06 023738](https://github.com/TahaMohamed1993/Auth_To_Do/assets/91631512/2844114c-2e73-4c4e-b51a-5ebe397ffada)
![Screenshot 2023-05-09 201913](https://github.com/TahaMohamed1993/Auth_To_Do/assets/91631512/14cd7368-ebbd-436f-8b08-6afabac2fa3e)
![Screenshot 2023-05-20 143349](https://github.com/TahaMohamed1993/Auth_To_Do/assets/91631512/2b6cef9e-1b37-43d0-bc1e-8697a0aaea5a)


## Demo Video

Check out the demo video of the application on YouTube: [Demo Video](https://youtu.be/ruyTHTntYxg)

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository: `git clone <repository_url>`
2. Install the dependencies: `flutter pub get`
3. Configure Firebase:
   - Create a new Firebase project
   - Enable Firebase Authentication and set up the necessary providers (e.g., email/password)
   - Enable Firebase Realtime Database
4. Update Firebase configuration:
   - Android: Update the `google-services.json` file in the `android/app` directory with your Firebase project credentials
   - iOS: Update the `GoogleService-Info.plist` file in the `ios/Runner` directory with your Firebase project credentials
5. Run the app: `flutter run`

## Dependencies

cupertino_icons: ^1.0.2
  shared_preferences: ^2.1.0
  provider: ^6.0.5
  intl: ^0.18.0
  http: ^0.13.5
  firebase_core: ^2.9.0
  firebase_auth: ^4.2.2
  sqflite: ^2.2.6
  google_nav_bar: ^5.0.6
  flutter_neumorphic: ^3.2.0
  flutter_svg:
  path: ^1.8.2
  conditional_builder_null_safety: ^0.0.6
  bloc: ^8.1.1
  flutter_bloc: ^8.1.2


