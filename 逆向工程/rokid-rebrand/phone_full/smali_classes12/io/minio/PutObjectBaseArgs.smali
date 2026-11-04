.class public abstract Lio/minio/PutObjectBaseArgs;
.super Lio/minio/ObjectWriteArgs;
.source "PutObjectBaseArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/PutObjectBaseArgs$Builder;
    }
.end annotation


# instance fields
.field protected contentType:Ljava/lang/String;

.field protected objectSize:J

.field protected partCount:I

.field protected partSize:J

.field protected preloadData:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs;-><init>()V

    return-void
.end method


# virtual methods
.method public contentType()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 44
    iget-object v0, p0, Lio/minio/PutObjectBaseArgs;->contentType:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 45
    iget-object v0, p0, Lio/minio/PutObjectBaseArgs;->contentType:Ljava/lang/String;

    return-object v0

    .line 48
    :cond_0
    invoke-virtual {p0}, Lio/minio/PutObjectBaseArgs;->headers()Lcom/google/common/collect/Multimap;

    move-result-object v0

    const-string v1, "Content-Type"

    invoke-interface {v0, v1}, Lcom/google/common/collect/Multimap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 49
    invoke-virtual {p0}, Lio/minio/PutObjectBaseArgs;->headers()Lcom/google/common/collect/Multimap;

    move-result-object v0

    invoke-interface {v0, v1}, Lcom/google/common/collect/Multimap;->get(Ljava/lang/Object;)Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0

    .line 52
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 7
    .param p1, "o"    # Ljava/lang/Object;

    .line 131
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 132
    :cond_0
    instance-of v1, p1, Lio/minio/PutObjectBaseArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 133
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectWriteArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 134
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/PutObjectBaseArgs;

    .line 135
    .local v1, "that":Lio/minio/PutObjectBaseArgs;
    iget-wide v3, p0, Lio/minio/PutObjectBaseArgs;->objectSize:J

    iget-wide v5, v1, Lio/minio/PutObjectBaseArgs;->objectSize:J

    cmp-long v3, v3, v5

    if-nez v3, :cond_3

    iget-wide v3, p0, Lio/minio/PutObjectBaseArgs;->partSize:J

    iget-wide v5, v1, Lio/minio/PutObjectBaseArgs;->partSize:J

    cmp-long v3, v3, v5

    if-nez v3, :cond_3

    iget v3, p0, Lio/minio/PutObjectBaseArgs;->partCount:I

    iget v4, v1, Lio/minio/PutObjectBaseArgs;->partCount:I

    if-ne v3, v4, :cond_3

    iget-object v3, p0, Lio/minio/PutObjectBaseArgs;->contentType:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/PutObjectBaseArgs;->contentType:Ljava/lang/String;

    .line 138
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-boolean v3, p0, Lio/minio/PutObjectBaseArgs;->preloadData:Z

    iget-boolean v4, v1, Lio/minio/PutObjectBaseArgs;->preloadData:Z

    if-ne v3, v4, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    .line 135
    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 7

    .line 144
    nop

    .line 145
    invoke-super {p0}, Lio/minio/ObjectWriteArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget-wide v2, p0, Lio/minio/PutObjectBaseArgs;->objectSize:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    iget-wide v3, p0, Lio/minio/PutObjectBaseArgs;->partSize:J

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    iget v0, p0, Lio/minio/PutObjectBaseArgs;->partCount:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    iget-object v5, p0, Lio/minio/PutObjectBaseArgs;->contentType:Ljava/lang/String;

    iget-boolean v0, p0, Lio/minio/PutObjectBaseArgs;->preloadData:Z

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    filled-new-array/range {v1 .. v6}, [Ljava/lang/Object;

    move-result-object v0

    .line 144
    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public objectSize()J
    .locals 2

    .line 31
    iget-wide v0, p0, Lio/minio/PutObjectBaseArgs;->objectSize:J

    return-wide v0
.end method

.method public partCount()I
    .locals 1

    .line 39
    iget v0, p0, Lio/minio/PutObjectBaseArgs;->partCount:I

    return v0
.end method

.method public partSize()J
    .locals 2

    .line 35
    iget-wide v0, p0, Lio/minio/PutObjectBaseArgs;->partSize:J

    return-wide v0
.end method

.method public preloadData()Z
    .locals 1

    .line 56
    iget-boolean v0, p0, Lio/minio/PutObjectBaseArgs;->preloadData:Z

    return v0
.end method
