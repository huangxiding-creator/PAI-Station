.class public final Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;
.super Ljava/lang/Object;
.source "OnlineRecogExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0010\u0008\n\u0002\u0008\u0008\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011R\u001a\u0010\u0012\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;",
        "",
        "()V",
        "frameId",
        "",
        "getFrameId",
        "()Ljava/lang/String;",
        "setFrameId",
        "(Ljava/lang/String;)V",
        "methodName",
        "getMethodName",
        "setMethodName",
        "mode",
        "",
        "getMode",
        "()I",
        "setMode",
        "(I)V",
        "trackId",
        "getTrackId",
        "setTrackId",
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
.field private frameId:Ljava/lang/String;

.field private methodName:Ljava/lang/String;

.field private mode:I

.field private trackId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 13
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->methodName:Ljava/lang/String;

    .line 17
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->trackId:Ljava/lang/String;

    .line 18
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->frameId:Ljava/lang/String;

    .line 12
    return-void
.end method


# virtual methods
.method public final getFrameId()Ljava/lang/String;
    .locals 1

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->frameId:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getMode()I
    .locals 1

    .line 14
    iget v0, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->mode:I

    return v0
.end method

.method public final getTrackId()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->trackId:Ljava/lang/String;

    return-object v0
.end method

.method public final setFrameId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->frameId:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setMode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 14
    iput p1, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->mode:I

    return-void
.end method

.method public final setTrackId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/RequestRecogFaceExtra;->trackId:Ljava/lang/String;

    return-void
.end method
