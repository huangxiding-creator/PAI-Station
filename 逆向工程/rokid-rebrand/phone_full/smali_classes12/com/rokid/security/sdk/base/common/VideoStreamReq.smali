.class public final Lcom/rokid/security/sdk/base/common/VideoStreamReq;
.super Ljava/lang/Object;
.source "VideoStreamExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001e\u0010\u0003\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001e\u0010\t\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R \u0010\u000c\u001a\u0004\u0018\u00010\r8\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/VideoStreamReq;",
        "",
        "()V",
        "action",
        "",
        "getAction",
        "()Ljava/lang/String;",
        "setAction",
        "(Ljava/lang/String;)V",
        "tag",
        "getTag",
        "setTag",
        "videoStreamParam",
        "Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;",
        "getVideoStreamParam",
        "()Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;",
        "setVideoStreamParam",
        "(Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;)V",
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


# instance fields
.field private action:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "action"
    .end annotation
.end field

.field private tag:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "tag"
    .end annotation
.end field

.field private videoStreamParam:Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "videoStreamParam"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->tag:Ljava/lang/String;

    .line 15
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->action:Ljava/lang/String;

    .line 10
    return-void
.end method


# virtual methods
.method public final getAction()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->action:Ljava/lang/String;

    return-object v0
.end method

.method public final getTag()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->tag:Ljava/lang/String;

    return-object v0
.end method

.method public final getVideoStreamParam()Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->videoStreamParam:Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;

    return-object v0
.end method

.method public final setAction(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 15
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->action:Ljava/lang/String;

    return-void
.end method

.method public final setTag(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->tag:Ljava/lang/String;

    return-void
.end method

.method public final setVideoStreamParam(Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;

    .line 18
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/VideoStreamReq;->videoStreamParam:Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;

    return-void
.end method
