package com.rokid.phone.utils

import com.rokid.phone.utils.demoString
import com.rokid.phone.R

import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

object TimeUtils {

    // 时间戳转格式化时间（秒级）
    // Convert a timestamp in seconds to formatted time.
    fun timestampToDateTime(timestamp: Long, pattern: String = "yyyy-MM-dd HH:mm:ss"): String {
        val sdf = SimpleDateFormat(pattern, Locale.getDefault())
        return sdf.format(Date(timestamp))
    }

    fun formatDuration(millis: Long): String {
        val seconds = millis / 1000
        val minutes = seconds / 60
        val hours = minutes / 60
        val days = hours / 24

        return when {
            days > 0 -> demoString(R.string.demo_days_hours_minutes, days, hours % 24, minutes % 60)
            hours > 0 -> demoString(R.string.demo_hours_minutes_seconds, hours, minutes % 60, seconds % 60)
            minutes > 0 -> demoString(R.string.demo_minutes_seconds, minutes, seconds % 60)
            seconds >0 -> demoString(R.string.demo_seconds, seconds)
            else -> demoString(R.string.demo_ms, millis)
        }
    }
}
