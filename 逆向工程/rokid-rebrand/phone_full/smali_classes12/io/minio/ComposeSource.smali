.class public Lio/minio/ComposeSource;
.super Lio/minio/ObjectConditionalReadArgs;
.source "ComposeSource.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ComposeSource$Builder;
    }
.end annotation


# instance fields
.field private headers:Lcom/google/common/collect/Multimap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private objectSize:Ljava/lang/Long;


# direct methods
.method protected constructor <init>()V
    .locals 1

    .line 32
    invoke-direct {p0}, Lio/minio/ObjectConditionalReadArgs;-><init>()V

    .line 29
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/ComposeSource;->objectSize:Ljava/lang/Long;

    .line 30
    iput-object v0, p0, Lio/minio/ComposeSource;->headers:Lcom/google/common/collect/Multimap;

    .line 32
    return-void
.end method

.method public constructor <init>(Lio/minio/ObjectConditionalReadArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/ObjectConditionalReadArgs;

    .line 34
    invoke-direct {p0}, Lio/minio/ObjectConditionalReadArgs;-><init>()V

    .line 29
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/ComposeSource;->objectSize:Ljava/lang/Long;

    .line 30
    iput-object v0, p0, Lio/minio/ComposeSource;->headers:Lcom/google/common/collect/Multimap;

    .line 35
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/ComposeSource;->extraHeaders:Lcom/google/common/collect/Multimap;

    .line 36
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/ComposeSource;->extraQueryParams:Lcom/google/common/collect/Multimap;

    .line 37
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->bucketName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/ComposeSource;->bucketName:Ljava/lang/String;

    .line 38
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->region:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/ComposeSource;->region:Ljava/lang/String;

    .line 39
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->objectName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/ComposeSource;->objectName:Ljava/lang/String;

    .line 40
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->versionId:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/ComposeSource;->versionId:Ljava/lang/String;

    .line 41
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    iput-object v0, p0, Lio/minio/ComposeSource;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    .line 42
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->offset:Ljava/lang/Long;

    iput-object v0, p0, Lio/minio/ComposeSource;->offset:Ljava/lang/Long;

    .line 43
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->length:Ljava/lang/Long;

    iput-object v0, p0, Lio/minio/ComposeSource;->length:Ljava/lang/Long;

    .line 44
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/ComposeSource;->matchETag:Ljava/lang/String;

    .line 45
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/ComposeSource;->notMatchETag:Ljava/lang/String;

    .line 46
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    iput-object v0, p0, Lio/minio/ComposeSource;->modifiedSince:Ljava/time/ZonedDateTime;

    .line 47
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    iput-object v0, p0, Lio/minio/ComposeSource;->unmodifiedSince:Ljava/time/ZonedDateTime;

    .line 48
    return-void
.end method

.method public static builder()Lio/minio/ComposeSource$Builder;
    .locals 1

    .line 116
    new-instance v0, Lio/minio/ComposeSource$Builder;

    invoke-direct {v0}, Lio/minio/ComposeSource$Builder;-><init>()V

    return-object v0
.end method

.method private throwException(JJLjava/lang/String;)V
    .locals 3
    .param p1, "objectsize"    # J
    .param p3, "arg"    # J
    .param p5, "argName"    # Ljava/lang/String;

    .line 51
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 52
    const-string/jumbo v1, "source "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/ComposeSource;->bucketName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/ComposeSource;->objectName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 54
    .local v0, "builder":Ljava/lang/StringBuilder;
    iget-object v1, p0, Lio/minio/ComposeSource;->versionId:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 55
    const-string v1, "?versionId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lio/minio/ComposeSource;->versionId:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 58
    :cond_0
    nop

    .line 59
    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 60
    invoke-virtual {v1, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 61
    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 62
    invoke-virtual {v1, p3, p4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 63
    const-string v2, " is beyond object size "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lio/minio/ComposeSource;->objectSize:Ljava/lang/Long;

    .line 64
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 66
    new-instance v1, Ljava/lang/IllegalArgumentException;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private validateSize(J)V
    .locals 10
    .param p1, "objectSize"    # J

    .line 70
    iget-object v0, p0, Lio/minio/ComposeSource;->offset:Ljava/lang/Long;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/ComposeSource;->offset:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    cmp-long v0, v0, p1

    if-ltz v0, :cond_0

    .line 71
    iget-object v0, p0, Lio/minio/ComposeSource;->offset:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    const-string v6, "offset"

    move-object v1, p0

    move-wide v2, p1

    invoke-direct/range {v1 .. v6}, Lio/minio/ComposeSource;->throwException(JJLjava/lang/String;)V

    .line 74
    :cond_0
    iget-object v0, p0, Lio/minio/ComposeSource;->length:Ljava/lang/Long;

    if-eqz v0, :cond_2

    .line 75
    iget-object v0, p0, Lio/minio/ComposeSource;->length:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    cmp-long v0, v0, p1

    if-lez v0, :cond_1

    .line 76
    iget-object v0, p0, Lio/minio/ComposeSource;->length:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    const-string v6, "length"

    move-object v1, p0

    move-wide v2, p1

    invoke-direct/range {v1 .. v6}, Lio/minio/ComposeSource;->throwException(JJLjava/lang/String;)V

    .line 79
    :cond_1
    iget-object v0, p0, Lio/minio/ComposeSource;->offset:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    iget-object v2, p0, Lio/minio/ComposeSource;->length:Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    add-long/2addr v0, v2

    cmp-long v0, v0, p1

    if-lez v0, :cond_2

    .line 80
    iget-object v0, p0, Lio/minio/ComposeSource;->offset:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    iget-object v2, p0, Lio/minio/ComposeSource;->length:Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    add-long v7, v0, v2

    const-string v9, "compose size"

    move-object v4, p0

    move-wide v5, p1

    invoke-direct/range {v4 .. v9}, Lio/minio/ComposeSource;->throwException(JJLjava/lang/String;)V

    .line 83
    :cond_2
    return-void
.end method


# virtual methods
.method public buildHeaders(JLjava/lang/String;)V
    .locals 3
    .param p1, "objectSize"    # J
    .param p3, "etag"    # Ljava/lang/String;

    .line 86
    invoke-direct {p0, p1, p2}, Lio/minio/ComposeSource;->validateSize(J)V

    .line 87
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lio/minio/ComposeSource;->objectSize:Ljava/lang/Long;

    .line 88
    invoke-virtual {p0}, Lio/minio/ComposeSource;->genCopyHeaders()Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 89
    .local v0, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string/jumbo v1, "x-amz-copy-source-if-match"

    invoke-interface {v0, v1}, Lcom/google/common/collect/Multimap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 90
    invoke-interface {v0, v1, p3}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 92
    :cond_0
    invoke-static {v0}, Lcom/google/common/collect/Multimaps;->unmodifiableMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v1

    iput-object v1, p0, Lio/minio/ComposeSource;->headers:Lcom/google/common/collect/Multimap;

    .line 93
    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 125
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 126
    :cond_0
    instance-of v1, p1, Lio/minio/ComposeSource;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 127
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectConditionalReadArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 128
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/ComposeSource;

    .line 129
    .local v1, "that":Lio/minio/ComposeSource;
    iget-object v3, p0, Lio/minio/ComposeSource;->objectSize:Ljava/lang/Long;

    iget-object v4, v1, Lio/minio/ComposeSource;->objectSize:Ljava/lang/Long;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ComposeSource;->headers:Lcom/google/common/collect/Multimap;

    iget-object v4, v1, Lio/minio/ComposeSource;->headers:Lcom/google/common/collect/Multimap;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 3

    .line 134
    invoke-super {p0}, Lio/minio/ObjectConditionalReadArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/ComposeSource;->objectSize:Ljava/lang/Long;

    iget-object v2, p0, Lio/minio/ComposeSource;->headers:Lcom/google/common/collect/Multimap;

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public headers()Lcom/google/common/collect/Multimap;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InternalException;
        }
    .end annotation

    .line 106
    iget-object v0, p0, Lio/minio/ComposeSource;->headers:Lcom/google/common/collect/Multimap;

    if-eqz v0, :cond_0

    .line 112
    iget-object v0, p0, Lio/minio/ComposeSource;->headers:Lcom/google/common/collect/Multimap;

    return-object v0

    .line 107
    :cond_0
    new-instance v0, Lio/minio/errors/InternalException;

    const-string v1, "buildHeaders(long objectSize, String etag) must be called prior to this method invocation"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/minio/errors/InternalException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0
.end method

.method public objectSize()J
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/minio/errors/InternalException;
        }
    .end annotation

    .line 96
    iget-object v0, p0, Lio/minio/ComposeSource;->objectSize:Ljava/lang/Long;

    if-eqz v0, :cond_0

    .line 102
    iget-object v0, p0, Lio/minio/ComposeSource;->objectSize:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    return-wide v0

    .line 97
    :cond_0
    new-instance v0, Lio/minio/errors/InternalException;

    const-string v1, "buildHeaders(long objectSize, String etag) must be called prior to this method invocation"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lio/minio/errors/InternalException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v0
.end method
