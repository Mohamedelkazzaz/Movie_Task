# Movie_Task

Movie App
App Description
This is a Movie Listing iOS application that displays a list of movies fetched from a remote API. Users can browse through movies displayed in a grid layout, view detailed information about each movie, and mark movies as favorites. The app features smooth pagination, a dedicated favorites screen, and supports user interactions such as selecting movies and toggling favorites.
Architecture Summary
The app follows a Model-View-ViewModel (MVVM) architecture with dependency injection, ensuring a clean separation of concerns:

Model: Defines data structures such as Movie, FavoriteMovie, and API response models.

View: Consists of MoviesViewController, MovieCell, and other UI components handling user interface and interactions.

ViewModel: Handles business logic, data fetching, and state management (MoviesViewModel, MovieDetailsViewModel). It communicates with the view via closures or bindings.

Repository & Use Cases: Implements data fetching logic and encapsulates API interactions (MovieRepositoryImpl, FetchMovieDetailsUseCase).

Dependency Injection: Uses a DI container (DIContainer) to manage dependencies and promote testability.

Flow:

MoviesViewController binds to MoviesViewModel.

ViewModel fetches movies, manages pagination, and updates the view.

When a movie is selected, navigation to a detail view occurs, with the detail data fetched via a use case.

Trade-offs / Decisions

Use of MVVM Architecture:
Simplifies data binding and separates UI from business logic, improving testability and maintainability.


Dependency Injection:
Promotes modular code and easier testing, but adds some initial complexity.


Pagination Implementation:
Loads more movies when scrolling to the bottom, providing a seamless user experience. However, it requires careful management to avoid duplicate loads or performance issues.


Custom Collection View Layout:
Used to achieve a two-column grid with minimal spacing. For more complex layouts, a custom layout or third-party library might be necessary.


Favorites Management:
Managed locally via FavoritesManager, providing quick access and toggling. Persistency considerations (e.g., Core Data, UserDefaults) can be added later.


Image Loading:
(Assumed to be handled with a library like SDWebImage or similar.) If not, loading images asynchronously can be optimized further.


Error Handling & Loading States:
Not detailed here but should be implemented for production readiness.
