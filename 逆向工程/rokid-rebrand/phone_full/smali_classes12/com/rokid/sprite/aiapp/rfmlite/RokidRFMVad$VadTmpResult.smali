.class public final Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;
.super Ljava/lang/Object;
.source "RokidRFMVad.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "VadTmpResult"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0007\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0002\u0008\u001a\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u0086\u0008\u0018\u00002\u00020\u0001B7\u0012\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u0003\u0012\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0005\u0012\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u0007\u0012\u0008\u0008\u0002\u0010\u0008\u001a\u00020\u0005\u0012\u0008\u0008\u0002\u0010\t\u001a\u00020\n\u00a2\u0006\u0002\u0010\u000bJ\t\u0010\u001e\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u001f\u001a\u00020\u0005H\u00c6\u0003J\t\u0010 \u001a\u00020\u0007H\u00c6\u0003J\t\u0010!\u001a\u00020\u0005H\u00c6\u0003J\t\u0010\"\u001a\u00020\nH\u00c6\u0003J;\u0010#\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00052\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u00072\u0008\u0008\u0002\u0010\u0008\u001a\u00020\u00052\u0008\u0008\u0002\u0010\t\u001a\u00020\nH\u00c6\u0001J\u0013\u0010$\u001a\u00020%2\u0008\u0010&\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\u0006\u0010\'\u001a\u00020(J\t\u0010)\u001a\u00020\u0003H\u00d6\u0001J\u0008\u0010*\u001a\u00020\u0005H\u0016R\u001a\u0010\u0008\u001a\u00020\u0005X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000c\u0010\r\"\u0004\u0008\u000e\u0010\u000fR\u001a\u0010\u0006\u001a\u00020\u0007X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0011\"\u0004\u0008\u0012\u0010\u0013R\u001a\u0010\u0002\u001a\u00020\u0003X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0014\u0010\u0015\"\u0004\u0008\u0016\u0010\u0017R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0018\u0010\u0019\"\u0004\u0008\u001a\u0010\u001bR\u001a\u0010\u0004\u001a\u00020\u0005X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001c\u0010\r\"\u0004\u0008\u001d\u0010\u000f\u00a8\u0006+"
    }
    d2 = {
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;",
        "",
        "status",
        "",
        "traceId",
        "",
        "rt",
        "",
        "asr",
        "timestamp",
        "",
        "(ILjava/lang/String;FLjava/lang/String;J)V",
        "getAsr",
        "()Ljava/lang/String;",
        "setAsr",
        "(Ljava/lang/String;)V",
        "getRt",
        "()F",
        "setRt",
        "(F)V",
        "getStatus",
        "()I",
        "setStatus",
        "(I)V",
        "getTimestamp",
        "()J",
        "setTimestamp",
        "(J)V",
        "getTraceId",
        "setTraceId",
        "component1",
        "component2",
        "component3",
        "component4",
        "component5",
        "copy",
        "equals",
        "",
        "other",
        "getVadStatus",
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;",
        "hashCode",
        "toString",
        "lib-rfmlite_release"
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
.field private asr:Ljava/lang/String;

.field private rt:F

.field private status:I

.field private timestamp:J

.field private traceId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 9

    const/16 v7, 0x1f

    const/4 v8, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const-wide/16 v5, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v8}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;-><init>(ILjava/lang/String;FLjava/lang/String;JILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;FLjava/lang/String;J)V
    .locals 1
    .param p1, "status"    # I
    .param p2, "traceId"    # Ljava/lang/String;
    .param p3, "rt"    # F
    .param p4, "asr"    # Ljava/lang/String;
    .param p5, "timestamp"    # J

    const-string/jumbo v0, "traceId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "asr"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 53
    iput p1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    .line 54
    iput-object p2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->traceId:Ljava/lang/String;

    .line 55
    iput p3, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->rt:F

    .line 56
    iput-object p4, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->asr:Ljava/lang/String;

    .line 57
    iput-wide p5, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->timestamp:J

    .line 52
    return-void
.end method

.method public synthetic constructor <init>(ILjava/lang/String;FLjava/lang/String;JILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 4

    .line 52
    and-int/lit8 p8, p7, 0x1

    if-eqz p8, :cond_0

    .line 53
    const/4 p1, 0x0

    .line 52
    :cond_0
    and-int/lit8 p8, p7, 0x2

    const-string v0, ""

    if-eqz p8, :cond_1

    .line 54
    move-object p8, v0

    goto :goto_0

    .line 52
    :cond_1
    move-object p8, p2

    :goto_0
    and-int/lit8 p2, p7, 0x4

    if-eqz p2, :cond_2

    .line 55
    const/4 p3, 0x0

    move v1, p3

    goto :goto_1

    .line 52
    :cond_2
    move v1, p3

    :goto_1
    and-int/lit8 p2, p7, 0x8

    if-eqz p2, :cond_3

    .line 56
    goto :goto_2

    .line 52
    :cond_3
    move-object v0, p4

    :goto_2
    and-int/lit8 p2, p7, 0x10

    if-eqz p2, :cond_4

    .line 57
    const-wide/16 p5, 0x0

    move-wide v2, p5

    goto :goto_3

    .line 52
    :cond_4
    move-wide v2, p5

    :goto_3
    move-object p2, p0

    move p3, p1

    move-object p4, p8

    move p5, v1

    move-object p6, v0

    move-wide p7, v2

    invoke-direct/range {p2 .. p8}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;-><init>(ILjava/lang/String;FLjava/lang/String;J)V

    .line 72
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;ILjava/lang/String;FLjava/lang/String;JILjava/lang/Object;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;
    .locals 4

    and-int/lit8 p8, p7, 0x1

    if-eqz p8, :cond_0

    iget p1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    :cond_0
    and-int/lit8 p8, p7, 0x2

    if-eqz p8, :cond_1

    iget-object p2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->traceId:Ljava/lang/String;

    :cond_1
    move-object p8, p2

    and-int/lit8 p2, p7, 0x4

    if-eqz p2, :cond_2

    iget p3, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->rt:F

    :cond_2
    move v0, p3

    and-int/lit8 p2, p7, 0x8

    if-eqz p2, :cond_3

    iget-object p4, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->asr:Ljava/lang/String;

    :cond_3
    move-object v1, p4

    and-int/lit8 p2, p7, 0x10

    if-eqz p2, :cond_4

    iget-wide p5, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->timestamp:J

    :cond_4
    move-wide v2, p5

    move-object p2, p0

    move p3, p1

    move-object p4, p8

    move p5, v0

    move-object p6, v1

    move-wide p7, v2

    invoke-virtual/range {p2 .. p8}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->copy(ILjava/lang/String;FLjava/lang/String;J)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()I
    .locals 1

    iget v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    return v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->traceId:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()F
    .locals 1

    iget v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->rt:F

    return v0
.end method

.method public final component4()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->asr:Ljava/lang/String;

    return-object v0
.end method

.method public final component5()J
    .locals 2

    iget-wide v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->timestamp:J

    return-wide v0
.end method

.method public final copy(ILjava/lang/String;FLjava/lang/String;J)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;
    .locals 8

    const-string/jumbo v0, "traceId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "asr"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;

    move-object v1, v0

    move v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    move-wide v6, p5

    invoke-direct/range {v1 .. v7}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;-><init>(ILjava/lang/String;FLjava/lang/String;J)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 7

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;

    iget v3, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    iget v4, v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    if-eq v3, v4, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->traceId:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->traceId:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget v3, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->rt:F

    iget v4, v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->rt:F

    invoke-static {v3, v4}, Ljava/lang/Float;->compare(FF)I

    move-result v3

    if-eqz v3, :cond_4

    return v2

    :cond_4
    iget-object v3, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->asr:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->asr:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    return v2

    :cond_5
    iget-wide v3, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->timestamp:J

    iget-wide v5, v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->timestamp:J

    cmp-long v1, v3, v5

    if-eqz v1, :cond_6

    return v2

    :cond_6
    return v0
.end method

.method public final getAsr()Ljava/lang/String;
    .locals 1

    .line 56
    iget-object v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->asr:Ljava/lang/String;

    return-object v0
.end method

.method public final getRt()F
    .locals 1

    .line 55
    iget v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->rt:F

    return v0
.end method

.method public final getStatus()I
    .locals 1

    .line 53
    iget v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    return v0
.end method

.method public final getTimestamp()J
    .locals 2

    .line 57
    iget-wide v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->timestamp:J

    return-wide v0
.end method

.method public final getTraceId()Ljava/lang/String;
    .locals 1

    .line 54
    iget-object v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->traceId:Ljava/lang/String;

    return-object v0
.end method

.method public final getVadStatus()Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;
    .locals 1

    .line 60
    iget v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    packed-switch v0, :pswitch_data_0

    .line 65
    sget-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->NONE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    goto :goto_0

    .line 64
    :pswitch_0
    sget-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->WAIT_TIMEOUT:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    goto :goto_0

    .line 63
    :pswitch_1
    sget-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->WAIT:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    goto :goto_0

    .line 62
    :pswitch_2
    sget-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->NONE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    goto :goto_0

    .line 61
    :pswitch_3
    sget-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->ERROR_CONFIG_NOT_EXIST:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    .line 60
    :goto_0
    return-object v0

    :pswitch_data_0
    .packed-switch -0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public hashCode()I
    .locals 4

    iget v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    invoke-static {v0}, Ljava/lang/Integer;->hashCode(I)I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->traceId:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->rt:F

    invoke-static {v2}, Ljava/lang/Float;->hashCode(F)I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->asr:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-wide v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->timestamp:J

    invoke-static {v2, v3}, Ljava/lang/Long;->hashCode(J)I

    move-result v2

    add-int/2addr v0, v2

    return v0
.end method

.method public final setAsr(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 56
    iput-object p1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->asr:Ljava/lang/String;

    return-void
.end method

.method public final setRt(F)V
    .locals 0
    .param p1, "<set-?>"    # F

    .line 55
    iput p1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->rt:F

    return-void
.end method

.method public final setStatus(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 53
    iput p1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    return-void
.end method

.method public final setTimestamp(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 57
    iput-wide p1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->timestamp:J

    return-void
.end method

.method public final setTraceId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 54
    iput-object p1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->traceId:Ljava/lang/String;

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 8

    .line 70
    iget v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->status:I

    iget-object v1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->traceId:Ljava/lang/String;

    iget v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->rt:F

    iget-object v3, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->asr:Ljava/lang/String;

    iget-wide v4, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->timestamp:J

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "VadTmpResult(status="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, ", traceId=\'"

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', rt="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", asr=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\', timestamp="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
