.class public Lorg/apache/commons/compress/harmony/pack200/CPLong;
.super Lorg/apache/commons/compress/harmony/pack200/CPConstant;
.source "CPLong.java"


# instance fields
.field private final theLong:J


# direct methods
.method public constructor <init>(J)V
    .locals 0
    .param p1, "theLong"    # J

    .line 26
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/CPConstant;-><init>()V

    .line 27
    iput-wide p1, p0, Lorg/apache/commons/compress/harmony/pack200/CPLong;->theLong:J

    .line 28
    return-void
.end method


# virtual methods
.method public compareTo(Ljava/lang/Object;)I
    .locals 4
    .param p1, "obj"    # Ljava/lang/Object;

    .line 32
    iget-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPLong;->theLong:J

    move-object v2, p1

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/CPLong;

    iget-wide v2, v2, Lorg/apache/commons/compress/harmony/pack200/CPLong;->theLong:J

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    .line 33
    const/4 v0, 0x1

    return v0

    .line 35
    :cond_0
    iget-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPLong;->theLong:J

    move-object v2, p1

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/CPLong;

    iget-wide v2, v2, Lorg/apache/commons/compress/harmony/pack200/CPLong;->theLong:J

    cmp-long v0, v0, v2

    if-nez v0, :cond_1

    .line 36
    const/4 v0, 0x0

    return v0

    .line 38
    :cond_1
    const/4 v0, -0x1

    return v0
.end method

.method public getLong()J
    .locals 2

    .line 42
    iget-wide v0, p0, Lorg/apache/commons/compress/harmony/pack200/CPLong;->theLong:J

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 47
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p0, Lorg/apache/commons/compress/harmony/pack200/CPLong;->theLong:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
