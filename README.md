# augmented_anatomy

A new Flutter project.

## PLUGIN ARCORE
en android/app/src/main/AndroidManifest.xml
```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.augmented_anatomy" xmlns:tools="http://schemas.android.com/tools" >

    <uses-permission android:name="android.permission.CAMERA" />

    <!-- Limits app visibility in the Google Play Store to ARCore supported devices
        (https://developers.google.com/ar/devices). -->
    <uses-feature android:name="android.hardware.camera.ar" />

    <application>

     <!-- "AR Required" app, requires "Google Play Services for AR" (ARCore)
         to be installed, as the app does not include any non-AR features. -->
        <meta-data android:name="com.google.ar.core" android:value="required" tools:replace="android:value"/> 

    </application>




</manifest>
```

en android/app/build.gradle

```
    defaultConfig {
        
        minSdkVersion 24

    }

dependencies {

    implementation 'com.google.ar:core:1.33.0'
    implementation 'com.google.ar.sceneform.ux:sceneform-ux:1.8.0'

}

```

en pubspec.yaml

```
dependencies:
  flutter:
    sdk: flutter
  arcore_flutter_plugin: ^0.1.0
```


