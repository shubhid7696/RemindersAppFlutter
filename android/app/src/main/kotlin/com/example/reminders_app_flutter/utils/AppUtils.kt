package com.example.reminders_app_flutter.utils

import android.content.Context
import java.util.*

object AppUtils {

    fun getCurrentTimeZone(context: Context): String {
        return TimeZone.getDefault().id
    }
}