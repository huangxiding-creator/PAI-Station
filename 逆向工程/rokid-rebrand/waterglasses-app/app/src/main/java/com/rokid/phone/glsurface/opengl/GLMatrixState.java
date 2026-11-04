package com.rokid.phone.glsurface.opengl;

import android.opengl.Matrix;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.util.Stack;

//存储系统矩阵状态的类
// Class that stores the system matrix state.
public class GLMatrixState {
    //4x4矩阵 投影用
    // 4x4 matrix used for projection.
    private static float[] mProjMatrix = new float[16];
    //摄像机位置朝向9参数矩阵
    // Nine-parameter matrix describing the camera position and orientation.
    private static float[] mVMatrix = new float[16];
    //当前变换矩阵
    // Current transformation matrix.
    private static float[] currMatrix;
    //定位光光源位置
    // Locate the light source.
    public static float[] lightLocation = new float[]{0, 0, 0};
    public static FloatBuffer cameraFB;
    public static FloatBuffer lightPositionFB;

    //保护变换矩阵的栈
    // Stack that preserves transformation matrices.
    public static Stack<float[]> mStack = new Stack<float[]>();

    //获取不变换初始矩阵
    // Get the initial matrix with no transformations applied.
    public static void setInitStack()
    {
        currMatrix = new float[16];
        Matrix.setRotateM(currMatrix, 0, 0, 1, 0, 0);
    }

    // 保护变换矩阵
    // Save the transformation matrix.
    public static void pushMatrix()
    {
        mStack.push(currMatrix.clone());
    }

    // 恢复变换矩阵
    // Restore the transformation matrix.
    public static void popMatrix()
    {
        currMatrix = mStack.pop();
    }

    // 设置沿xyz轴移动
    // Set translation along the X, Y, and Z axes.
    public static void translate(float x, float y, float z)
    {
        Matrix.translateM(currMatrix, 0, x, y, z);
    }

    // 设置绕xyz轴移动
    // Set rotation around the X, Y, and Z axes.
    public static void rotate(float angle, float x, float y, float z)
    {
        Matrix.rotateM(currMatrix, 0, angle, x, y, z);
    }

    public static void scale(float x, float y, float z) {
        Matrix.scaleM(currMatrix, 0, x, y, z);
    }


    //设置摄像机
    // Configure the camera.
    public static void setCamera
    (
            // 摄像机位置x
            // Camera X position.
            float cx,
            // 摄像机位置y
            // Camera Y position.
            float cy,
            // 摄像机位置z
            // Camera Z position.
            float cz,
            // 摄像机目标点x
            // Camera target X coordinate.
            float tx,
            // 摄像机目标点y
            // Camera target Y coordinate.
            float ty,
            // 摄像机目标点z
            // Camera target Z coordinate.
            float tz,
            // 摄像机UP向量X分量
            // X component of the camera's up vector.
            float upx,
            // 摄像机UP向量Y分量
            // Y component of the camera's up vector.
            float upy,
            // 摄像机UP向量Z分量
            // Z component of the camera's up vector.
            float upz
    ) {
        Matrix.setLookAtM
                (
                        mVMatrix,
                        0,
                        cx,
                        cy,
                        cz,
                        tx,
                        ty,
                        tz,
                        upx,
                        upy,
                        upz
                );

        // 摄像机位置
        // Camera position.
        float[] cameraLocation = new float[3];
        cameraLocation[0] = cx;
        cameraLocation[1] = cy;
        cameraLocation[2] = cz;

        ByteBuffer llbb = ByteBuffer.allocateDirect(3 * 4);
        // 设置字节顺序
        // Set the byte order.
        llbb.order(ByteOrder.nativeOrder());
        cameraFB = llbb.asFloatBuffer();
        cameraFB.put(cameraLocation);
        cameraFB.position(0);
    }

    //设置透视投影参数
    // Set perspective projection parameters.
    public static void setProjectFrustum
    (
            // near面的left
            // Left edge of the near plane.
            float left,
            // near面的right
            // Right edge of the near plane.
            float right,
            // near面的bottom
            // Bottom edge of the near plane.
            float bottom,
            // near面的top
            // Top edge of the near plane.
            float top,
            // near面距离
            // Distance to the near plane.
            float near,
            // far面距离
            // Distance to the far plane.
            float far
    ) {
        Matrix.frustumM(mProjMatrix, 0, left, right, bottom, top, near, far);
    }

    //设置正交投影参数
    // Set orthographic projection parameters.
    public static void setProjectOrtho
    (
            // near面的left
            // Left edge of the near plane.
            float left,
            // near面的right
            // Right edge of the near plane.
            float right,
            // near面的bottom
            // Bottom edge of the near plane.
            float bottom,
            // near面的top
            // Top edge of the near plane.
            float top,
            // near面距离
            // Distance to the near plane.
            float near,
            // far面距离
            // Distance to the far plane.
            float far
    ) {
        Matrix.orthoM(mProjMatrix, 0, left, right, bottom, top, near, far);
    }

    //获取具体物体的总变换矩阵
    // Get the object's combined transformation matrix.
    public static float[] getFinalMatrix() {
        float[] mMVPMatrix = new float[16];
        Matrix.multiplyMM(mMVPMatrix, 0, mVMatrix, 0, currMatrix, 0);
        Matrix.multiplyMM(mMVPMatrix, 0, mProjMatrix, 0, mMVPMatrix, 0);
        return mMVPMatrix;
    }

    //获取具体物体的变换矩阵
    // Get the object's transformation matrix.
    public static float[] getMMatrix() {
        return currMatrix;
    }

    //设置灯光位置的方法
    // Set the light position.
    public static void setLightLocation(float x, float y, float z) {
        lightLocation[0] = x;
        lightLocation[1] = y;
        lightLocation[2] = z;
        ByteBuffer llbb = ByteBuffer.allocateDirect(3 * 4);
        // 设置字节顺序
        // Set the byte order.
        llbb.order(ByteOrder.nativeOrder());
        lightPositionFB = llbb.asFloatBuffer();
        lightPositionFB.put(lightLocation);
        lightPositionFB.position(0);
    }

    //获取摄像机朝向的矩阵
    // Get the camera orientation matrix.
    public static float[] getCaMatrix() {
        return mVMatrix;
    }

    //获取投影矩阵
    // Get the projection matrix.
    public static float[] getProjMatrix() {
        return mProjMatrix;
    }
}
