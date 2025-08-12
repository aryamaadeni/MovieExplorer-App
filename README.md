### Movie Explorer App

This project is a native iOS application built with SwiftUI that serves as a movie explorer. It fetches popular movie data from The Movie Database (TMDb) API, displays a list of movies, and provides detailed information for each one. The app is built with a focus on a modern, robust, and maintainable architecture.

#### Key Features
* Display a list of popular movies with their posters and titles.
* View detailed information for a selected movie, including its overview and release date.
* Search for movies by title.
* Offline support with local data caching.
* Pull-to-refresh functionality to fetch the latest movie data.

#### Technical Stack
* **SwiftUI:** For a declarative and modern user interface.
* **SwiftData:** For local persistence and offline caching.
* **Alamofire:** A robust library for network requests.
* **Kingfisher:** For efficient, asynchronous image downloading and caching.
* **XCTest:** For unit testing the core business logic.

#### Architecture and Design Decisions

The application is built using a clean **MVVM (Model-View-ViewModel)** architecture, which separates the UI from the business logic.

* **View (`ContentView`, `MovieDetailView`):** Declarative SwiftUI views that react to state changes.
* **ViewModel (`MovieListViewModel`):** The core of the app's logic. It handles data fetching, state management, and interaction with the persistence layer. It is built to be testable and uses `@MainActor` to ensure thread safety.
* **Model (`Movie`, `MovieListResponse`):** Simple `Codable` structs that represent the data.

**Robustness and Offline Strategy:**
The app uses **SwiftData** to implement a robust offline strategy. Upon launch, it first checks the local database for existing data. If the database is empty, it makes a network call. The data is then saved to the local store, providing a seamless user experience even when offline.

**Concurrency:**
All asynchronous operations, from network calls to data persistence, are handled using Swift's modern **`async/await`** concurrency model, which simplifies code and prevents common issues like race conditions.

**Security:**
The API key is stored securely in a `Secrets.plist` file, which is protected by a `.gitignore` entry to prevent it from being committed to the public repository. This adheres to a critical best practice for handling sensitive credentials.

#### Setup Instructions

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/YOUR_USERNAME/MovieExplorer-iOS-Challenge.git](https://github.com/YOUR_USERNAME/MovieExplorer-iOS-Challenge.git)
    cd MovieExplorer-App
    ```
2.  **Create `Secrets.plist`:** To protect the API key, create a new `Property List` file named **`Secrets.plist`** in the project's root. Add a key `tmdb_read_access_token` and set its value to your API Read Access Token. This file is included in `.gitignore` to prevent it from being committed.
3.  **Open the project:** Open the `MovieExplorer.xcodeproj` file in Xcode.
4.  **Run the app:** Select a target simulator and press **Run** (`⌘R`).

#### Tests and Code Quality

The project includes a suite of **unit tests** for the `MovieListViewModel`. These tests use a mock networking layer and an in-memory SwiftData container to verify the correctness of the app's business logic, ensuring that data is fetched and persisted as expected. The codebase is structured to be easily integrated into a **CI/CD** pipeline for automated testing and deployment.
