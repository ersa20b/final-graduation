plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.graduation_med_"
    compileSdk = 35  // ✅ ثابتة

    ndkVersion = "27.0.12077973"   // ✅ نفس النسخة اللي عندك في SDK

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true   // ✅ ضروري عشان flutter_local_notifications
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.graduation_med_"
        minSdk = 23     // ✅ مهم عشان cloud_firestore
        targetSdk = 34  // ✅ ثابتة
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.22")
      coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4") // ✅ هنا مكانها الصح
}
