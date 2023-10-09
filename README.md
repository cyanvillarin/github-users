# github-users

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
  
    ![image](https://github.com/cyanvillarin/github-users/assets/10018971/e7e785e1-4806-4cd2-b00f-adc3dc13d22d)
    ![image](https://github.com/cyanvillarin/github-users/assets/10018971/84714432-3c56-4e8a-b1a9-6196d7476b2a)
    ![image](https://github.com/cyanvillarin/github-users/assets/10018971/183c4e3a-f214-4cb5-8e52-087e39049ab0)
    ![image](https://github.com/cyanvillarin/github-users/assets/10018971/4bfc9519-7a0a-4e94-b197-573761fff35d)

2. User Details screen
    - Has username, avatar picture, followers, following, fullname, bio, and company
    - Displays repositories (excluding forked repos)
    - Scrolling to the bottom of the list will fetch additional repositories
    - Displays a toast message when error occurs

    ![image](https://github.com/cyanvillarin/github-users/assets/10018971/bc5e1e78-ac8d-4958-b40d-b0403ae996ef)

4. Repository webview
    - Displays a ```ProgressView()``` while the page is still loading
    - Display error message if failed to load the page

    ![image](https://github.com/cyanvillarin/github-users/assets/10018971/25e30139-6317-450c-a217-91ac0de7eb8d)
  
5. Unit Tests for the ViewModels only
    - UsersListViewModelTests
    - UserDetailsViewModelTests

    ![image](https://github.com/cyanvillarin/github-users/assets/10018971/087d7713-5d67-492a-8fca-4035eb19aba6)




