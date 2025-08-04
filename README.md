## Pomodoro Timer app

### Use: 
- click the play button to start the timer
- adjust the timer and break timer lengths by clicking the respective icons in the top bar
- switch between system, dark and light mode at the click of a button
- add your own custom background images from your files, name, rename and delete them


### Building:
1. Install Flutter on your Device using [this guide](https://docs.flutter.dev/get-started/install)
2. Clone the repository to your PC
``` git clone https://github.com/ReadingOwl3000/fl_studyapp ```

3. Navigate to the folder fl_studyapp in your terminal 

4. Now, you can build the app

##### Linux
on linux, run:  
 ``` flutter build linux ```

 This will generate a binary file.

 Navigate to the directory (should be in the flutter build command output).

 Make the binary executable using  ``` chmod +x .fl_studyapp ```

 I recommend using a desktop file for a better experience, instructions / example coming soon!





##### Android/APK
 To get an apk you can install on your android phone, use: 

 ``` flutter build apk ```

 then install the app on your phone (if you don't know how, use a guide like [this](https://www.xda-developers.com/how-to-sideload-install-android-app-apk/) )

##### Other platforms
 Note that other platforms are not tested by me for bugs or compatibility, but feel free to use them anyway.

Refer to the [flutter docs](https://docs.flutter.dev) for more help
 


### Credits: 
This article for help with the timer logic:
https://medium.com/@dtejaswini.06/building-a-countdown-timer-in-flutter-with-animation-a-step-by-step-guide-9ffa91e3d26e

