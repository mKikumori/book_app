# book_app
Repository made to develop and store the code for a reading management application.

# Architecture
This project follows the MVVM (Model-View-ViewModel) architectural pattern to ensure a clean separation of concerns, maintainability, and scalability.

# MVVM Breakdown:
1. **Model:** This layer is responsible for the data and business logic of the application. It interacts with external resources, such as APIs or databases, to retrieve or manipulate data.

2. **View:** The **View** layer represents the UI and displays the data that is passed from the **ViewModel**. It is mostly passive and doesn't handle business logic.

3. **ViewModel:** The **ViewModel** is responsible for managing the application's state, handling presentation logic, and preparing data for the **View** to display. It communicates with the **Model** layer to fetch and process data.


# Naming Conventions
**Models:**
Use singular names with no extra suffix, ending with .dart.
Example: For a user model, create user.dart in the /models folder.

**Views:**
Use singular names followed by _view.dart.
Example: For a welcome UI, create welcome_view.dart in the /views folder.

**ViewModels:**
Use singular names followed by _view_model.dart.
Example: For a welcome UI, create welcome_view_model.dart in the /view_models folder.

**Widgets:**
Use the component name followed by _widget.dart.
Example: For a list component, create list_widget.dart in the /widgets folder.

**Stores:**
Use the global state name followed by _store.dart.
Example: For media progress state, create media_progress_store.dart in the /stores folder.

**Services: (to be decided)**
Use the service name followed by _service.dart.
Example: For an audio fetch service, create audio_service.dart in the /services folder.


# Folder Structure
```plaintext
lib/
├── main.dart                    # Entry point of the app
├── helper/                      # App-wide configuration (theme, routes, etc.)
│   ├── router_transition.dart    
│   └── app_config.dart          
├── models/                      # Data models (e.g., user, book, bookshelf)
│   ├── user.dart                
│   ├── book.dart               
│   ├── bookshelf.dart            
│   └── ...                    # Continue adding extra models as needed
├── services/                    # API services and data logic
│   ├── auth_service.dart        
│   ├── db_service.dart       
│   └── ...                    # Continue adding extra services as needed
├── view_models/                 # ViewModel layer (local state management)
│   ├── welcome/  
│   │   └── welcome_view_model.dart  
│   ├── auth/                 
│   │   ├── signup_view_model.dart
│   │   ├── signin_view_model.dart
│   │   ├── reset_password_view_model.dart
│   │   └── ...                # Continue adding extra auth view models as needed
│   ├── app/ 
│   │   ├── home_view_model.dart
│   │   ├── book_view_model.dart  
│   │   └── ...                # Continue adding extra app view models as needed
├── views/                      # View layer (UI components/pages)
│   ├── welcome/                # Launch-related views
│   │   └── welcome_view.dart   # Welcome page
│   ├── auth/                   # Authentication-related views
│   │   ├── signup_view.dart         # Sign up page
│   │   ├── signin_view.dart         # Sign in page
│   │   ├── reset_password_view.dart # Reset password page
│   │   └── ...                # Continue adding extra auth views as needed
│   ├── app/                    # Main app related views
│   │   ├── home_view.dart       
│   │   ├── book_view.dart      
│   │   ├── favorites_view.dart   
│   │   ├── categories_view.dart   
│   │   └── ...                # Continue adding extra app views as needed
├── widgets/                    # Reusable UI components
│   ├── custom_button_widget.dart       # Reusable button widget
│   ├── custom_text_field_widget.dart   # Reusable text field widget
│   └── ...                # Continue adding extra widgets as needed
└── tests/                      # Unit tests (mainly for service logic)
│   ├── services/ 
│   │   ├── category_service_test.dart
│   │   └── ...                # Continue adding extra tests as needed
│   ├── widgets/ 
│   │   ├── category_item_widget_test.dart
│   │   └── ...                # Continue adding extra tests as needed
```

# Branches Structure
```plaintext
├── main                         # The entry point for the project and 
|   │                            # where the stable and production-ready code is maintained
|   │
|   ├── develop/                 # Used for integration before changes are merged into Main
|   |      |                     # to reduce chances of merging problems
|   |      |
|   |      └── "views"/          # Branch for developing all features and views of the app
|   |                            # At every release it's merged into uppper branches adn then deleted
|   |                            # 'Views' is a placeholder, it should have the name of the views being developed
```

# Workflow & Testing Guide

This document outlines the **branching strategy** and **testing workflow** to ensure efficient feature development, staging, and production releases.

## Overview Steps
1. New features are developed in the `*****_view` such as `home_view` branch.  
2. Once unit and/or widget testing is successful, the code is pushed to the `develop` branch (staging).  
3. QA testers conduct **integration testing** and **usability testing**.  
   - If issues are found, developers fix them in the respective feature branch and repeat step 2.  
4. If no issues are found, the `develop` branch is merged into `main`.  
   - The `main` branch is used for external releases. 
---

## Branching Workflow
We follow a **structured Git workflow** to ensure smooth collaboration and stability.

### 1. Feature Development (`feature-branch`)
- Developers **switch to a feature branch** from `develop` to work on new features.

  ```sh
  git checkout home_view
  git pull origin home_view
  ```

-  **Testing During Feature Development**  
  - **Unit Testing** (e.g., services, models)
  - **Widget Testing** (UI components in isolation)

  ```sh
  flutter test test/services/category_service_test.dart
  flutter test test/widgets/category_item_test.dart
  ```

- **Once the feature is completed and tested, push it to GitHub and create a pull request to `develop`.**

  ```sh
  git push origin home_view
  ```

- **After the pull request is reviewed and merged, switch back to `develop`.**
  ```sh
  git checkout develop
  git pull origin develop
  ```

---

### 2. Staging (`develop` branch)
- The `develop` branch is the **staging area** before production.
- After testing all merged features, `develop` is reviewed and prepared for release.

  ```sh
  git checkout develop
  git pull origin develop
  ```

- **If more fixes are needed, developers return to feature branches.**
- **Once `develop` is stable, merge it into `main`.**

---

### 3. Production Release (`main` branch)
- Once everything is **stable and ready for release**, `develop` is merged into `main`.

  ```sh
  git checkout main
  git pull origin main
  git merge develop --no-ff
  git push origin main
  ```

- **`main` should always be production-ready.**
- **Only merge into `main` when a release is confirmed.**

---

## Best Practices
- **Always switch to an existing feature branch (do not create new ones).**
- **Run unit and widget tests before merging into `develop`.**
- **Never push directly to `main`**; always use `develop` as the middle point.
- **Keep branches updated before merging:**
  ```sh
  git checkout develop
  git pull origin develop
  git checkout home_view
  git rebase develop
  ```
- **Always test before releasing to `main`.**

---

## Summary Table
| Stage | Branch | Purpose | Command |
|--------|--------|-----------|-----------|
| **Feature Development** | `home_view` (or another feature branch) | Work on a feature | `git checkout home_view` → `git push origin home_view` |
| **Staging (Middle Point)** | `develop` | Pre-release staging for internal tester | Pull request from feature branch |
| **Production Release** | `main` | Industry partner release | `git merge develop --no-ff` |

---