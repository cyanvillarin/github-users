# github-users

Made with love using SwiftUI :)

![image](https://github.com/cyanvillarin/github-users/assets/10018971/336dd3a5-44e3-48be-89e6-c2b1737d6f03)

To run properly, please do the following:
1. Select 'GitHubUsers' target
2. Go to Edit Scheme
3. Go to 'Arguments' tab
4. Add to Environment Variables with the key ```ACCESS_TOKEN```, and my personal access token to be shared on email.

   ![image](https://github.com/cyanvillarin/github-users/assets/10018971/04b03f1e-6798-4855-81ac-7150c370146b)


Runs from iOS 15 :)
- The reason is that the ```searchable()``` function can only be used from iOS 15

This project is run on:
1. Xcode 14.2 (14C18)
2. MacOS 12.6.1

No need to install Pods as they are included in the repository already.

Tools used:
1. [Canva](https://www.canva.com/) - for designing the app icon
2. [AppIcon](https://www.appicon.co/) - for generating the icons to be put in Xcode

Features:
1. Users list screen
    - Search functionality
    - Searched users saved on UserDefaults
    - Scrolling to the bottom of the list will fetch additional users
    - Displays a toast message when error occurs

2. User Details screen
    - Has username, avatar picture, followers, following, fullname, bio, and company
    - Displays repositories (excluding forked repos)
    - Scrolling to the bottom of the list will fetch additional repositories
    - Displays a toast message when error occurs

3. Repository webview
    - Displays a ```ProgressView()``` while the page is still loading
    - Display error message if failed to load the page
  
4. Unit Tests for the ViewModels only
    - UsersListViewModelTests
    - UserDetailsViewModelTests

5. Localization for both English and Japanese

   ![image](https://github.com/cyanvillarin/github-users/assets/10018971/414d5aae-30eb-4e22-89eb-e117add88782)




