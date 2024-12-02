# Flutter To-Do List App with GetX
A simple Flutter application for managing a to-do list. This app demonstrates the use of GetX for state management,
making the app reactive and easy to maintain.
---
## Architectural Choices

### State Management
- **`GetX`**:
    - Handles reactive state management, dependency injection.
    - Reduces boilerplate while improving code maintainability.

### Features
Add Tasks: Users can add tasks with a title.

Mark as Complete: Tasks can be marked as complete using a checkbox.

Dynamic UI Updates: The task list updates in real-time with GetX.
Strike-through for Completed Tasks: Visual feedback for completed tasks.
Demo
### Home Screen:
Input field and Add button at the top.
List of tasks with checkboxes.
Strike-through effect for completed tasks.
#### Technologies Used
Flutter: Framework for building cross-platform applications.
---GetX StateManagement
: Lightweight and powerful state management solution for Flutter.
Installation and Setup
Clone the Repository:

bash
Copy code
git clone <repository_url>
cd flutter_todo_getx
Install Dependencies: Run the following command to install Flutter and GetX dependencies:

bash
Copy code
flutter pub get
Run the Application: Start the app using:

bash
Copy code
flutter run
Folder Structure
bash
Copy code
flutter_todo_getx/
├── lib/
│   ├── main.dart            # Entry point of the application
│   ├── todo_controller.dart # Controller managing state with GetX
│   ├── todo_list_screen.dart # UI for the to-do list
├── pubspec.yaml             # Project dependencies
How It Works
Reactive State Management:

The TodoController manages an observable list of tasks (RxList).
Changes to the list automatically update the UI using GetX's Obx widget.
Task Management:

Add a task: Enter a title in the input field and press the Add button.
Mark as complete: Toggle the checkbox for each task.