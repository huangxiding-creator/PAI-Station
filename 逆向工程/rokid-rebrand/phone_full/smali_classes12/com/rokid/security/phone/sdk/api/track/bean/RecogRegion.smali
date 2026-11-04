.class public Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;
.super Ljava/lang/Object;
.source "TrackModel.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\n\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\u0008\u0017\u0018\u0000 \u00162\u00020\u0001:\u0001\u0016B%\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0006\u0012\u0006\u0010\u0007\u001a\u00020\u0008\u00a2\u0006\u0002\u0010\tJ\u0006\u0010\u0011\u001a\u00020\u0008J\u0006\u0010\u0012\u001a\u00020\u0013J\u0008\u0010\u0014\u001a\u00020\u0015H\u0016R\u0011\u0010\u0005\u001a\u00020\u0006\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u000bR\u0011\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000c\u0010\rR\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000e\u0010\rR\u0011\u0010\u0007\u001a\u00020\u0008\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000f\u0010\u0010\u00a8\u0006\u0017"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;",
        "",
        "frameWidth",
        "",
        "frameHeight",
        "frameData",
        "",
        "rect",
        "Landroid/graphics/Rect;",
        "(II[BLandroid/graphics/Rect;)V",
        "getFrameData",
        "()[B",
        "getFrameHeight",
        "()I",
        "getFrameWidth",
        "getRect",
        "()Landroid/graphics/Rect;",
        "getAlignmentRect",
        "getBitmap",
        "Landroid/graphics/Bitmap;",
        "toString",
        "",
        "Companion",
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


# static fields
.field public static final Companion:Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;


# instance fields
.field private final frameData:[B

.field private final frameHeight:I

.field private final frameWidth:I

.field private final rect:Landroid/graphics/Rect;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->Companion:Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;

    return-void
.end method

.method public constructor <init>(II[BLandroid/graphics/Rect;)V
    .locals 1
    .param p1, "frameWidth"    # I
    .param p2, "frameHeight"    # I
    .param p3, "frameData"    # [B
    .param p4, "rect"    # Landroid/graphics/Rect;

    const-string v0, "frameData"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "rect"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    iput p1, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameWidth:I

    .line 21
    iput p2, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameHeight:I

    .line 22
    iput-object p3, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameData:[B

    .line 23
    iput-object p4, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->rect:Landroid/graphics/Rect;

    .line 19
    return-void
.end method


# virtual methods
.method public final getAlignmentRect()Landroid/graphics/Rect;
    .locals 2

    .line 45
    sget-object v0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->Companion:Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;

    .line 46
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->rect:Landroid/graphics/Rect;

    .line 45
    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;->alignmentRect(Landroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object v0

    return-object v0
.end method

.method public final getBitmap()Landroid/graphics/Bitmap;
    .locals 6

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->rect:Landroid/graphics/Rect;

    iget v1, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameWidth:I

    iget v2, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameHeight:I

    const v3, 0x3fcccccd    # 1.6f

    invoke-static {v0, v1, v2, v3}, Lcom/rokid/security/phone/sdk/api/utils/FaceRectUtils;->scaleRect(Landroid/graphics/Rect;IIF)Landroid/graphics/Rect;

    move-result-object v0

    .line 31
    .local v0, "finalRect":Landroid/graphics/Rect;
    sget-object v1, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->Companion:Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;

    .line 32
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameData:[B

    .line 33
    iget v3, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameWidth:I

    .line 34
    iget v4, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameHeight:I

    .line 35
    const-string v5, "finalRect"

    invoke-static {v0, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    invoke-virtual {v1, v2, v3, v4, v0}, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;->nv21ToBitmap([BIILandroid/graphics/Rect;)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    return-object v1
.end method

.method public final getFrameData()[B
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameData:[B

    return-object v0
.end method

.method public final getFrameHeight()I
    .locals 1

    .line 21
    iget v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameHeight:I

    return v0
.end method

.method public final getFrameWidth()I
    .locals 1

    .line 20
    iget v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameWidth:I

    return v0
.end method

.method public final getRect()Landroid/graphics/Rect;
    .locals 1

    .line 23
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->rect:Landroid/graphics/Rect;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 92
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "RecogRegion(frameWidth="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameWidth:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", frameHeight="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->frameHeight:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", rect="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;->rect:Landroid/graphics/Rect;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
