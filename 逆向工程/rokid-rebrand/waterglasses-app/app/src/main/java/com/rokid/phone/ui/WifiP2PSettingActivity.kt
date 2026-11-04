package com.rokid.phone.ui

import com.rokid.phone.utils.demoString

import android.net.wifi.p2p.WifiP2pDevice
import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.lifecycle.lifecycleScope
import com.rokid.phone.DeviceLinkerManager
import com.rokid.phone.R
import com.rokid.phone.base.BaseActivity
import com.rokid.phone.data.GlobalData
import com.rokid.phone.databinding.ActivityDiscoverP2pDevice2Binding
import com.rokid.phone.utils.FrameAnimationUtil
import com.rokid.phone.utils.SystemStateUtils
import com.rokid.security.phone.sdk.api.PSecuritySDK
import com.rokid.security.phone.sdk.api.wifip2p.listener.IWifiP2PClientListener
import com.rokid.security.phone.sdk.base.utils.other.ktx.collect
import com.rokid.security.phone.sdk.base.utils.other.mainScope

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/**
 * 蓝牙和p2p连接界面
 * Bluetooth and P2P connection screen.
 * 连接成功后跳转到连接成功界面
 * Navigate to the connection success screen after connecting successfully.
 */
class WifiP2PSettingActivity : BaseActivity<ActivityDiscoverP2pDevice2Binding>() {
    private val TAG = "WifiP2PSettingActivity"

    private var curStatus = PARI_PRE_STATUS
    private var mDevice: WifiP2pDevice? = null
    private val mWifiP2PClientService by lazy {
        PSecuritySDK.getWifiP2PClientService()
    }
    private var mFrameAnimationUtil: FrameAnimationUtil? = null

    private var isFindDevice = false

    override fun onInit(savedInstanceState: Bundle?) {
        initView()
    }

    companion object {
        var PARI_PRE_STATUS = "PARI_PRE_STATUS"
        var PARI_ING_STATUS = "PARI_ING_STATUS"
        var PARI_SUCCESS_STATUS = "PARI_SUCCESS_STATUS"
        var PARI_FAILED_STATUS = "PARI_FAILED_STATUS"

        var frameTime = 14

        val frameList = listOf(
            // 第一帧，持续100ms
            // The first frame lasts 100 ms.
            R.mipmap.fx_matching_000 to frameTime,
            R.mipmap.fx_matching_009 to frameTime,
            R.mipmap.fx_matching_018 to frameTime,
            R.mipmap.fx_matching_027 to frameTime,
            // 第一帧，持续100ms
            // The first frame lasts 100 ms.
            R.mipmap.fx_matching_036 to frameTime,
            R.mipmap.fx_matching_045 to frameTime,
            R.mipmap.fx_matching_054 to frameTime,
            R.mipmap.fx_matching_063 to frameTime,
            // 第一帧，持续100ms
            // The first frame lasts 100 ms.
            R.mipmap.fx_matching_072 to frameTime,
            R.mipmap.fx_matching_081 to frameTime,
            // 第一帧，持续100ms
            // The first frame lasts 100 ms.
            R.mipmap.fx_matching_090 to frameTime,
            R.mipmap.fx_matching_099 to frameTime,
            // 第一帧，持续100ms
            // The first frame lasts 100 ms.
            R.mipmap.fx_matching_108 to frameTime,
            R.mipmap.fx_matching_117 to frameTime,
        )
    }

    private var initialize = false
    private fun initView() {
        lifecycleScope.launch {
            mFrameAnimationUtil = FrameAnimationUtil(binding.ivDiscoverGif)
            // 动态创建帧列表（资源ID + 持续时间）
            // Build the frame list dynamically from resource IDs and durations.
            mFrameAnimationUtil?.initFromFrames(frameList, lifecycleScope)
            mWifiP2PClientService?.addWifiP2PClientListener(mIWifiP2PClientListener)
            CoroutineScope(Dispatchers.Main).launch {
                startDiscoverTask()
            }
            binding.ivBack.setOnClickListener {
                finish()
            }
            binding.btnPairDevice.setOnClickListener {
                if (curStatus == PARI_SUCCESS_STATUS) {
                    finish()
                    return@setOnClickListener
                }
                startDiscoverTask()
            }
            binding.tvSkip.setOnClickListener {
                finish()
            }
            GlobalData.p2pConnectState.collect(lifecycleScope) {
                curStatus = if (it) {
                    PARI_SUCCESS_STATUS
                } else {
                    PARI_FAILED_STATUS
                }
                showStatus()
            }
        }
    }

    private fun startDiscoverTask() {
        curStatus = PARI_ING_STATUS
        showStatus()
        if (mDevice == null) {
            if (!SystemStateUtils.isWifiEnabled(this)) {
                com.blankj.utilcode.util.ToastUtils.showShort(demoString(R.string.demo_wi_fi_is_off))
                return
            }
            if (!initialize) {
                isFindDevice = false
                mWifiP2PClientService?.disconnect()
                // 初始化P2p 通道
                // Initialize the P2P channel.
                mWifiP2PClientService?.initialize {
                    initialize = it.isSuccess
                    if(it.isSuccess){
                        // 开始发现设备
                        // Start device discovery.
                        mWifiP2PClientService?.startDiscoverPeers()
                    }
                }
            }
        } else {
            wifiP2pConnect(mDevice!!)
        }
    }

    private fun outTimeTask() {
        mainScope.launch {
            delay(10 * 1000)
            mWifiP2PClientService?.disconnect()
            mWifiP2PClientService?.initialize()
            if (curStatus != PARI_SUCCESS_STATUS) {
                curStatus = PARI_FAILED_STATUS
                showStatus()
            }
        }
    }

    private fun wifiP2pConnect(device: WifiP2pDevice) {
        Log.i(TAG, "wifiConnect: ")
        mDevice = device
        mWifiP2PClientService?.connectDevice(device) {}
    }

    override fun onResume() {
        super.onResume()
        if (!SystemStateUtils.isWifiEnabled(this)) {
            com.blankj.utilcode.util.ToastUtils.showShort(demoString(R.string.demo_wi_fi_is_off))
        }
    }

    private var lastConnectTime = 0L
    private var overTime = 1000L

    private val mIWifiP2PClientListener = object : IWifiP2PClientListener {
        // wifip2p 是否可用(包含数据通道)
        // Whether Wi-Fi P2P is available, including the data channel.
        override fun onWifiP2pEnabled(enabled: Boolean) {
            Log.i(TAG, "onWifiP2pEnabled ${enabled}")
            lifecycleScope.launch {
                if (enabled && mDevice != null) {
                    DeviceLinkerManager.saveP2pDevice(mDevice!!)
                }
            }
        }

        // 获取当前WifiP2pDevice 设备信息
        // Get the current WifiP2pDevice information.
        override fun onSelfDeviceAvailable(device: WifiP2pDevice) {
        }

        // 发现设备列表
        // Discovered device list.
        override fun onPeersAvailable(devices: List<WifiP2pDevice>) {
            val newDevices = devices.filter { it.deviceName.contains("Glass3_") }
            if (newDevices.isEmpty()) {
                return
            }
            var currentTime = System.currentTimeMillis()
            if (currentTime - lastConnectTime > overTime && !GlobalData.p2pConnectState.value) {
                var needDevice =
                    newDevices.firstOrNull { device -> device.deviceName == DeviceLinkerManager.getDeviceName() }
                if (needDevice != null) {
                    wifiP2pConnect(needDevice)
                    lastConnectTime = currentTime
                }
            }
        }
    }

    private fun showStatus() {
        Log.i(TAG, "showStatus: $curStatus")
        when (curStatus) {
            PARI_PRE_STATUS -> {
                binding.tvTitleDiscoverDevice.text = demoString(R.string.demo_discover_devices)
                binding.tvSubtitleDiscoverDevice.text = demoString(R.string.demo_find_the_bluetooth_name_on_the_glasses_home)
                binding.tvTitleDiscoverDevice.visibility = View.VISIBLE
                binding.tvSubtitleDiscoverDevice.visibility = View.VISIBLE
                binding.tvPairComplete.visibility = View.GONE
                binding.btnPairDevice.text = demoString(R.string.demo_pair)
                binding.ivShow.setImageResource(R.mipmap.icon_rokid_big)
                binding.ivDiscoverGif.visibility = View.GONE
            }

            PARI_ING_STATUS -> {
                binding.tvTitleDiscoverDevice.text = demoString(R.string.demo_pairing)
                binding.tvSubtitleDiscoverDevice.text = demoString(R.string.demo_please_wait)
                binding.btnPairDevice.text = demoString(R.string.demo_pairing)
                binding.tvTitleDiscoverDevice.visibility = View.VISIBLE
                binding.tvSubtitleDiscoverDevice.visibility = View.VISIBLE
                binding.tvPairComplete.visibility = View.GONE
                binding.ivDiscoverGif.visibility = View.VISIBLE
                mFrameAnimationUtil?.start()
            }

            PARI_SUCCESS_STATUS -> {
                binding.tvTitleDiscoverDevice.text = demoString(R.string.demo_paired_successfully)
                binding.tvSubtitleDiscoverDevice.visibility = View.INVISIBLE
                binding.tvPairComplete.visibility = View.VISIBLE
                binding.ivDiscoverGif.visibility = View.GONE
                completePair()
            }

            PARI_FAILED_STATUS -> {
                binding.tvTitleDiscoverDevice.text = demoString(R.string.demo_pairing_failed)
                binding.tvSubtitleDiscoverDevice.text = demoString(R.string.demo_find_the_bluetooth_name_on_the_glasses_home)
                binding.tvTitleDiscoverDevice.visibility = View.VISIBLE
                binding.tvSubtitleDiscoverDevice.visibility = View.VISIBLE
                binding.tvPairComplete.visibility = View.GONE
                binding.ivDiscoverGif.visibility = View.GONE
                binding.btnPairDevice.text = demoString(R.string.demo_retry)
            }
        }

        binding.tvDeviceName.text = DeviceLinkerManager.getDeviceName()
    }

    var completeJob: Job? = null
    var count_ = 3
    private fun completePair() {

        completeJob?.cancel()
        completeJob = lifecycleScope.launch {

            repeat(count_) { second ->
                val remainingTime = count_ - second
                binding.tvTitleDiscoverDevice.text = demoString(R.string.demo_paired_successfully)
                binding.btnPairDevice.text = demoString(R.string.demo_go_to_home, remainingTime)
                // 延迟1秒
                // Delay for one second.
                delay(1000)
            }
            finish()

        }
    }

    override fun initViewBinding(): ActivityDiscoverP2pDevice2Binding {
        return ActivityDiscoverP2pDevice2Binding.inflate(layoutInflater)
    }

    override fun onDestroy() {
        super.onDestroy()
        mWifiP2PClientService?.removeWifiP2PClientListener(mIWifiP2PClientListener)
        completeJob?.cancel()
    }

}
