package com.rokid.phone.utils

import com.rokid.phone.utils.BuildConfig


object Constants {
    //注意: appId, 需要保持唯一性,不可重复, 要求: 长度>=4 可以是 0-9 或 a-f 或者 A-F
    // Note: appId must be unique and at least 4 characters long, using 0-9, a-f, or A-F.
    const val ServerId = BuildConfig.SDK_SERVER_ID
}
