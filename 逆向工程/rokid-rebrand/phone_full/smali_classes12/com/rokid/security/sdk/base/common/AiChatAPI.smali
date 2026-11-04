.class public interface abstract annotation Lcom/rokid/security/sdk/base/common/AiChatAPI;
.super Ljava/lang/Object;
.source "AiChatExtra.kt"

# interfaces
.implements Ljava/lang/annotation/Annotation;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/AiChatAPI$Companion;
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
        "Lcom/rokid/security/sdk/base/common/AiChatAPI;",
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
.field public static final BaseInfoComplete:Ljava/lang/String; = "BaseInfoComplete"

.field public static final Companion:Lcom/rokid/security/sdk/base/common/AiChatAPI$Companion;

.field public static final EndManualRecording:Ljava/lang/String; = "EndManualRecording"

.field public static final GlobalRecording:Ljava/lang/String; = "GlobalRecording"

.field public static final InspectHeartbeat:Ljava/lang/String; = "InspectHeartbeat"

.field public static final OfflineTaskBegin:Ljava/lang/String; = "OfflineTaskBegin"

.field public static final OfflineTaskEnd:Ljava/lang/String; = "OfflineTaskEnd"

.field public static final QRCodeRec:Ljava/lang/String; = "QRCodeRec"

.field public static final ResetSessionId:Ljava/lang/String; = "ResetSessionId"

.field public static final RrecordEndTime:Ljava/lang/String; = "recordEndTime"

.field public static final StartManualRecording:Ljava/lang/String; = "StartManualRecording"

.field public static final TakePicture:Ljava/lang/String; = "TakePicture"

.field public static final ToGuideAIChatBegin:Ljava/lang/String; = "guideAIChatBegin"

.field public static final ToGuideAIChatEnd:Ljava/lang/String; = "guideAIChatEnd"

.field public static final ToInspect:Ljava/lang/String; = "ToInspect"

.field public static final mirrorAsrFinal:Ljava/lang/String; = "mirrorAsrFinal"

.field public static final mirrorAsrPartial:Ljava/lang/String; = "mirrorAsrPartial"

.field public static final mirrorError:Ljava/lang/String; = "mirrorError"

.field public static final mirrorImage:Ljava/lang/String; = "mirrorImage"

.field public static final mirrorQuestion:Ljava/lang/String; = "mirrorQuestion"

.field public static final mirrorResponse:Ljava/lang/String; = "mirrorResponse"

.field public static final onAiIntent:Ljava/lang/String; = "onAiIntent"

.field public static final onAiResponse:Ljava/lang/String; = "onAiResponse"

.field public static final onError:Ljava/lang/String; = "onError"

.field public static final startAiChat:Ljava/lang/String; = "startAiChat"

.field public static final stopAiChat:Ljava/lang/String; = "stopAiChat"

.field public static final toAiChat:Ljava/lang/String; = "toAiChat"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/base/common/AiChatAPI$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/base/common/AiChatAPI$Companion;

    sput-object v0, Lcom/rokid/security/sdk/base/common/AiChatAPI;->Companion:Lcom/rokid/security/sdk/base/common/AiChatAPI$Companion;

    return-void
.end method
