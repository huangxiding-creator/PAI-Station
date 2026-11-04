.class public Lcom/alibaba/sdk/android/oss/model/Range;
.super Ljava/lang/Object;
.source "Range.java"


# static fields
.field public static final INFINITE:J = -0x1L


# instance fields
.field private begin:J

.field private end:J


# direct methods
.method public constructor <init>(JJ)V
    .locals 0
    .param p1, "begin"    # J
    .param p3, "end"    # J

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    invoke-virtual {p0, p1, p2}, Lcom/alibaba/sdk/android/oss/model/Range;->setBegin(J)V

    .line 28
    invoke-virtual {p0, p3, p4}, Lcom/alibaba/sdk/android/oss/model/Range;->setEnd(J)V

    .line 29
    return-void
.end method


# virtual methods
.method public checkIsValid()Z
    .locals 6

    .line 48
    iget-wide v0, p0, Lcom/alibaba/sdk/android/oss/model/Range;->begin:J

    const-wide/16 v2, -0x1

    cmp-long v0, v0, v2

    const/4 v1, 0x0

    if-ltz v0, :cond_2

    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/model/Range;->end:J

    cmp-long v0, v4, v2

    if-gez v0, :cond_0

    goto :goto_0

    .line 51
    :cond_0
    iget-wide v2, p0, Lcom/alibaba/sdk/android/oss/model/Range;->begin:J

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-ltz v0, :cond_1

    iget-wide v2, p0, Lcom/alibaba/sdk/android/oss/model/Range;->end:J

    cmp-long v0, v2, v4

    if-ltz v0, :cond_1

    iget-wide v2, p0, Lcom/alibaba/sdk/android/oss/model/Range;->begin:J

    iget-wide v4, p0, Lcom/alibaba/sdk/android/oss/model/Range;->end:J

    cmp-long v0, v2, v4

    if-lez v0, :cond_1

    .line 52
    return v1

    .line 54
    :cond_1
    const/4 v0, 0x1

    return v0

    .line 49
    :cond_2
    :goto_0
    return v1
.end method

.method public getBegin()J
    .locals 2

    .line 40
    iget-wide v0, p0, Lcom/alibaba/sdk/android/oss/model/Range;->begin:J

    return-wide v0
.end method

.method public getEnd()J
    .locals 2

    .line 32
    iget-wide v0, p0, Lcom/alibaba/sdk/android/oss/model/Range;->end:J

    return-wide v0
.end method

.method public setBegin(J)V
    .locals 0
    .param p1, "begin"    # J

    .line 44
    iput-wide p1, p0, Lcom/alibaba/sdk/android/oss/model/Range;->begin:J

    .line 45
    return-void
.end method

.method public setEnd(J)V
    .locals 0
    .param p1, "end"    # J

    .line 36
    iput-wide p1, p0, Lcom/alibaba/sdk/android/oss/model/Range;->end:J

    .line 37
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 7

    .line 59
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "bytes="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lcom/alibaba/sdk/android/oss/model/Range;->begin:J

    const-wide/16 v3, -0x1

    cmp-long v1, v1, v3

    const-string v2, ""

    if-nez v1, :cond_0

    move-object v1, v2

    goto :goto_0

    :cond_0
    iget-wide v5, p0, Lcom/alibaba/sdk/android/oss/model/Range;->begin:J

    invoke-static {v5, v6}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v5, p0, Lcom/alibaba/sdk/android/oss/model/Range;->end:J

    cmp-long v1, v5, v3

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    iget-wide v1, p0, Lcom/alibaba/sdk/android/oss/model/Range;->end:J

    invoke-static {v1, v2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    :goto_1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
