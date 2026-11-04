.class public interface abstract annotation Lcom/rokid/security/sdk/base/common/DeviceAuthAPI;
.super Ljava/lang/Object;
.source "DeviceAuthExtra.kt"

# interfaces
.implements Ljava/lang/annotation/Annotation;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;
    }
.end annotation

.annotation runtime Ljava/lang/annotation/Retention;
    value = .enum Ljava/lang/annotation/RetentionPolicy;->SOURCE:Ljava/lang/annotation/RetentionPolicy;
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u001b\n\u0002\u0008\u0002\u0008\u0087\u0002\u0018\u0000 \u00022\u00020\u0001:\u0001\u0002B\u0000\u00a8\u0006\u0003"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/DeviceAuthAPI;",
        "",
        "Companion",
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

.annotation runtime Lkotlin/annotation/Retention;
    value = .enum Lkotlin/annotation/AnnotationRetention;->SOURCE:Lkotlin/annotation/AnnotationRetention;
.end annotation


# static fields
.field public static final Companion:Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;

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

    sget-object v0, Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;

    sput-object v0, Lcom/rokid/security/sdk/base/common/DeviceAuthAPI;->Companion:Lcom/rokid/security/sdk/base/common/DeviceAuthAPI$Companion;

    return-void
.end method
