.class public Lio/minio/ComposeObjectArgs;
.super Lio/minio/ObjectWriteArgs;
.source "ComposeObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ComposeObjectArgs$Builder;
    }
.end annotation


# instance fields
.field sources:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/ComposeSource;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs;-><init>()V

    return-void
.end method

.method public constructor <init>(Lio/minio/CopyObjectArgs;)V
    .locals 3
    .param p1, "args"    # Lio/minio/CopyObjectArgs;

    .line 33
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs;-><init>()V

    .line 34
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    .line 35
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    .line 36
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->bucketName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->bucketName:Ljava/lang/String;

    .line 37
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->region:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->region:Ljava/lang/String;

    .line 38
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->objectName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->objectName:Ljava/lang/String;

    .line 39
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->headers:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->headers:Lcom/google/common/collect/Multimap;

    .line 40
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    .line 41
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->sse:Lio/minio/ServerSideEncryption;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->sse:Lio/minio/ServerSideEncryption;

    .line 42
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->tags:Lio/minio/messages/Tags;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->tags:Lio/minio/messages/Tags;

    .line 43
    iget-object v0, p1, Lio/minio/CopyObjectArgs;->retention:Lio/minio/messages/Retention;

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->retention:Lio/minio/messages/Retention;

    .line 44
    iget-boolean v0, p1, Lio/minio/CopyObjectArgs;->legalHold:Z

    iput-boolean v0, p0, Lio/minio/ComposeObjectArgs;->legalHold:Z

    .line 45
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lio/minio/ComposeObjectArgs;->sources:Ljava/util/List;

    .line 46
    iget-object v0, p0, Lio/minio/ComposeObjectArgs;->sources:Ljava/util/List;

    new-instance v1, Lio/minio/ComposeSource;

    invoke-virtual {p1}, Lio/minio/CopyObjectArgs;->source()Lio/minio/CopySource;

    move-result-object v2

    invoke-direct {v1, v2}, Lio/minio/ComposeSource;-><init>(Lio/minio/ObjectConditionalReadArgs;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 47
    return-void
.end method

.method public static builder()Lio/minio/ComposeObjectArgs$Builder;
    .locals 1

    .line 54
    new-instance v0, Lio/minio/ComposeObjectArgs$Builder;

    invoke-direct {v0}, Lio/minio/ComposeObjectArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 88
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 89
    :cond_0
    instance-of v0, p1, Lio/minio/ComposeObjectArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 90
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectWriteArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 91
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/ComposeObjectArgs;

    .line 92
    .local v0, "that":Lio/minio/ComposeObjectArgs;
    iget-object v1, p0, Lio/minio/ComposeObjectArgs;->sources:Ljava/util/List;

    iget-object v2, v0, Lio/minio/ComposeObjectArgs;->sources:Ljava/util/List;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 2

    .line 97
    invoke-super {p0}, Lio/minio/ObjectWriteArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/ComposeObjectArgs;->sources:Ljava/util/List;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public sources()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/ComposeSource;",
            ">;"
        }
    .end annotation

    .line 50
    iget-object v0, p0, Lio/minio/ComposeObjectArgs;->sources:Ljava/util/List;

    return-object v0
.end method

.method public validateSse(Lokhttp3/HttpUrl;)V
    .locals 2
    .param p1, "url"    # Lokhttp3/HttpUrl;

    .line 59
    invoke-super {p0, p1}, Lio/minio/ObjectWriteArgs;->validateSse(Lokhttp3/HttpUrl;)V

    .line 60
    iget-object v0, p0, Lio/minio/ComposeObjectArgs;->sources:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/minio/ComposeSource;

    .line 61
    .local v1, "source":Lio/minio/ComposeSource;
    invoke-virtual {v1, p1}, Lio/minio/ComposeSource;->validateSsec(Lokhttp3/HttpUrl;)V

    .line 62
    .end local v1    # "source":Lio/minio/ComposeSource;
    goto :goto_0

    .line 63
    :cond_0
    return-void
.end method
