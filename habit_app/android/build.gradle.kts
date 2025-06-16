// STEP 1: Required plugins and dependencies for Android + Kotlin
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.3.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.10")
    }
}

//  STEP 2: Ensure all subprojects use correct repositories
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// STEP 3: Custom build directory (keep this if intentional)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

//  STEP 4: Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
