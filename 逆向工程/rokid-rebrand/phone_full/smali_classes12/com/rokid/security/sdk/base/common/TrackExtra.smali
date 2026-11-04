.class public final Lcom/rokid/security/sdk/base/common/TrackExtra;
.super Ljava/lang/Object;
.source "TrackExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\"\u0010\u0003\u001a\n\u0012\u0004\u0012\u00020\u0005\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0006\u0010\u0007\"\u0004\u0008\u0008\u0010\tR\u001c\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000c\u0010\r\"\u0004\u0008\u000e\u0010\u000fR\u001a\u0010\u0010\u001a\u00020\u0011X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0013\"\u0004\u0008\u0014\u0010\u0015R\u001a\u0010\u0016\u001a\u00020\u0017X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0018\u0010\u0019\"\u0004\u0008\u001a\u0010\u001b\u00a8\u0006\u001c"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/TrackExtra;",
        "",
        "()V",
        "faceTrack",
        "",
        "Lcom/rokid/security/sdk/base/common/outside/FaceTrack;",
        "getFaceTrack",
        "()Ljava/util/List;",
        "setFaceTrack",
        "(Ljava/util/List;)V",
        "lprTrack",
        "Lcom/rokid/security/sdk/base/common/outside/LPRTrack;",
        "getLprTrack",
        "()Lcom/rokid/security/sdk/base/common/outside/LPRTrack;",
        "setLprTrack",
        "(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;)V",
        "methodName",
        "",
        "getMethodName",
        "()Ljava/lang/String;",
        "setMethodName",
        "(Ljava/lang/String;)V",
        "mode",
        "",
        "getMode",
        "()I",
        "setMode",
        "(I)V",
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
.field private faceTrack:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/FaceTrack;",
            ">;"
        }
    .end annotation
.end field

.field private lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

.field private methodName:Ljava/lang/String;

.field private mode:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/TrackExtra;->methodName:Ljava/lang/String;

    .line 15
    return-void
.end method


# virtual methods
.method public final getFaceTrack()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/FaceTrack;",
            ">;"
        }
    .end annotation

    .line 18
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/TrackExtra;->faceTrack:Ljava/util/List;

    return-object v0
.end method

.method public final getLprTrack()Lcom/rokid/security/sdk/base/common/outside/LPRTrack;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/TrackExtra;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/TrackExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getMode()I
    .locals 1

    .line 17
    iget v0, p0, Lcom/rokid/security/sdk/base/common/TrackExtra;->mode:I

    return v0
.end method

.method public final setFaceTrack(Ljava/util/List;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/base/common/outside/FaceTrack;",
            ">;)V"
        }
    .end annotation

    .line 18
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/TrackExtra;->faceTrack:Ljava/util/List;

    return-void
.end method

.method public final setLprTrack(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    .line 19
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/TrackExtra;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/TrackExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setMode(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 17
    iput p1, p0, Lcom/rokid/security/sdk/base/common/TrackExtra;->mode:I

    return-void
.end method
