.class public abstract Lio/minio/ObjectConditionalReadArgs;
.super Lio/minio/ObjectReadArgs;
.source "ObjectConditionalReadArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ObjectConditionalReadArgs$Builder;
    }
.end annotation


# instance fields
.field protected length:Ljava/lang/Long;

.field protected matchETag:Ljava/lang/String;

.field protected modifiedSince:Ljava/time/ZonedDateTime;

.field protected notMatchETag:Ljava/lang/String;

.field protected offset:Ljava/lang/Long;

.field protected unmodifiedSince:Ljava/time/ZonedDateTime;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Lio/minio/ObjectReadArgs;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 175
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 176
    :cond_0
    instance-of v1, p1, Lio/minio/ObjectConditionalReadArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 177
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectReadArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 178
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/ObjectConditionalReadArgs;

    .line 179
    .local v1, "that":Lio/minio/ObjectConditionalReadArgs;
    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->offset:Ljava/lang/Long;

    iget-object v4, v1, Lio/minio/ObjectConditionalReadArgs;->offset:Ljava/lang/Long;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->length:Ljava/lang/Long;

    iget-object v4, v1, Lio/minio/ObjectConditionalReadArgs;->length:Ljava/lang/Long;

    .line 180
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    .line 181
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    .line 182
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    iget-object v4, v1, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    .line 183
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    iget-object v4, v1, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    .line 184
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    .line 179
    :goto_0
    return v0
.end method

.method public genCopyHeaders()Lcom/google/common/collect/Multimap;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 94
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    .line 96
    .local v0, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->bucketName:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->objectName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lio/minio/S3Escaper;->encodePath(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 97
    .local v1, "copySource":Ljava/lang/String;
    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->versionId:Ljava/lang/String;

    if-eqz v2, :cond_0

    .line 98
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "?versionId="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->versionId:Ljava/lang/String;

    invoke-static {v3}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 101
    :cond_0
    const-string/jumbo v2, "x-amz-copy-source"

    invoke-interface {v0, v2, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 103
    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    invoke-virtual {v2}, Lio/minio/ServerSideEncryptionCustomerKey;->copySourceHeaders()Ljava/util/Map;

    move-result-object v2

    invoke-static {v2}, Lcom/google/common/collect/Multimaps;->forMap(Ljava/util/Map;)Lcom/google/common/collect/SetMultimap;

    move-result-object v2

    invoke-interface {v0, v2}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 104
    :cond_1
    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    if-eqz v2, :cond_2

    const-string/jumbo v2, "x-amz-copy-source-if-match"

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    invoke-interface {v0, v2, v3}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 105
    :cond_2
    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    if-eqz v2, :cond_3

    const-string/jumbo v2, "x-amz-copy-source-if-none-match"

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    invoke-interface {v0, v2, v3}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 107
    :cond_3
    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    if-eqz v2, :cond_4

    .line 108
    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    sget-object v3, Lio/minio/Time;->HTTP_HEADER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 110
    invoke-virtual {v2, v3}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v2

    .line 108
    const-string/jumbo v3, "x-amz-copy-source-if-modified-since"

    invoke-interface {v0, v3, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 113
    :cond_4
    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    if-eqz v2, :cond_5

    .line 114
    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    sget-object v3, Lio/minio/Time;->HTTP_HEADER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 116
    invoke-virtual {v2, v3}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v2

    .line 114
    const-string/jumbo v3, "x-amz-copy-source-if-unmodified-since"

    invoke-interface {v0, v3, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 119
    :cond_5
    return-object v0
.end method

.method public getHeaders()Lcom/google/common/collect/Multimap;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 60
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs;->offset:Ljava/lang/Long;

    .line 61
    .local v0, "offset":Ljava/lang/Long;
    iget-object v1, p0, Lio/minio/ObjectConditionalReadArgs;->length:Ljava/lang/Long;

    .line 62
    .local v1, "length":Ljava/lang/Long;
    if-eqz v1, :cond_0

    if-nez v0, :cond_0

    .line 63
    const-wide/16 v2, 0x0

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    .line 66
    :cond_0
    const/4 v2, 0x0

    .line 67
    .local v2, "range":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 68
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "bytes="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "-"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 69
    if-eqz v1, :cond_1

    .line 70
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    add-long/2addr v4, v6

    const-wide/16 v6, 0x1

    sub-long/2addr v4, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 74
    :cond_1
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v3

    .line 76
    .local v3, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz v2, :cond_2

    const-string v4, "Range"

    invoke-interface {v3, v4, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 77
    :cond_2
    iget-object v4, p0, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    if-eqz v4, :cond_3

    const-string v4, "if-match"

    iget-object v5, p0, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    invoke-interface {v3, v4, v5}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 78
    :cond_3
    iget-object v4, p0, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    if-eqz v4, :cond_4

    const-string v4, "if-none-match"

    iget-object v5, p0, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    invoke-interface {v3, v4, v5}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 80
    :cond_4
    iget-object v4, p0, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    if-eqz v4, :cond_5

    .line 81
    iget-object v4, p0, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    sget-object v5, Lio/minio/Time;->HTTP_HEADER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-virtual {v4, v5}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "if-modified-since"

    invoke-interface {v3, v5, v4}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 84
    :cond_5
    iget-object v4, p0, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    if-eqz v4, :cond_6

    .line 85
    iget-object v4, p0, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    sget-object v5, Lio/minio/Time;->HTTP_HEADER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-virtual {v4, v5}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "if-unmodified-since"

    invoke-interface {v3, v5, v4}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 88
    :cond_6
    iget-object v4, p0, Lio/minio/ObjectConditionalReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    if-eqz v4, :cond_7

    iget-object v4, p0, Lio/minio/ObjectConditionalReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    invoke-virtual {v4}, Lio/minio/ServerSideEncryptionCustomerKey;->headers()Ljava/util/Map;

    move-result-object v4

    invoke-static {v4}, Lcom/google/common/collect/Multimaps;->forMap(Ljava/util/Map;)Lcom/google/common/collect/SetMultimap;

    move-result-object v4

    invoke-interface {v3, v4}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 90
    :cond_7
    return-object v3
.end method

.method public hashCode()I
    .locals 8

    .line 189
    nop

    .line 190
    invoke-super {p0}, Lio/minio/ObjectReadArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget-object v2, p0, Lio/minio/ObjectConditionalReadArgs;->offset:Ljava/lang/Long;

    iget-object v3, p0, Lio/minio/ObjectConditionalReadArgs;->length:Ljava/lang/Long;

    iget-object v4, p0, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    iget-object v5, p0, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    iget-object v6, p0, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    iget-object v7, p0, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    filled-new-array/range {v1 .. v7}, [Ljava/lang/Object;

    move-result-object v0

    .line 189
    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public length()Ljava/lang/Long;
    .locals 1

    .line 40
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs;->length:Ljava/lang/Long;

    return-object v0
.end method

.method public matchETag()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    return-object v0
.end method

.method public modifiedSince()Ljava/time/ZonedDateTime;
    .locals 1

    .line 52
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    return-object v0
.end method

.method public notMatchETag()Ljava/lang/String;
    .locals 1

    .line 48
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    return-object v0
.end method

.method public offset()Ljava/lang/Long;
    .locals 1

    .line 36
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs;->offset:Ljava/lang/Long;

    return-object v0
.end method

.method public unmodifiedSince()Ljava/time/ZonedDateTime;
    .locals 1

    .line 56
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    return-object v0
.end method
