package com.rokid.phone.utils

import android.view.View
import android.view.animation.AlphaAnimation
import android.view.animation.Animation
import android.view.animation.Animation.AnimationListener
import android.view.animation.AnimationSet
import android.view.animation.Interpolator
import android.view.animation.LinearInterpolator
import android.view.animation.RotateAnimation
import android.view.animation.ScaleAnimation
import android.view.animation.TranslateAnimation

object AnimationUtils {

    /**
     * 创建旋转动画
     * Create a rotation animation.
     * @param fromDegrees 起始角度
     * Starting angle.
     * @param toDegrees 结束角度
     * Ending angle.
     * @param pivotX 旋转中心X轴 (相对自身比例 0f-1f)
     * Rotation center on the X axis, relative to this view (0f-1f).
     * @param pivotY 旋转中心Y轴 (相对自身比例 0f-1f)
     * Rotation center on the Y axis, relative to this view (0f-1f).
     * @param duration 动画时长(ms)
     * Animation duration in milliseconds.
     * @param repeatCount 重复次数 (-1表示无限)
     * Repeat count (-1 means infinite repetition).
     * @param repeatMode 重复模式 (RESTART/REVERSE)
     * Repeat mode (RESTART/REVERSE).
     * @param interpolator 插值器
     * Animation interpolator.
     */
    fun createRotationAnimation(
        fromDegrees: Float,
        toDegrees: Float,
        pivotX: Float = 0.5f,
        pivotY: Float = 0.5f,
        duration: Long = 500,
        repeatCount: Int = 0,
        repeatMode: Int = Animation.RESTART,
        interpolator: Interpolator = LinearInterpolator()
    ): RotateAnimation {
        return RotateAnimation(
            fromDegrees, toDegrees,
            Animation.RELATIVE_TO_SELF, pivotX,
            Animation.RELATIVE_TO_SELF, pivotY
        ).apply {
            this.duration = duration
            this.repeatCount = repeatCount
            this.repeatMode = repeatMode
            this.interpolator = interpolator
            fillAfter = true
        }
    }

    /**
     * 创建缩放动画
     * Create a scale animation.
     * @param fromX 初始X轴缩放比例
     * Initial scale on the X axis.
     * @param toX 目标X轴缩放比例
     * Target scale on the X axis.
     * @param fromY 初始Y轴缩放比例
     * Initial scale on the Y axis.
     * @param toY 目标Y轴缩放比例
     * Target scale on the Y axis.
     * @param pivotX 缩放中心X轴
     * Scaling center on the X axis.
     * @param pivotY 缩放中心Y轴
     * Scaling center on the Y axis.
     */
    fun createScaleAnimation(
        fromX: Float,
        toX: Float,
        fromY: Float,
        toY: Float,
        pivotX: Float = 0.5f,
        pivotY: Float = 0.5f,
        duration: Long = 500,
        repeatCount: Int = 0,
        repeatMode: Int = Animation.RESTART,
        interpolator: Interpolator = LinearInterpolator()
    ): ScaleAnimation {
        return ScaleAnimation(
            fromX, toX, fromY, toY,
            Animation.RELATIVE_TO_SELF, pivotX,
            Animation.RELATIVE_TO_SELF, pivotY
        ).apply {
            this.duration = duration
            this.repeatCount = repeatCount
            this.repeatMode = repeatMode
            this.interpolator = interpolator
            fillAfter = true
        }
    }

    /**
     * 创建平移动画
     * Create a translation animation.
     * @param fromXDelta X轴起始位置(相对自身)
     * Starting X position relative to this view.
     * @param toXDelta X轴目标位置(相对自身)
     * Target X position relative to this view.
     * @param fromYDelta Y轴起始位置(相对自身)
     * Starting Y position relative to this view.
     * @param toYDelta Y轴目标位置(相对自身)
     * Target Y position relative to this view.
     */
    fun createTranslateAnimation(
        fromXDelta: Float,
        toXDelta: Float,
        fromYDelta: Float,
        toYDelta: Float,
        duration: Long = 500,
        repeatCount: Int = 0,
        repeatMode: Int = Animation.RESTART,
        interpolator: Interpolator = LinearInterpolator()
    ): TranslateAnimation {
        return TranslateAnimation(
            Animation.RELATIVE_TO_SELF, fromXDelta,
            Animation.RELATIVE_TO_SELF, toXDelta,
            Animation.RELATIVE_TO_SELF, fromYDelta,
            Animation.RELATIVE_TO_SELF, toYDelta
        ).apply {
            this.duration = duration
            this.repeatCount = repeatCount
            this.repeatMode = repeatMode
            this.interpolator = interpolator
            fillAfter = true
        }
    }

    /**
     * 创建透明度动画
     * Create an alpha animation.
     * @param fromAlpha 初始透明度(0f-1f)
     * Initial opacity (0f-1f).
     * @param toAlpha 目标透明度(0f-1f)
     * Target opacity (0f-1f).
     */
    fun createAlphaAnimation(
        fromAlpha: Float,
        toAlpha: Float,
        duration: Long = 500,
        repeatCount: Int = 0,
        repeatMode: Int = Animation.RESTART,
        interpolator: Interpolator = LinearInterpolator()
    ): AlphaAnimation {
        return AlphaAnimation(fromAlpha, toAlpha).apply {
            this.duration = duration
            this.repeatCount = repeatCount
            this.repeatMode = repeatMode
            this.interpolator = interpolator
            fillAfter = true
        }
    }

    /**
     * 创建组合动画
     * Create a combined animation.
     * @param animations 动画列表
     * List of animations.
     * @param shareInterpolator 是否共享插值器
     * Whether to share the interpolator.
     */
    fun createAnimationSet(
        animations: List<Animation>,
        shareInterpolator: Boolean = true,
        interpolator: Interpolator = LinearInterpolator()
    ): AnimationSet {
        return AnimationSet(shareInterpolator).apply {
            this.interpolator = interpolator
            animations.forEach { addAnimation(it) }
        }
    }

    /**
     * 启动动画
     * Start the animation.
     * @param view 目标视图
     * Target view.
     * @param animation 动画实例
     * Animation instance.
     * @param listener 动画监听器
     * Animation listener.
     */
    fun startAnimation(
        view: View,
        animation: Animation,
        listener: AnimationListener? = null
    ) {
        // 先取消可能存在的动画
        // Cancel any existing animation first.
        view.clearAnimation()
        // 设置监听器
        // Set the listener.
        listener?.let { animation.setAnimationListener(it) }
        // 启动动画
        // Start the animation.
        view.startAnimation(animation)
    }

    /**
     * 停止视图上的所有动画
     * Stop all animations on the view.
     */
    fun stopAnimation(view: View) {
        view.clearAnimation()
    }

    // -------------------------- 常用动画快捷方法 --------------------------
    // -------------------------- Common animation shortcuts --------------------------

    /**
     * 快速创建无限旋转动画
     * Quickly create an infinitely repeating rotation animation.
     */
    fun createInfiniteRotation(duration: Long = 2000): RotateAnimation {
        return createRotationAnimation(
            fromDegrees = 0f,
            toDegrees = 360f,
            duration = duration,
            repeatCount = Animation.INFINITE
        )
    }


    /**
     * 创建旋转动画（单次播放专用）
     * Create a rotation animation for a single playback.
     * 简化配置，默认不重复，专注于单次动画场景
     * Simplify configuration with no repetition by default for single-playback use cases.
     */
    fun createSingleRotationAnimation(
        fromDegrees: Float,
        toDegrees: Float,
        pivotX: Float = 0.5f,
        pivotY: Float = 0.5f,
        duration: Long = 500,
        interpolator: Interpolator = LinearInterpolator()
    ): RotateAnimation {
        return createRotationAnimation(
            fromDegrees = fromDegrees,
            toDegrees = toDegrees,
            pivotX = pivotX,
            pivotY = pivotY,
            duration = duration,
            // 强制单次播放
            // Force a single playback.
            repeatCount = 0,
            repeatMode = Animation.RESTART,
            interpolator = interpolator
        )
    }



    /**
     * 快速创建淡入动画
     * Quickly create a fade-in animation.
     */
    fun createFadeInAnimation(duration: Long = 500): AlphaAnimation {
        return createAlphaAnimation(
            fromAlpha = 0f,
            toAlpha = 1f,
            duration = duration
        )
    }

    /**
     * 快速创建淡出动画
     * Quickly create a fade-out animation.
     */
    fun createFadeOutAnimation(duration: Long = 500): AlphaAnimation {
        return createAlphaAnimation(
            fromAlpha = 1f,
            toAlpha = 0f,
            duration = duration
        )
    }

    /**
     * 快速创建缩放进入动画
     * Quickly create a scale-in animation.
     */
    fun createScaleInAnimation(duration: Long = 500): ScaleAnimation {
        return createScaleAnimation(
            fromX = 0f,
            toX = 1f,
            fromY = 0f,
            toY = 1f,
            duration = duration
        )
    }
}
