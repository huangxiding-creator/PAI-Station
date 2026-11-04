.class public interface abstract annotation Lcom/rokid/security/sdk/base/common/BusinessType;
.super Ljava/lang/Object;
.source "BusinessType.kt"

# interfaces
.implements Ljava/lang/annotation/Annotation;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/BusinessType$Companion;
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
        "Lcom/rokid/security/sdk/base/common/BusinessType;",
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
.field public static final AI_CHAT_API_ACTION:Ljava/lang/String; = "AI_CHAT_API_ACTION"

.field public static final AI_CHAT_MIRROR_ACTION:Ljava/lang/String; = "AI_CHAT_MIRROR_ACTION"

.field public static final AR_MIX_CONTROL_ACTION:Ljava/lang/String; = "ARMixControl"

.field public static final ASR_API_ACTION:Ljava/lang/String; = "ASR_ACTION"

.field public static final ASR_STREAM:Ljava/lang/String; = "ASR_STREAM"

.field public static final AUDIO_STREAM_REQ:Ljava/lang/String; = "AUDIO_STREAM_REQ"

.field public static final AUDIO_STREAM_RESP:Ljava/lang/String; = "AUDIO_STREAM_RESP"

.field public static final BLUETOOTH_RING:Ljava/lang/String; = "BLUETOOTH_RING"

.field public static final BT_BINARY_API_ACTION:Ljava/lang/String; = "BT_BINARY_API_ACTION"

.field public static final BT_FILE_API_ACTION:Ljava/lang/String; = "BT_FILE_API_ACTION"

.field public static final CERT_ACTION:Ljava/lang/String; = "Cert_ACTION"

.field public static final COLLECT_ACTION:Ljava/lang/String; = "COLLECT_ACTION"

.field public static final COLLECT_SDK_LOG_ACTION:Ljava/lang/String; = "COLLECT_SDK_LOG"

.field public static final COMMON_ACTION:Ljava/lang/String; = "COMMON_ACTION"

.field public static final CUSTOM_API_ACTION:Ljava/lang/String; = "custom_business_action"

.field public static final Companion:Lcom/rokid/security/sdk/base/common/BusinessType$Companion;

.field public static final DEVICE_AUTH:Ljava/lang/String; = "DEVICE_AUTH"

.field public static final DEVICE_CONFIG:Ljava/lang/String; = "DEVICE_CONFIG"

.field public static final DEVICE_INFO:Ljava/lang/String; = "DEVICE_INFO"

.field public static final FACE_RECO_NOTICE_2_1:Ljava/lang/String; = "FACE_RECO_NOTICE_1"

.field public static final FACE_RECO_NOTICE_2_2:Ljava/lang/String; = "FACE_RECO_NOTICE_2"

.field public static final FILE_API_ACTION:Ljava/lang/String; = "File_ACTION"

.field public static final FILE_SYSTEM_ACTION:Ljava/lang/String; = "FILE_SYSTEM_ACTION"

.field public static final HG_IDENTIFICATION_API_ACTION:Ljava/lang/String; = "HG_IDENTIFICATION_API_ACTION"

.field public static final HG_IDENTIFICATION_MIRROR_ACTION:Ljava/lang/String; = "HG_IDENTIFICATION_MIRROR_ACTION"

.field public static final HTTP_REQUEST:Ljava/lang/String; = "HTTP_REQUEST"

.field public static final HTTP_RESPONSE:Ljava/lang/String; = "HTTP_RESPONSE"

.field public static final NOTIFICATION:Ljava/lang/String; = "NOTIFICATION"

.field public static final OFFLINE_REC_ACTION:Ljava/lang/String; = "Offline_Rec_Action"

.field public static final ONLINE_REC_ACTION:Ljava/lang/String; = "Online_Rec_Action"

.field public static final P2P_CONNECT_CONTROL_ACTION:Ljava/lang/String; = "P2PConnectControl"

.field public static final PICTURE_FILE:Ljava/lang/String; = "PICTURE_FILE"

.field public static final SEND_CONFIG:Ljava/lang/String; = "SEND_CONFIG"

.field public static final TRACK_API_ACTION:Ljava/lang/String; = "TRACK_ACTION"

.field public static final TRANSLATE_API_ACTION:Ljava/lang/String; = "TRANSLATE_API_ACTION"

.field public static final TTS_API_ACTION:Ljava/lang/String; = "TTS_ACTION"

.field public static final VIDEO_264_STREAM:Ljava/lang/String; = "VIDEO_264_STREAM"

.field public static final VIDEO_FILE:Ljava/lang/String; = "VIDEO_FILE"

.field public static final VIDEO_STREAM_REQ:Ljava/lang/String; = "VIDEO_STREAM_REQ"

.field public static final VIDEO_STREAM_RESOLUTION_CHANGE:Ljava/lang/String; = "VIDEO_STREAM_RESOLUTION_CHANGE"

.field public static final VIDEO_STREAM_RESP:Ljava/lang/String; = "VIDEO_STREAM_RESP"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/base/common/BusinessType$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/BusinessType$Companion;

    sput-object v0, Lcom/rokid/security/sdk/base/common/BusinessType;->Companion:Lcom/rokid/security/sdk/base/common/BusinessType$Companion;

    return-void
.end method
