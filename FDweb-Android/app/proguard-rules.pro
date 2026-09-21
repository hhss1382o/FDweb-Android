-keep class ir.hhm.fdweb.** { *; }
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
