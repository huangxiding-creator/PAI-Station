.class public final Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;
.super Ljava/lang/Object;
.source "RecgImageInput.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0015\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0000\u0008\u0086\u0008\u0018\u00002\u00020\u0001B%\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0006\u0012\u0006\u0010\u0007\u001a\u00020\u0008\u00a2\u0006\u0002\u0010\tJ\t\u0010\u0018\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0019\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u001a\u001a\u00020\u0006H\u00c6\u0003J\t\u0010\u001b\u001a\u00020\u0008H\u00c6\u0003J1\u0010\u001c\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u00062\u0008\u0008\u0002\u0010\u0007\u001a\u00020\u0008H\u00c6\u0001J\u0013\u0010\u001d\u001a\u00020\u001e2\u0008\u0010\u001f\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010 \u001a\u00020\u0003H\u00d6\u0001J\t\u0010!\u001a\u00020\"H\u00d6\u0001R\u001a\u0010\u0005\u001a\u00020\u0006X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u000b\"\u0004\u0008\u000c\u0010\rR\u001a\u0010\u0007\u001a\u00020\u0008X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011R\u001a\u0010\u0004\u001a\u00020\u0003X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0012\u0010\u0013\"\u0004\u0008\u0014\u0010\u0015R\u001a\u0010\u0002\u001a\u00020\u0003X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0013\"\u0004\u0008\u0017\u0010\u0015\u00a8\u0006#"
    }
    d2 = {
        "Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;",
        "",
        "width",
        "",
        "height",
        "data",
        "",
        "frame_id",
        "",
        "(II[BJ)V",
        "getData",
        "()[B",
        "setData",
        "([B)V",
        "getFrame_id",
        "()J",
        "setFrame_id",
        "(J)V",
        "getHeight",
        "()I",
        "setHeight",
        "(I)V",
        "getWidth",
        "setWidth",
        "component1",
        "component2",
        "component3",
        "component4",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "toString",
        "",
        "sdk-server_release"
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
.field private data:[B

.field private frame_id:J

.field private height:I

.field private width:I


# direct methods
.method public constructor <init>(II[BJ)V
    .locals 1
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "data"    # [B
    .param p4, "frame_id"    # J

    const-string v0, "data"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    iput p1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->width:I

    .line 8
    iput p2, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->height:I

    .line 9
    iput-object p3, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->data:[B

    .line 10
    iput-wide p4, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->frame_id:J

    .line 6
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;II[BJILjava/lang/Object;)Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;
    .locals 3

    and-int/lit8 p7, p6, 0x1

    if-eqz p7, :cond_0

    iget p1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->width:I

    :cond_0
    and-int/lit8 p7, p6, 0x2

    if-eqz p7, :cond_1

    iget p2, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->height:I

    :cond_1
    move p7, p2

    and-int/lit8 p2, p6, 0x4

    if-eqz p2, :cond_2

    iget-object p3, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->data:[B

    :cond_2
    move-object v0, p3

    and-int/lit8 p2, p6, 0x8

    if-eqz p2, :cond_3

    iget-wide p4, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->frame_id:J

    :cond_3
    move-wide v1, p4

    move-object p2, p0

    move p3, p1

    move p4, p7

    move-object p5, v0

    move-wide p6, v1

    invoke-virtual/range {p2 .. p7}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->copy(II[BJ)Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->width:I

    return v0
.end method

.method public final component2()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->height:I

    return v0
.end method

.method public final component3()[B
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->data:[B

    return-object v0
.end method

.method public final component4()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->frame_id:J

    return-wide v0
.end method

.method public final copy(II[BJ)Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;
    .locals 7

    const-string v0, "data"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    move-object v1, v0

    move v2, p1

    move v3, p2

    move-object v4, p3

    move-wide v5, p4

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;-><init>(II[BJ)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 7

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;

    iget v3, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->width:I

    iget v4, v1, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->width:I

    if-eq v3, v4, :cond_2

    return v2

    :cond_2
    iget v3, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->height:I

    iget v4, v1, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->height:I

    if-eq v3, v4, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->data:[B

    iget-object v4, v1, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->data:[B

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    return v2

    :cond_4
    iget-wide v3, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->frame_id:J

    iget-wide v5, v1, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->frame_id:J

    cmp-long v1, v3, v5

    if-eqz v1, :cond_5

    return v2

    :cond_5
    return v0
.end method

.method public final getData()[B
    .locals 1

    .line 9
    iget-object v0, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->data:[B

    return-object v0
.end method

.method public final getFrame_id()J
    .locals 2

    .line 10
    iget-wide v0, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->frame_id:J

    return-wide v0
.end method

.method public final getHeight()I
    .locals 1

    .line 8
    iget v0, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->height:I

    return v0
.end method

.method public final getWidth()I
    .locals 1

    .line 7
    iget v0, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->width:I

    return v0
.end method

.method public hashCode()I
    .locals 4

    iget v0, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->width:I

    invoke-static {v0}, Ljava/lang/Integer;->hashCode(I)I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget v2, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->height:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->data:[B

    invoke-static {v2}, Ljava/util/Arrays;->hashCode([B)I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-wide v2, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->frame_id:J

    invoke-static {v2, v3}, Ljava/lang/Long;->hashCode(J)I

    move-result v2

    add-int/2addr v1, v2

    return v1
.end method

.method public final setData([B)V
    .locals 1
    .param p1, "<set-?>"    # [B

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    iput-object p1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->data:[B

    return-void
.end method

.method public final setFrame_id(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 10
    iput-wide p1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->frame_id:J

    return-void
.end method

.method public final setHeight(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 8
    iput p1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->height:I

    return-void
.end method

.method public final setWidth(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 7
    iput p1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->width:I

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "RecgImageInput(width="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->width:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", height="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->height:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", data="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->data:[B

    invoke-static {v1}, Ljava/util/Arrays;->toString([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", frame_id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/rokid/security/phone/core/ability/track/bean/RecgImageInput;->frame_id:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
