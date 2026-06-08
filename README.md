# Reader Tracker 📚

A beautifully designed, feature-rich Flutter application for tracking and managing your reading list. Search for books, view details, and keep track of your saved and favorite books all in one place.

## ✨ Features

- **Search & Discover:** Easily search for any book title or author. The app fetches real-time data to display book covers, titles, and authors in an elegant grid view.
- **Detailed Insights:** Dive into a book's specifics. View the cover, full title, authors, publication date, page count, language, and a comprehensive description.
- **Save for Later:** Found a book you want to read? Add it to your "Saved" list with a single tap.
- **Favorites List:** Keep a curated list of your all-time favorite reads. Easily mark books as favorites from your saved list.
- **Manage Collections:** Effortlessly remove books from your saved or favorite lists as your reading journey progresses using the intuitive delete functionality.
- **Local Storage:** Built with Flutter using clean UI principles and local data persistence using SQLite (`sqflite`) ensuring your lists are always available.

## 📸 Screenshots

_(To display these screenshots on GitHub, create a `screenshots` folder in your project root and save your images there with the corresponding names)_

<p align="center">
  <img src="screenshots/home.png" width="22%" alt="Home Screen"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/details.png" width="22%" alt="Book Details"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/saved.png" width="22%" alt="Saved Screen"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screenshots/favorites.png" width="22%" alt="Favorite Screen"/>
</p>

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (^3.12.1 or newer)
- Dart SDK

### Installation

1.  Clone the repository:
    ```sh
    git clone https://github.com/your_username/reader_tracker.git
    ```
2.  Navigate to the project directory:
    ```sh
    cd reader_tracker
    ```
3.  Install dependencies:
    ```sh
    flutter pub get
    ```
4.  Run the application:
    ```sh
    flutter run
    ```

## 🛠️ Technology Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Language:** [Dart](https://dart.dev/)
- **Local Database:** [sqflite](https://pub.dev/packages/sqflite)
- **Networking:** [http](https://pub.dev/packages/http) (for fetching book data)
