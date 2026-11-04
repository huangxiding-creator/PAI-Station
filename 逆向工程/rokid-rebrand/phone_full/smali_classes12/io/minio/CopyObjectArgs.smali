.class public Lio/minio/CopyObjectArgs;
.super Lio/minio/ObjectWriteArgs;
.source "CopyObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/CopyObjectArgs$Builder;
    }
.end annotation


# instance fields
.field private metadataDirective:Lio/minio/Directive;

.field private source:Lio/minio/CopySource;

.field private taggingDirective:Lio/minio/Directive;


# direct methods
.method protected constructor <init>()V
    .locals 1

    .line 29
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs;-><init>()V

    .line 25
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    .line 29
    return-void
.end method

.method public constructor <init>(Lio/minio/ComposeObjectArgs;)V
    .locals 3
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;

    .line 31
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs;-><init>()V

    .line 25
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    .line 32
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    .line 33
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    .line 34
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->bucketName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->bucketName:Ljava/lang/String;

    .line 35
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->region:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->region:Ljava/lang/String;

    .line 36
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->objectName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->objectName:Ljava/lang/String;

    .line 37
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->headers:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->headers:Lcom/google/common/collect/Multimap;

    .line 38
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    .line 39
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->sse:Lio/minio/ServerSideEncryption;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->sse:Lio/minio/ServerSideEncryption;

    .line 40
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->tags:Lio/minio/messages/Tags;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->tags:Lio/minio/messages/Tags;

    .line 41
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->retention:Lio/minio/messages/Retention;

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->retention:Lio/minio/messages/Retention;

    .line 42
    iget-boolean v0, p1, Lio/minio/ComposeObjectArgs;->legalHold:Z

    iput-boolean v0, p0, Lio/minio/CopyObjectArgs;->legalHold:Z

    .line 43
    new-instance v0, Lio/minio/CopySource;

    invoke-virtual {p1}, Lio/minio/ComposeObjectArgs;->sources()Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/minio/ObjectConditionalReadArgs;

    invoke-direct {v0, v1}, Lio/minio/CopySource;-><init>(Lio/minio/ObjectConditionalReadArgs;)V

    iput-object v0, p0, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    .line 44
    return-void
.end method

.method static synthetic access$000(Lio/minio/CopyObjectArgs;)Lio/minio/CopySource;
    .locals 1
    .param p0, "x0"    # Lio/minio/CopyObjectArgs;

    .line 24
    iget-object v0, p0, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/CopyObjectArgs;Lio/minio/CopySource;)Lio/minio/CopySource;
    .locals 0
    .param p0, "x0"    # Lio/minio/CopyObjectArgs;
    .param p1, "x1"    # Lio/minio/CopySource;

    .line 24
    iput-object p1, p0, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    return-object p1
.end method

.method static synthetic access$100(Lio/minio/CopyObjectArgs;)Lio/minio/Directive;
    .locals 1
    .param p0, "x0"    # Lio/minio/CopyObjectArgs;

    .line 24
    iget-object v0, p0, Lio/minio/CopyObjectArgs;->metadataDirective:Lio/minio/Directive;

    return-object v0
.end method

.method static synthetic access$102(Lio/minio/CopyObjectArgs;Lio/minio/Directive;)Lio/minio/Directive;
    .locals 0
    .param p0, "x0"    # Lio/minio/CopyObjectArgs;
    .param p1, "x1"    # Lio/minio/Directive;

    .line 24
    iput-object p1, p0, Lio/minio/CopyObjectArgs;->metadataDirective:Lio/minio/Directive;

    return-object p1
.end method

.method static synthetic access$200(Lio/minio/CopyObjectArgs;)Lio/minio/Directive;
    .locals 1
    .param p0, "x0"    # Lio/minio/CopyObjectArgs;

    .line 24
    iget-object v0, p0, Lio/minio/CopyObjectArgs;->taggingDirective:Lio/minio/Directive;

    return-object v0
.end method

.method static synthetic access$202(Lio/minio/CopyObjectArgs;Lio/minio/Directive;)Lio/minio/Directive;
    .locals 0
    .param p0, "x0"    # Lio/minio/CopyObjectArgs;
    .param p1, "x1"    # Lio/minio/Directive;

    .line 24
    iput-object p1, p0, Lio/minio/CopyObjectArgs;->taggingDirective:Lio/minio/Directive;

    return-object p1
.end method

.method public static builder()Lio/minio/CopyObjectArgs$Builder;
    .locals 1

    .line 59
    new-instance v0, Lio/minio/CopyObjectArgs$Builder;

    invoke-direct {v0}, Lio/minio/CopyObjectArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 105
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 106
    :cond_0
    instance-of v1, p1, Lio/minio/CopyObjectArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 107
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectWriteArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 108
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/CopyObjectArgs;

    .line 109
    .local v1, "that":Lio/minio/CopyObjectArgs;
    iget-object v3, p0, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    iget-object v4, v1, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/CopyObjectArgs;->metadataDirective:Lio/minio/Directive;

    iget-object v4, v1, Lio/minio/CopyObjectArgs;->metadataDirective:Lio/minio/Directive;

    if-ne v3, v4, :cond_3

    iget-object v3, p0, Lio/minio/CopyObjectArgs;->taggingDirective:Lio/minio/Directive;

    iget-object v4, v1, Lio/minio/CopyObjectArgs;->taggingDirective:Lio/minio/Directive;

    if-ne v3, v4, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 4

    .line 116
    invoke-super {p0}, Lio/minio/ObjectWriteArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    iget-object v2, p0, Lio/minio/CopyObjectArgs;->metadataDirective:Lio/minio/Directive;

    iget-object v3, p0, Lio/minio/CopyObjectArgs;->taggingDirective:Lio/minio/Directive;

    filled-new-array {v0, v1, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public metadataDirective()Lio/minio/Directive;
    .locals 1

    .line 51
    iget-object v0, p0, Lio/minio/CopyObjectArgs;->metadataDirective:Lio/minio/Directive;

    return-object v0
.end method

.method public source()Lio/minio/CopySource;
    .locals 1

    .line 47
    iget-object v0, p0, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    return-object v0
.end method

.method public taggingDirective()Lio/minio/Directive;
    .locals 1

    .line 55
    iget-object v0, p0, Lio/minio/CopyObjectArgs;->taggingDirective:Lio/minio/Directive;

    return-object v0
.end method

.method public validateSse(Lokhttp3/HttpUrl;)V
    .locals 1
    .param p1, "url"    # Lokhttp3/HttpUrl;

    .line 64
    invoke-super {p0, p1}, Lio/minio/ObjectWriteArgs;->validateSse(Lokhttp3/HttpUrl;)V

    .line 65
    iget-object v0, p0, Lio/minio/CopyObjectArgs;->source:Lio/minio/CopySource;

    invoke-virtual {v0, p1}, Lio/minio/CopySource;->validateSsec(Lokhttp3/HttpUrl;)V

    .line 66
    return-void
.end method
