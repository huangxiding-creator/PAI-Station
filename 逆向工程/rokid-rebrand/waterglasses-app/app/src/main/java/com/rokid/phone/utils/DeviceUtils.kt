package com.rokid.phone.utils

import com.rokid.phone.utils.demoString
import com.rokid.phone.R

import android.bluetooth.BluetoothProfile
import android.content.Context
import android.net.wifi.p2p.WifiP2pDevice
import android.telephony.TelephonyManager
import android.util.Log

/**
 * 将设备连接状态转换为便于展示的文本。
 * Convert device connection states into display text.
 */
object DeviceUtils {

    fun getP2PDeviceStatus(deviceStatus: Int): String {
        return when (deviceStatus) {
            WifiP2pDevice.AVAILABLE -> demoString(R.string.demo_available)
            WifiP2pDevice.INVITED -> demoString(R.string.demo_invited)
            WifiP2pDevice.CONNECTED -> demoString(R.string.demo_connected)
            WifiP2pDevice.FAILED -> demoString(R.string.demo_failed)
            WifiP2pDevice.UNAVAILABLE -> demoString(R.string.demo_unavailable)
            else -> demoString(R.string.demo_unknown)
        }
    }

    fun getBleDeviceStatus(connectionState: Int): String {
        return when (connectionState) {
            BluetoothProfile.STATE_DISCONNECTED -> demoString(R.string.demo_disconnected_3)
            BluetoothProfile.STATE_CONNECTING -> demoString(R.string.demo_connecting_3)
            BluetoothProfile.STATE_CONNECTED -> demoString(R.string.demo_connected)
            BluetoothProfile.STATE_DISCONNECTING -> demoString(R.string.demo_disconnecting)
            else -> demoString(R.string.demo_unknown_state)
        }
    }





    fun getSimCountryIso(context: Context): String {
        return try {
            val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            val simCountryIso = telephonyManager.simCountryIso
            Log.d("DeviceUtils", "SIM country ISO: $simCountryIso")
            if (simCountryIso.isNullOrEmpty()) {
                "CN"
            } else {
                simCountryIso
            }
        } catch (e: Exception) {
            Log.e("DeviceUtils","Failed to get SIM country ISO", e)
            "CN"
        }
    }

}
