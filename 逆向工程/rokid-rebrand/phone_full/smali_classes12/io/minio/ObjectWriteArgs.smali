.class public abstract Lio/minio/ObjectWriteArgs;
.super Lio/minio/ObjectArgs;
.source "ObjectWriteArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ObjectWriteArgs$Builder;
    }
.end annotation


# static fields
.field public static final MAX_MULTIPART_COUNT:I = 0x2710

.field public static final MAX_OBJECT_SIZE:J = 0x50000000000L

.field public static final MAX_PART_SIZE:J = 0x140000000L

.field public static final MIN_MULTIPART_SIZE:I = 0x500000


# instance fields
.field protected headers:Lcom/google/common/collect/Multimap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field protected legalHold:Z

.field protected retention:Lio/minio/messages/Retention;

.field protected sse:Lio/minio/ServerSideEncryption;

.field protected tags:Lio/minio/messages/Tags;

.field protected userMetadata:Lcom/google/common/collect/Multimap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 33
    invoke-direct {p0}, Lio/minio/ObjectArgs;-><init>()V

    .line 42
    nop

    .line 43
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    invoke-static {v0}, Lcom/google/common/collect/Multimaps;->unmodifiableMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    iput-object v0, p0, Lio/minio/ObjectWriteArgs;->headers:Lcom/google/common/collect/Multimap;

    .line 44
    nop

    .line 45
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    invoke-static {v0}, Lcom/google/common/collect/Multimaps;->unmodifiableMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    iput-object v0, p0, Lio/minio/ObjectWriteArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    .line 47
    new-instance v0, Lio/minio/messages/Tags;

    invoke-direct {v0}, Lio/minio/messages/Tags;-><init>()V

    iput-object v0, p0, Lio/minio/ObjectWriteArgs;->tags:Lio/minio/messages/Tags;

    return-void
.end method

.method static synthetic lambda$genHeaders$0(Ljava/util/Map$Entry;)Ljava/lang/String;
    .locals 2
    .param p0, "e"    # Ljava/util/Map$Entry;

    .line 87
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {p0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-interface {p0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 177
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 178
    :cond_0
    instance-of v1, p1, Lio/minio/ObjectWriteArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 179
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 180
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/ObjectWriteArgs;

    .line 181
    .local v1, "that":Lio/minio/ObjectWriteArgs;
    iget-boolean v3, p0, Lio/minio/ObjectWriteArgs;->legalHold:Z

    iget-boolean v4, v1, Lio/minio/ObjectWriteArgs;->legalHold:Z

    if-ne v3, v4, :cond_3

    iget-object v3, p0, Lio/minio/ObjectWriteArgs;->headers:Lcom/google/common/collect/Multimap;

    iget-object v4, v1, Lio/minio/ObjectWriteArgs;->headers:Lcom/google/common/collect/Multimap;

    .line 182
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ObjectWriteArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    iget-object v4, v1, Lio/minio/ObjectWriteArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    .line 183
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ObjectWriteArgs;->sse:Lio/minio/ServerSideEncryption;

    iget-object v4, v1, Lio/minio/ObjectWriteArgs;->sse:Lio/minio/ServerSideEncryption;

    .line 184
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ObjectWriteArgs;->tags:Lio/minio/messages/Tags;

    iget-object v4, v1, Lio/minio/ObjectWriteArgs;->tags:Lio/minio/messages/Tags;

    .line 185
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ObjectWriteArgs;->retention:Lio/minio/messages/Retention;

    iget-object v4, v1, Lio/minio/ObjectWriteArgs;->retention:Lio/minio/messages/Retention;

    .line 186
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    .line 181
    :goto_0
    return v0
.end method

.method public genHeaders()Lcom/google/common/collect/Multimap;
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

    .line 76
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    .line 78
    .local v0, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v1, p0, Lio/minio/ObjectWriteArgs;->headers:Lcom/google/common/collect/Multimap;

    invoke-interface {v0, v1}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 79
    iget-object v1, p0, Lio/minio/ObjectWriteArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    invoke-interface {v0, v1}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 81
    iget-object v1, p0, Lio/minio/ObjectWriteArgs;->sse:Lio/minio/ServerSideEncryption;

    if-eqz v1, :cond_0

    .line 82
    iget-object v1, p0, Lio/minio/ObjectWriteArgs;->sse:Lio/minio/ServerSideEncryption;

    invoke-virtual {v1}, Lio/minio/ServerSideEncryption;->headers()Ljava/util/Map;

    move-result-object v1

    invoke-static {v1}, Lcom/google/common/collect/Multimaps;->forMap(Ljava/util/Map;)Lcom/google/common/collect/SetMultimap;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/google/common/collect/Multimap;->putAll(Lcom/google/common/collect/Multimap;)Z

    .line 85
    :cond_0
    iget-object v1, p0, Lio/minio/ObjectWriteArgs;->tags:Lio/minio/messages/Tags;

    .line 86
    invoke-virtual {v1}, Lio/minio/messages/Tags;->get()Ljava/util/Map;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->stream()Ljava/util/stream/Stream;

    move-result-object v1

    new-instance v2, Lio/minio/ObjectWriteArgs$$ExternalSyntheticLambda0;

    invoke-direct {v2}, Lio/minio/ObjectWriteArgs$$ExternalSyntheticLambda0;-><init>()V

    .line 87
    invoke-interface {v1, v2}, Ljava/util/stream/Stream;->map(Ljava/util/function/Function;)Ljava/util/stream/Stream;

    move-result-object v1

    .line 88
    const-string v2, "&"

    invoke-static {v2}, Ljava/util/stream/Collectors;->joining(Ljava/lang/CharSequence;)Ljava/util/stream/Collector;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/stream/Stream;->collect(Ljava/util/stream/Collector;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 89
    .local v1, "tagging":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    .line 90
    const-string/jumbo v2, "x-amz-tagging"

    invoke-interface {v0, v2, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 93
    :cond_1
    iget-object v2, p0, Lio/minio/ObjectWriteArgs;->retention:Lio/minio/messages/Retention;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lio/minio/ObjectWriteArgs;->retention:Lio/minio/messages/Retention;

    invoke-virtual {v2}, Lio/minio/messages/Retention;->mode()Lio/minio/messages/RetentionMode;

    move-result-object v2

    if-eqz v2, :cond_2

    .line 94
    iget-object v2, p0, Lio/minio/ObjectWriteArgs;->retention:Lio/minio/messages/Retention;

    invoke-virtual {v2}, Lio/minio/messages/Retention;->mode()Lio/minio/messages/RetentionMode;

    move-result-object v2

    invoke-virtual {v2}, Lio/minio/messages/RetentionMode;->name()Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "x-amz-object-lock-mode"

    invoke-interface {v0, v3, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 95
    iget-object v2, p0, Lio/minio/ObjectWriteArgs;->retention:Lio/minio/messages/Retention;

    .line 97
    invoke-virtual {v2}, Lio/minio/messages/Retention;->retainUntilDate()Ljava/time/ZonedDateTime;

    move-result-object v2

    sget-object v3, Lio/minio/Time;->RESPONSE_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-virtual {v2, v3}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v2

    .line 95
    const-string/jumbo v3, "x-amz-object-lock-retain-until-date"

    invoke-interface {v0, v3, v2}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 100
    :cond_2
    iget-boolean v2, p0, Lio/minio/ObjectWriteArgs;->legalHold:Z

    if-eqz v2, :cond_3

    .line 101
    const-string/jumbo v2, "x-amz-object-lock-legal-hold"

    const-string v3, "ON"

    invoke-interface {v0, v2, v3}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 104
    :cond_3
    return-object v0
.end method

.method public hashCode()I
    .locals 8

    .line 191
    invoke-super {p0}, Lio/minio/ObjectArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget-object v2, p0, Lio/minio/ObjectWriteArgs;->headers:Lcom/google/common/collect/Multimap;

    iget-object v3, p0, Lio/minio/ObjectWriteArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    iget-object v4, p0, Lio/minio/ObjectWriteArgs;->sse:Lio/minio/ServerSideEncryption;

    iget-object v5, p0, Lio/minio/ObjectWriteArgs;->tags:Lio/minio/messages/Tags;

    iget-object v6, p0, Lio/minio/ObjectWriteArgs;->retention:Lio/minio/messages/Retention;

    iget-boolean v0, p0, Lio/minio/ObjectWriteArgs;->legalHold:Z

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    filled-new-array/range {v1 .. v7}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public headers()Lcom/google/common/collect/Multimap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 52
    iget-object v0, p0, Lio/minio/ObjectWriteArgs;->headers:Lcom/google/common/collect/Multimap;

    return-object v0
.end method

.method public legalHold()Z
    .locals 1

    .line 72
    iget-boolean v0, p0, Lio/minio/ObjectWriteArgs;->legalHold:Z

    return v0
.end method

.method public retention()Lio/minio/messages/Retention;
    .locals 1

    .line 68
    iget-object v0, p0, Lio/minio/ObjectWriteArgs;->retention:Lio/minio/messages/Retention;

    return-object v0
.end method

.method public sse()Lio/minio/ServerSideEncryption;
    .locals 1

    .line 60
    iget-object v0, p0, Lio/minio/ObjectWriteArgs;->sse:Lio/minio/ServerSideEncryption;

    return-object v0
.end method

.method public tags()Lio/minio/messages/Tags;
    .locals 1

    .line 64
    iget-object v0, p0, Lio/minio/ObjectWriteArgs;->tags:Lio/minio/messages/Tags;

    return-object v0
.end method

.method public userMetadata()Lcom/google/common/collect/Multimap;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 56
    iget-object v0, p0, Lio/minio/ObjectWriteArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    return-object v0
.end method

.method protected validateSse(Lokhttp3/HttpUrl;)V
    .locals 1
    .param p1, "url"    # Lokhttp3/HttpUrl;

    .line 108
    iget-object v0, p0, Lio/minio/ObjectWriteArgs;->sse:Lio/minio/ServerSideEncryption;

    invoke-virtual {p0, v0, p1}, Lio/minio/ObjectWriteArgs;->checkSse(Lio/minio/ServerSideEncryption;Lokhttp3/HttpUrl;)V

    .line 109
    return-void
.end method
