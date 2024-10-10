# Lift Simple

## Overview

This app is designed to help users track their lifting sessions, monitor their progress, and save completed workouts. It allows users to create custom workout routines, log the number of sets, repetitions, and weights used for each exercise, and keep track of workout durations. Ultimately, providing a very simple way to keep track of progress.

## Features

- **Custom Workout Creation**: Users can input the name of their workout, add exercises, and specify sets, reps, and weights for each exercise.
- **Stopwatch Functionality**: A built-in stopwatch tracks the time elapsed during a workout. Users can pause and resume throughout their workout.
- **Exercise Management**: Exercises can be dynamically added or removed from the workout, with full control over the number of sets, reps, and weights per set.
- **Workout Preview**: Users can preview and edit the exercises they've added before completing the workout.
- **Firebase Firestore Integration**: Workouts are saved to Firebase Firestore under the user's profile, making the data persistent and retrievable across sessions.
- **Completion and Storage**: Once a workout is finished, the routine, time elapsed, and other details are stored in the Firestore database for future reference.

## How It Works

1. **Start a Workout**: Users can enter the name of a workout and begin tracking the exercises they perform.
2. **Add Exercises**: Users can add exercises to the workout by specifying the name, number of sets, and reps for each set. 
3. **Track Time**: The stopwatch feature allows users to track the duration of the workout, with controls to pause or reset the time.
4. **Preview and Edit**: Users can view and adjust exercises before saving the workout.
5. **Save to Firestore**: When finished, users can save the workout details to Firebase Firestore, including all exercise data and the time taken to complete the workout.

## Technologies Used

- **SwiftUI**: Provides the user interface and layout of the app.
- **Firebase Firestore**: Used to store workout data in the cloud.
- **State Management**: Uses `@State` and `@FirestoreQuery` to manage the dynamic UI and data updates.

## Setup

1. Clone the repository.
2. Install Firebase dependencies in your project.
3. Set up a Firebase project and add Firestore database.
4. Run the app on an iOS simulator or device.

## Upcoming Features

- **Rest timer**: Allows users to set a custom time for their rest period and start the timer in between sets.
- **Schedule and Plan Workouts**: Users can premake workouts ahead of time and schedule them for certain days.
