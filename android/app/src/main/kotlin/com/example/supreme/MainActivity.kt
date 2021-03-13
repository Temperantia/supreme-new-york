package com.example.supreme

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.webkit.WebView

class MainActivity: FlutterActivity() {
   private val CHANNEL = "samples.flutter.dev/battery"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      // Note: this method is invoked on the main thread.
      call, result ->
      if (call.method == "getBatteryLevel") {
        getBatteryLevel(call.argument<String>("path") as String)
      } else {
        result.notImplemented()
      }
    }
  }

  private fun getBatteryLevel(path: String) {
    WebView.setDataDirectorySuffix(path)
  }

}
