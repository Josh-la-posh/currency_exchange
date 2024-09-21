# Keep rules for Google Play Core Split Install
#-keep class com.google.android.play.core.splitcompat.** { *; }
#-keep class com.google.android.play.core.splitinstall.** { *; }
#-keep class com.google.android.play.core.tasks.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**



# Proguard rules for Smile ID SDK
-keep class com.smileid.** { *; }
-dontwarn com.smileid.**
-dontwarn java.lang.invoke.StringConcatFactory
