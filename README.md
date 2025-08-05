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

  ###### Create a desktop file
 These are typically stored in ~/.local/share/applications.   
 Create the file ``` touch fl_studyapp.desktop ```  
 Open in your editor of choice. 
 Paste this and replace with the path to your application/binary
 ```
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=/your/path/here/fl_studyapp/build/linux/x64/release/bundle/fl_studyapp
Name=Study Timer
Icon=/your/path/here/fl_studyapp/build/linux/x64/release/bundle/data/flutter_assets/assets/icons/icon.png
```
Save and make executable via ``` chmod +x fl_studyapp.desktop ```  
You may have to log in and out or restart your PC to see the icon. 
 




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

