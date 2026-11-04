package com.rokid.phone.video

/**
 * 根据控制链路、数据链路和渲染状态选择最小恢复动作。
 * Choose the smallest recovery action based on the control channel, data channel, and rendering state.
 * 远端相机只在蓝牙和 P2P 均正常、并且确实收不到视频包时才允许重启。
 * Only restart the remote camera when Bluetooth and P2P are healthy and no video packets are arriving.
 */
class VideoStreamRecoveryPolicy(private val stallTimeoutMs: Long) {
    enum class Action {
        NONE,
        REPORT_BLUETOOTH_DISCONNECTED,
        REPORT_P2P_DISCONNECTED,
        RESTART_LOCAL_DECODER,
        RESTART_REMOTE_STREAM,
        REPORT_NO_DATA,
    }

    fun decide(
        bluetoothConnected: Boolean,
        p2pConnected: Boolean,
        isH264Mode: Boolean,
        hasReceivedPacket: Boolean,
        lastPacketAgeMs: Long,
        lastRenderedFrameAgeMs: Long,
        remoteRestartAvailable: Boolean,
        localDecoderRestartAvailable: Boolean,
    ): Action {
        if (!bluetoothConnected) return Action.REPORT_BLUETOOTH_DISCONNECTED
        if (!p2pConnected) return Action.REPORT_P2P_DISCONNECTED

        val packetsAreArriving = hasReceivedPacket && lastPacketAgeMs <= stallTimeoutMs
        if (isH264Mode && packetsAreArriving && lastRenderedFrameAgeMs > stallTimeoutMs) {
            return if (localDecoderRestartAvailable) Action.RESTART_LOCAL_DECODER else Action.REPORT_NO_DATA
        }
        if (!packetsAreArriving) {
            return if (remoteRestartAvailable) Action.RESTART_REMOTE_STREAM else Action.REPORT_NO_DATA
        }
        return Action.NONE
    }
}
