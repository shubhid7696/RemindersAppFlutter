package com.example.reminders_app_flutter

import android.util.Log
import androidx.annotation.NonNull
import com.example.reminders_app_flutter.utils.AppUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {


    private val CHANNEL = "Android_TimeZone"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        //GeneratedPluginRegistrant.registerWith(flutterEngine);
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if(call.method.equals("checkTimeZOne")){
                Log.e("############","${AppUtils.getCurrentTimeZone(this)}")
                result.success(AppUtils.getCurrentTimeZone(this))
            }
        }
    }
}
