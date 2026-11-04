.class public final Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;
.super Ljava/lang/Object;
.source "VideoStreamExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u000b\n\u0002\u0010\u000b\n\u0002\u0008\r\n\u0002\u0010\u0007\n\u0002\u0008\u0006\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001e\u0010\u0003\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001e\u0010\t\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001e\u0010\u000c\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001e\u0010\u000f\u001a\u00020\u00108\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000f\u0010\u0011\"\u0004\u0008\u0012\u0010\u0013R\u001e\u0010\u0014\u001a\u00020\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0015\u0010\u0006\"\u0004\u0008\u0016\u0010\u0008R\"\u0010\u0017\u001a\u0004\u0018\u00010\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u0010\n\u0002\u0010\u001c\u001a\u0004\u0008\u0018\u0010\u0019\"\u0004\u0008\u001a\u0010\u001bR\"\u0010\u001d\u001a\u0004\u0018\u00010\u001e8\u0006@\u0006X\u0087\u000e\u00a2\u0006\u0010\n\u0002\u0010#\u001a\u0004\u0008\u001f\u0010 \"\u0004\u0008!\u0010\"\u00a8\u0006$"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;",
        "",
        "()V",
        "bitrate",
        "",
        "getBitrate",
        "()I",
        "setBitrate",
        "(I)V",
        "fps",
        "getFps",
        "setFps",
        "height",
        "getHeight",
        "setHeight",
        "isARMixEnabled",
        "",
        "()Z",
        "setARMixEnabled",
        "(Z)V",
        "width",
        "getWidth",
        "setWidth",
        "zoomLevel",
        "getZoomLevel",
        "()Ljava/lang/Integer;",
        "setZoomLevel",
        "(Ljava/lang/Integer;)V",
        "Ljava/lang/Integer;",
        "zoomRatio",
        "",
        "getZoomRatio",
        "()Ljava/lang/Float;",
        "setZoomRatio",
        "(Ljava/lang/Float;)V",
        "Ljava/lang/Float;",
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
.field private bitrate:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "bitrate"
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

.field private isARMixEnabled:Z
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "isARMixEnabled"
    .end annotation
.end field

.field private width:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "width"
    .end annotation
.end field

.field private zoomLevel:Ljava/lang/Integer;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "zoomLevel"
    .end annotation
.end field

.field private zoomRatio:Ljava/lang/Float;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "zoomRatio"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    const/16 v0, 0x14

    iput v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->fps:I

    .line 51
    const v0, 0x4f1a00

    iput v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->bitrate:I

    .line 57
    const/4 v0, -0x1

    iput v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->width:I

    .line 60
    iput v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->height:I

    .line 39
    return-void
.end method


# virtual methods
.method public final getBitrate()I
    .locals 1

    .line 51
    iget v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->bitrate:I

    return v0
.end method

.method public final getFps()I
    .locals 1

    .line 48
    iget v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->fps:I

    return v0
.end method

.method public final getHeight()I
    .locals 1

    .line 60
    iget v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->height:I

    return v0
.end method

.method public final getWidth()I
    .locals 1

    .line 57
    iget v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->width:I

    return v0
.end method

.method public final getZoomLevel()Ljava/lang/Integer;
    .locals 1

    .line 45
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->zoomLevel:Ljava/lang/Integer;

    return-object v0
.end method

.method public final getZoomRatio()Ljava/lang/Float;
    .locals 1

    .line 42
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->zoomRatio:Ljava/lang/Float;

    return-object v0
.end method

.method public final isARMixEnabled()Z
    .locals 1

    .line 54
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->isARMixEnabled:Z

    return v0
.end method

.method public final setARMixEnabled(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 54
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->isARMixEnabled:Z

    return-void
.end method

.method public final setBitrate(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 51
    iput p1, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->bitrate:I

    return-void
.end method

.method public final setFps(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 48
    iput p1, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->fps:I

    return-void
.end method

.method public final setHeight(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 60
    iput p1, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->height:I

    return-void
.end method

.method public final setWidth(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 57
    iput p1, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->width:I

    return-void
.end method

.method public final setZoomLevel(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/Integer;

    .line 45
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->zoomLevel:Ljava/lang/Integer;

    return-void
.end method

.method public final setZoomRatio(Ljava/lang/Float;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/Float;

    .line 42
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/GlassVideoStreamParam;->zoomRatio:Ljava/lang/Float;

    return-void
.end method
