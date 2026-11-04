.class public final Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;
.super Ljava/lang/Object;
.source "VideoStreamExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0007\n\u0002\u0008\u0006\n\u0002\u0010\u0008\n\u0002\u0008\u000e\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\"\u0010\u0003\u001a\u0004\u0018\u00010\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u0010\n\u0002\u0010\t\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001e\u0010\n\u001a\u00020\u000b8\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000c\u0010\r\"\u0004\u0008\u000e\u0010\u000fR\u001e\u0010\u0010\u001a\u00020\u000b8\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\r\"\u0004\u0008\u0012\u0010\u000fR\u001e\u0010\u0013\u001a\u00020\u000b8\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0014\u0010\r\"\u0004\u0008\u0015\u0010\u000fR\u001e\u0010\u0016\u001a\u00020\u000b8\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0017\u0010\r\"\u0004\u0008\u0018\u0010\u000f\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;",
        "",
        "()V",
        "appliedZoomRatio",
        "",
        "getAppliedZoomRatio",
        "()Ljava/lang/Float;",
        "setAppliedZoomRatio",
        "(Ljava/lang/Float;)V",
        "Ljava/lang/Float;",
        "cameraZoomCapabilities",
        "",
        "getCameraZoomCapabilities",
        "()I",
        "setCameraZoomCapabilities",
        "(I)V",
        "fps",
        "getFps",
        "setFps",
        "height",
        "getHeight",
        "setHeight",
        "width",
        "getWidth",
        "setWidth",
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
.field private appliedZoomRatio:Ljava/lang/Float;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "appliedZoomRatio"
    .end annotation
.end field

.field private cameraZoomCapabilities:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "cameraZoomCapabilities"
    .end annotation
.end field

.field private fps:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "fps"
    .end annotation
.end field

.field private height:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "height"
    .end annotation
.end field

.field private width:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "width"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    const/4 v0, 0x1

    iput v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->cameraZoomCapabilities:I

    .line 81
    const/16 v0, 0x14

    iput v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->fps:I

    .line 66
    return-void
.end method


# virtual methods
.method public final getAppliedZoomRatio()Ljava/lang/Float;
    .locals 1

    .line 72
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->appliedZoomRatio:Ljava/lang/Float;

    return-object v0
.end method

.method public final getCameraZoomCapabilities()I
    .locals 1

    .line 69
    iget v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->cameraZoomCapabilities:I

    return v0
.end method

.method public final getFps()I
    .locals 1

    .line 81
    iget v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->fps:I

    return v0
.end method

.method public final getHeight()I
    .locals 1

    .line 78
    iget v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->height:I

    return v0
.end method

.method public final getWidth()I
    .locals 1

    .line 75
    iget v0, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->width:I

    return v0
.end method

.method public final setAppliedZoomRatio(Ljava/lang/Float;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/Float;

    .line 72
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->appliedZoomRatio:Ljava/lang/Float;

    return-void
.end method

.method public final setCameraZoomCapabilities(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 69
    iput p1, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->cameraZoomCapabilities:I

    return-void
.end method

.method public final setFps(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 81
    iput p1, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->fps:I

    return-void
.end method

.method public final setHeight(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 78
    iput p1, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->height:I

    return-void
.end method

.method public final setWidth(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 75
    iput p1, p0, Lcom/rokid/security/sdk/base/common/VideoStreamResolutionChange;->width:I

    return-void
.end method
