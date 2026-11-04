package com.rokid.phone.utils


/**
 * 全局数据单例，用来存储应用内的数据和状态
 * Global data singleton for application data and state.
 */
object AppDataManager {

    // 是否已连接 P2P
    // Whether P2P is connected.
    var isP2pConnected: Boolean = false

    // 是否已连接普通 蓝牙
    // Whether a regular Bluetooth connection is established.
    var isBtConnect: Boolean = false

    // 当前连接的蓝牙 设备名
    // Name of the currently connected Bluetooth device.
    var mBluetoothDeviceName: String? = null
    //系统版本
    // System version.
    var ioVersion: String? = null
    var deviceId: String? = null

    // 缓存的数据（比如临时存放消息列表）
    // Cached data, such as a temporary message list.
    val messageCache: MutableList<String> = mutableListOf()

    // 统一清理方法
    // Shared cleanup method.
    fun clearAll() {
        isP2pConnected = false
        isBtConnect = false
        ioVersion = null
        mBluetoothDeviceName=null
        deviceId=null
        messageCache.clear()
    }
}
