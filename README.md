![Static Badge](https://img.shields.io/badge/Version--V2-2?style=for-the-badge)

![Static Badge](https://img.shields.io/badge/Languaje-Dart-a?style=for-the-badge&logo=dart&color=2bb7f6) 
![Static Badge](https://img.shields.io/badge/framework-Flutter-a?style=for-the-badge&logo=Flutter&color=00b4a9)

![Static Badge](https://img.shields.io/badge/DB-Firebase-a?style=for-the-badge&logo=Firebase&color=f88c12)
![Static Badge](https://img.shields.io/badge/Source_code_editor-VsCode-a?style=for-the-badge&logo=Visual%20studio%20code&color=0081c2)

![Static Badge](https://img.shields.io/badge/Emulator-Android_Studio-a?style=for-the-badge&logo=Android%20studio&color=3ddc84)



# AMCA

<div style="display: flex;">
    <div style="flex: 1;">
        <img src='https://i.imgur.com/B9yYopR.png' alt="Descripción de la imagen" style="width:200px; height:200px;">
    </div>
    <div style="flex: 1;">
        AMCA is a mobile application designed to facilitate financial management and crop monitoring in the agricultural and livestock sector.
        It allows users to enter detailed information about their crops, including data related to costs, expenses and production. This information is securely stored in a database and used to provide crop management and analysis functionalities. AMCA is aimed at both professional farmers and gardening enthusiasts, and offers an intuitive and efficient interface to monitor crop profitability.
    </div>
</div>


# Required Resources
1. Download and install [Node.js](https://nodejs.org/en/download/).
2. Download Git from the [official website](https://git-scm.com/downloads) and follow the installation instructions as well as user configuration.
3. Download [Visual Studio Code](https://code.visualstudio.com/download) and then install the following plugins:
   1. Flutter
   2. Dart
4. Download [Android Studio](https://developer.android.com/studio?hl=en) for Android app development.



# Repository.
## Clone Repository.
1. Access the [GitHub repository](https://github.com/AMCAsimulagro/amca).
2. Clone the repository into a desired folder using the following command in the terminal:

    ```bash
    git clone https://github.com/AMCAsimulagro/amca.git
    ```
## Bring the latest changes

```bash
    git pull origin main
```

### How to collaborate
Improvements are always welcome!

- Create a new branch `git checkout -b feature/name of improvement`
- Make the necessary adjustments within this branch and try to be specific.
- Commit to save changes `git commit -am 'NEW: X improvement added'`
- Upload changes to the repositoryUpload changes to the repository `git push origin feature/name of improvement`.
- Finally create a PR (Pull Request).
  
## Installations and Configurations
### Android Studio
1. Run the Android Studio installation.
2. During installation, select "Custom" and ensure all options are checked.
3. Once installed, open Android Studio and select "Do not import settings" on the welcome screen.
4. Access "More Actions" and select "Virtual Device Manager" to create a virtual mobile device.

### Flutter in Visual Studio Code
1. Download and install Visual Studio Code.
2. Install the Flutter plugin from the Visual Studio Code marketplace.
3. To verify the Flutter installation, press `Control + P` and type `>Flutter` in the command palette. Then select the option that includes the word "doctor".

### Dart
1. Install the Dart SDK by running the following command in the terminal (requires Node.js):

    ```bash
        choco install dart-sdk
    ```

# Create Folder Doc

``` bash
dart pub get 
dart doc
dart pub global activate dhttpd
dhttpd --path doc/api
```
- **dart pub get:**  Obtain libraries/download them `Only 1 time in the entire project`
- **art doc:** Interpret the comments and create a folder called doc/api with the codes
- **dart pub global activate dhttpd:** Update the interpretation folder
- **dhttpd --path doc/api:** Activate the local host on port 8080

For futher information go to [DartDoc Github](https://github.com/dart-lang/dartdoc/tree/main). In this you can find the official documentation and configuration on how to run and configure `Dart Doc`

---
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

datos para la llave: 
alias: amcalias
contraseña: fRJ00K23L@Y3P
