# Retrofit + Gson
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.personalaiagent.model.** { *; }
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
# OkHttp
-dontwarn okhttp3.**
-dontwarn okio.**
