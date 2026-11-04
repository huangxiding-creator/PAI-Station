.class public final Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;
.super Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;
.source "TrackModel.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00004\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0007\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\r\u0008\u0007\u0018\u00002\u00020\u0001BM\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0006\u0012\u0006\u0010\u0007\u001a\u00020\u0006\u0012\u0006\u0010\u0008\u001a\u00020\t\u0012\u0006\u0010\n\u001a\u00020\u000b\u0012\u0006\u0010\u000c\u001a\u00020\r\u0012\u0006\u0010\u000e\u001a\u00020\u000f\u0012\u0006\u0010\u0010\u001a\u00020\u000f\u00a2\u0006\u0002\u0010\u0011R\u0011\u0010\u0010\u001a\u00020\u000f\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0012\u0010\u0013R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0014\u0010\u0015R\u001a\u0010\u000e\u001a\u00020\u000fX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0013\"\u0004\u0008\u0017\u0010\u0018R\u0011\u0010\u000c\u001a\u00020\r\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0019\u0010\u001aR\u0011\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001b\u0010\u0015\u00a8\u0006\u001c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;",
        "Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;",
        "frameId",
        "",
        "trackId",
        "frameWidth",
        "",
        "frameHeight",
        "frameData",
        "",
        "rect",
        "Landroid/graphics/Rect;",
        "score",
        "",
        "plateNo",
        "",
        "color",
        "(JJII[BLandroid/graphics/Rect;FLjava/lang/String;Ljava/lang/String;)V",
        "getColor",
        "()Ljava/lang/String;",
        "getFrameId",
        "()J",
        "getPlateNo",
        "setPlateNo",
        "(Ljava/lang/String;)V",
        "getScore",
        "()F",
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
.field private final color:Ljava/lang/String;

.field private final frameId:J

.field private plateNo:Ljava/lang/String;

.field private final score:F

.field private final trackId:J


# direct methods
.method public constructor <init>(JJII[BLandroid/graphics/Rect;FLjava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "frameId"    # J
    .param p3, "trackId"    # J
    .param p5, "frameWidth"    # I
    .param p6, "frameHeight"    # I
    .param p7, "frameData"    # [B
    .param p8, "rect"    # Landroid/graphics/Rect;
    .param p9, "score"    # F
    .param p10, "plateNo"    # Ljava/lang/String;
    .param p11, "color"    # Ljava/lang/String;

    const-string v0, "frameData"

    invoke-static {p7, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "rect"

    invoke-static {p8, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "plateNo"

    invoke-static {p10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "color"

    invoke-static {p11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 126
    invoke-direct {p0, p5, p6, p7, p8}, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;-><init>(II[BLandroid/graphics/Rect;)V

    .line 117
    iput-wide p1, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->frameId:J

    .line 118
    iput-wide p3, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->trackId:J

    .line 123
    iput p9, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->score:F

    .line 124
    iput-object p10, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->plateNo:Ljava/lang/String;

    .line 125
    iput-object p11, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->color:Ljava/lang/String;

    .line 116
    return-void
.end method


# virtual methods
.method public final getColor()Ljava/lang/String;
    .locals 1

    .line 125
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->color:Ljava/lang/String;

    return-object v0
.end method

.method public final getFrameId()J
    .locals 2

    .line 117
    iget-wide v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->frameId:J

    return-wide v0
.end method

.method public final getPlateNo()Ljava/lang/String;
    .locals 1

    .line 124
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->plateNo:Ljava/lang/String;

    return-object v0
.end method

.method public final getScore()F
    .locals 1

    .line 123
    iget v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->score:F

    return v0
.end method

.method public final getTrackId()J
    .locals 2

    .line 118
    iget-wide v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->trackId:J

    return-wide v0
.end method

.method public final setPlateNo(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 124
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/track/bean/LPRModel;->plateNo:Ljava/lang/String;

    return-void
.end method
