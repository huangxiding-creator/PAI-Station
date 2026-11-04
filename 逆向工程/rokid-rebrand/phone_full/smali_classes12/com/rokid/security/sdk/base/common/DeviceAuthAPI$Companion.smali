.class public final Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;
.super Ljava/lang/Object;
.source "DeviceAuthExtra.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/DeviceAuthAPI;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;",
        "",
        "()V",
        "DEVICE_AUTH_RESULT",
        "",
        "PUBLIC_KEY_OK",
        "RECEIVE_PUBLIC_KEY_REPLY",
        "SEND_ENCRYPT_AUTH_MSG",
        "SEND_NONCE",
        "SEND_PUBLIC_KEY",
        "SEND_SIGNATURE",
        "SIGNATURE_VERIFICAT_RESULT",
        "sdk-base-common_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field static final synthetic $$INSTANCE:Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;

.field public static final DEVICE_AUTH_RESULT:Ljava/lang/String; = "Device_Auth_Result"

.field public static final PUBLIC_KEY_OK:Ljava/lang/String; = "PUBLIC_KEY_OK"

.field public static final RECEIVE_PUBLIC_KEY_REPLY:Ljava/lang/String; = "RECEIVE_PUBLIC_KEY_REPLY"

.field public static final SEND_ENCRYPT_AUTH_MSG:Ljava/lang/String; = "Send_Encrypt_Auth_Msg"

.field public static final SEND_NONCE:Ljava/lang/String; = "Send_Nonce"

.field public static final SEND_PUBLIC_KEY:Ljava/lang/String; = "SEND_PUBLIC_KEY"

.field public static final SEND_SIGNATURE:Ljava/lang/String; = "Send_Signature"

.field public static final SIGNATURE_VERIFICAT_RESULT:Ljava/lang/String; = "Signature_Verificat_Result"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 79
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
