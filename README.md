# BostaTask
# Profile and Album Viewer App

This app allows users to view a profile screen with the user’s details (username and address), and a list of albums associated with the user. Upon tapping an album, the user is navigated to a second screen showing a grid of images associated with that album. The app supports searching and filtering the images by title.

## Software Stack
- **Language**: Swift
- **Architecture**: MVVM (Model-View-ViewModel)
- **Reactive Programming**: Combine/RxSwift
- **UI Framework**: UIKit
- **Networking**: Moya
- **Dependency Management**: Swift Package Manager (SPM)

## Libraries Used
- **Moya**: For API requests and response handling.
- **Combine/RxSwift**: For reactive data binding and handling asynchronous tasks.
- **CombineCocoa/RxCocoa**: For binding UIKit components to Combine/RxSwift.
- **UIKit**: For building the user interface.

## Features
1. **Profile Screen**:
   - Displays the username and address.
   - Lists all albums associated with the user.
   - Fetches user data from the API endpoint `/users` and album data from `/albums`.

2. **Album Details Screen**:
   - Displays a grid of images associated with a selected album.
   - Fetches photos data from the `/photos` endpoint.
   - Provides a search bar to filter images by their title.
   
3. **Image Viewer**:
   - On tapping any image in the album, it opens in a separate image viewer with zooming functionality.
   - Includes sharing functionality for the image.
# Clara Mounir Adly
