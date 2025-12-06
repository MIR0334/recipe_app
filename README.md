It was very fun making this project, although I missed out on the project proposal, I will list down in detail everything about this app and my throught process. Have fun!


🍽️ Flutter Recipe App

A simple and elegant mobile recipe application built using **Dart** and **Flutter** as part of a Mobile Application Development project.  
The app allows users to browse recipes by category, add their own recipes with photos, mark favourites, and view detailed cooking instructions.

---

## 📱 Features

### ✔ Core Features
- Category-based recipe browsing (Breakfast, Lunch, Dinner, Workout, Own Recipe)
- Recipe detail screen with ingredients, steps, description, and cooking time
- Add your own recipe:
  - Recipe name
  - Description
  - Ingredients
  - Steps
  - Cooking time
  - **Take a photo using device camera**
- Favourites system (add/remove)
- Delete recipes with confirmation dialog
- **Search bar** for filtering recipes by title
- **Sort menu**:
  - Default order
  - A–Z
  - Z–A

---

## 🧠 State & Data Management
- Uses **Provider + ChangeNotifier** for state management
- Stores all user data locally using **SharedPreferences**, including:
  - User-added recipes
  - Favourites
  - Image file paths

This ensures all recipes persist after app restart.

---

## 🧰 Additional Competencies Implemented
- 📦 Local storage (SharedPreferences)
- 📸 Camera access (image_picker)
- ✨ Custom animations (Hero animation + favourite star scaling)
- 🔍 Search and sorting UX improvements

---

## 🧪 Testing
This project includes both **unit tests** and **widget tests**:

### Unit Tests
- Adding a recipe
- Deleting a recipe
- Toggling favourites

### Widget Tests
- Category recipe list renders correctly
- Tapping a recipe navigates to the detail screen

Run all tests with: flutter test


## 📂 The Project Structure:

lib/
├── models/
│   └── recipe.dart                # Defines the Recipe model with ingredients, steps, time, and optional image path
│
├── providers/
│   └── recipe_provider.dart       # Main app state manager using Provider + SharedPreferences for persistence
│
├── screens/
│   ├── welcome_screen.dart        # First screen with welcome message and "Let's Begin" navigation button
│   ├── category_screen.dart       # Displays recipe categories with themed UI and emojis
│   ├── recipe_list_screen.dart    # Shows recipes for a selected category + search + sorting + delete confirmation
│   ├── recipe_detail_screen.dart  # Displays full recipe details including ingredients, steps, time, and photo
│   └── add_recipe_screen.dart     # Form to add a new recipe with image capture, description, time, ingredients, steps
│
├── widgets/
│   └── recipe_card.dart           # Reusable card widget for displaying recipes with favourite & delete actions
│
├── data/
│   └── sample_recipes.dart        # Contains default sample recipes for each category on first launch
│
└── main.dart                      # App entry point configuring Provider and setting up routes/navigation


## ▶️ Running the App

Make sure dependencies are installed:

flutter pub get

Then run the app:

flutter run

---

## 👤 Author
Mir Umar Ahmed – Mobile Application Development Student  
Project built using Flutter, Dart, and Android Studio.
