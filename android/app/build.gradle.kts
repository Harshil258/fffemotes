import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.master.fffskin"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.master.fffskin"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val keystorePropertiesFile = rootProject.file("key.properties")
            if (keystorePropertiesFile.exists()) {
                val keystoreProperties = Properties()
                keystoreProperties.load(keystorePropertiesFile.inputStream())
                keyAlias = keystoreProperties["keyAlias"] as? String ?: ""
                keyPassword = keystoreProperties["keyPassword"] as? String ?: ""
                val storePath = keystoreProperties["storeFile"] as? String
                storeFile = if (storePath != null) file(storePath) else null
                storePassword = keystoreProperties["storePassword"] as? String ?: ""
            } else {
                keyAlias = System.getenv("KEY_ALIAS") ?: ""
                keyPassword = System.getenv("KEY_PASSWORD") ?: ""
                val storeFilePath = System.getenv("KEYSTORE_PATH")
                storeFile = if (storeFilePath != null) file(storeFilePath) else null
                storePassword = System.getenv("STORE_PASSWORD") ?: ""
            }
        }
    }

    buildTypes {
        release {
            // Fallback to debug signing if the release keystore file is not configured/found
            val releaseConfig = signingConfigs.getByName("release")
            if (releaseConfig.storeFile == null || !releaseConfig.storeFile!!.exists()) {
                signingConfig = signingConfigs.getByName("debug")
            } else {
                signingConfig = releaseConfig
            }
        }
    }
}

flutter {
    source = "../.."
}
