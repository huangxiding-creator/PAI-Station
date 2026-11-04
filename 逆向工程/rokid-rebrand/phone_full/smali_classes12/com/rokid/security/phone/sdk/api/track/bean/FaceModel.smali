.class public final Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;
.super Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;
.source "TrackModel.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0007\n\u0002\u0008\n\u0008\u0007\u0018\u00002\u00020\u0001BE\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0006\u0012\u0006\u0010\u0007\u001a\u00020\u0008\u0012\u0006\u0010\t\u001a\u00020\n\u0012\u0006\u0010\u000b\u001a\u00020\u000c\u0012\u0006\u0010\r\u001a\u00020\u000c\u0012\u0006\u0010\u000e\u001a\u00020\n\u00a2\u0006\u0002\u0010\u000fR\u0011\u0010\u000b\u001a\u00020\u000c\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0010\u0010\u0011R\u0011\u0010\u000e\u001a\u00020\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0012\u0010\u0013R\u0011\u0010\r\u001a\u00020\u000c\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0014\u0010\u0011R\u0011\u0010\t\u001a\u00020\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0015\u0010\u0013\u00a8\u0006\u0016"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;",
        "Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;",
        "frameWidth",
        "",
        "frameHeight",
        "frameData",
        "",
        "rect",
        "Landroid/graphics/Rect;",
        "trackId",
        "",
        "faceScore",
        "",
        "iqaScore",
        "frameId",
        "(II[BLandroid/graphics/Rect;JFFJ)V",
        "getFaceScore",
        "()F",
        "getFrameId",
        "()J",
        "getIqaScore",
        "getTrackId",
        "sdk-api_release"
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
.field private final faceScore:F

.field private final frameId:J

.field private final iqaScore:F

.field private final trackId:J


# direct methods
.method public constructor <init>(II[BLandroid/graphics/Rect;JFFJ)V
    .locals 1
    .param p1, "frameWidth"    # I
    .param p2, "frameHeight"    # I
    .param p3, "frameData"    # [B
    .param p4, "rect"    # Landroid/graphics/Rect;
    .param p5, "trackId"    # J
    .param p7, "faceScore"    # F
    .param p8, "iqaScore"    # F
    .param p9, "frameId"    # J

    const-string v0, "frameData"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "rect"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 111
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;-><init>(II[BLandroid/graphics/Rect;)V

    .line 106
    iput-wide p5, p0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->trackId:J

    .line 107
    iput p7, p0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->faceScore:F

    .line 108
    iput p8, p0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->iqaScore:F

    .line 109
    iput-wide p9, p0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->frameId:J

    .line 101
    return-void
.end method


# virtual methods
.method public final getFaceScore()F
    .locals 1

    .line 107
    iget v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->faceScore:F

    return v0
.end method

.method public final getFrameId()J
    .locals 2

    .line 109
    iget-wide v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->frameId:J

    return-wide v0
.end method

.method public final getIqaScore()F
    .locals 1

    .line 108
    iget v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->iqaScore:F

    return v0
.end method

.method public final getTrackId()J
    .locals 2

    .line 106
    iget-wide v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceModel;->trackId:J

    return-wide v0
.end method
