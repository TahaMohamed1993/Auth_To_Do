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
![Screenshot 2023-05-20 143349](https://github.com/TahaMohamed1993/Auth_To_Do/assets/91631512/61e30793-8c1e-4d2b-a2a1-0a151a60d9fc)
![Screenshot_1684454559](https://github.com/TahaMohamed1993/Auth_To_Do/assets/91631512/f8981cf8![Screenshot 2023-05-09 201913](https://github.com/TahaMohamed1993/Auth_To_Do/assets/91631512/d59e959d-5663-43c4-9f3c-86066655e5cb)
-172e-43f1-bef7-59b53a3e6c3c)


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


