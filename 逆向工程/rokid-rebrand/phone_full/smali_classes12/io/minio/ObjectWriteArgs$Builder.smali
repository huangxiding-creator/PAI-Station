.class public abstract Lio/minio/ObjectWriteArgs$Builder;
.super Lio/minio/ObjectArgs$Builder;
.source "ObjectWriteArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/ObjectWriteArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<B:",
        "Lio/minio/ObjectWriteArgs$Builder<",
        "TB;TA;>;A:",
        "Lio/minio/ObjectWriteArgs;",
        ">",
        "Lio/minio/ObjectArgs$Builder<",
        "TB;TA;>;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 113
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    invoke-direct {p0}, Lio/minio/ObjectArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$headers$0(Lcom/google/common/collect/Multimap;Lio/minio/ObjectWriteArgs;)V
    .locals 0
    .param p0, "headersCopy"    # Lcom/google/common/collect/Multimap;
    .param p1, "args"    # Lio/minio/ObjectWriteArgs;

    .line 117
    iput-object p0, p1, Lio/minio/ObjectWriteArgs;->headers:Lcom/google/common/collect/Multimap;

    return-void
.end method

.method static synthetic lambda$headers$1(Lcom/google/common/collect/Multimap;Lio/minio/ObjectWriteArgs;)V
    .locals 0
    .param p0, "headersCopy"    # Lcom/google/common/collect/Multimap;
    .param p1, "args"    # Lio/minio/ObjectWriteArgs;

    .line 123
    iput-object p0, p1, Lio/minio/ObjectWriteArgs;->headers:Lcom/google/common/collect/Multimap;

    return-void
.end method

.method static synthetic lambda$legalHold$7(ZLio/minio/ObjectWriteArgs;)V
    .locals 0
    .param p0, "flag"    # Z
    .param p1, "args"    # Lio/minio/ObjectWriteArgs;

    .line 170
    iput-boolean p0, p1, Lio/minio/ObjectWriteArgs;->legalHold:Z

    return-void
.end method

.method static synthetic lambda$retention$6(Lio/minio/messages/Retention;Lio/minio/ObjectWriteArgs;)V
    .locals 0
    .param p0, "retention"    # Lio/minio/messages/Retention;
    .param p1, "args"    # Lio/minio/ObjectWriteArgs;

    .line 165
    iput-object p0, p1, Lio/minio/ObjectWriteArgs;->retention:Lio/minio/messages/Retention;

    return-void
.end method

.method static synthetic lambda$sse$3(Lio/minio/ServerSideEncryption;Lio/minio/ObjectWriteArgs;)V
    .locals 0
    .param p0, "sse"    # Lio/minio/ServerSideEncryption;
    .param p1, "args"    # Lio/minio/ObjectWriteArgs;

    .line 148
    iput-object p0, p1, Lio/minio/ObjectWriteArgs;->sse:Lio/minio/ServerSideEncryption;

    return-void
.end method

.method static synthetic lambda$tags$4(Lio/minio/messages/Tags;Lio/minio/ObjectWriteArgs;)V
    .locals 0
    .param p0, "tags"    # Lio/minio/messages/Tags;
    .param p1, "args"    # Lio/minio/ObjectWriteArgs;

    .line 154
    iput-object p0, p1, Lio/minio/ObjectWriteArgs;->tags:Lio/minio/messages/Tags;

    return-void
.end method

.method static synthetic lambda$tags$5(Lio/minio/messages/Tags;Lio/minio/ObjectWriteArgs;)V
    .locals 0
    .param p0, "tagsCopy"    # Lio/minio/messages/Tags;
    .param p1, "args"    # Lio/minio/ObjectWriteArgs;

    .line 160
    iput-object p0, p1, Lio/minio/ObjectWriteArgs;->tags:Lio/minio/messages/Tags;

    return-void
.end method

.method static synthetic lambda$userMetadata$2(Lcom/google/common/collect/Multimap;Lio/minio/ObjectWriteArgs;)V
    .locals 0
    .param p0, "finalUserMetadata"    # Lcom/google/common/collect/Multimap;
    .param p1, "args"    # Lio/minio/ObjectWriteArgs;

    .line 143
    iput-object p0, p1, Lio/minio/ObjectWriteArgs;->userMetadata:Lcom/google/common/collect/Multimap;

    return-void
.end method


# virtual methods
.method public headers(Lcom/google/common/collect/Multimap;)Lio/minio/ObjectWriteArgs$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)TB;"
        }
    .end annotation

    .line 122
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    .local p1, "headers":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lio/minio/ObjectWriteArgs$Builder;->copyMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 123
    .local v0, "headersCopy":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v1, p0, Lio/minio/ObjectWriteArgs$Builder;->operations:Ljava/util/List;

    new-instance v2, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda3;

    invoke-direct {v2, v0}, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda3;-><init>(Lcom/google/common/collect/Multimap;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 124
    return-object p0
.end method

.method public headers(Ljava/util/Map;)Lio/minio/ObjectWriteArgs$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)TB;"
        }
    .end annotation

    .line 116
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    .local p1, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lio/minio/ObjectWriteArgs$Builder;->toMultimap(Ljava/util/Map;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    .line 117
    .local v0, "headersCopy":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v1, p0, Lio/minio/ObjectWriteArgs$Builder;->operations:Ljava/util/List;

    new-instance v2, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda5;

    invoke-direct {v2, v0}, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda5;-><init>(Lcom/google/common/collect/Multimap;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 118
    return-object p0
.end method

.method public legalHold(Z)Lio/minio/ObjectWriteArgs$Builder;
    .locals 2
    .param p1, "flag"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z)TB;"
        }
    .end annotation

    .line 170
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    iget-object v0, p0, Lio/minio/ObjectWriteArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda1;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 171
    return-object p0
.end method

.method public retention(Lio/minio/messages/Retention;)Lio/minio/ObjectWriteArgs$Builder;
    .locals 2
    .param p1, "retention"    # Lio/minio/messages/Retention;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/messages/Retention;",
            ")TB;"
        }
    .end annotation

    .line 165
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    iget-object v0, p0, Lio/minio/ObjectWriteArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda6;

    invoke-direct {v1, p1}, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda6;-><init>(Lio/minio/messages/Retention;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 166
    return-object p0
.end method

.method public sse(Lio/minio/ServerSideEncryption;)Lio/minio/ObjectWriteArgs$Builder;
    .locals 2
    .param p1, "sse"    # Lio/minio/ServerSideEncryption;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/ServerSideEncryption;",
            ")TB;"
        }
    .end annotation

    .line 148
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    iget-object v0, p0, Lio/minio/ObjectWriteArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda2;

    invoke-direct {v1, p1}, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda2;-><init>(Lio/minio/ServerSideEncryption;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 149
    return-object p0
.end method

.method public tags(Lio/minio/messages/Tags;)Lio/minio/ObjectWriteArgs$Builder;
    .locals 3
    .param p1, "tags"    # Lio/minio/messages/Tags;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/messages/Tags;",
            ")TB;"
        }
    .end annotation

    .line 159
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    if-nez p1, :cond_0

    new-instance v0, Lio/minio/messages/Tags;

    invoke-direct {v0}, Lio/minio/messages/Tags;-><init>()V

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lio/minio/messages/Tags;->get()Ljava/util/Map;

    move-result-object v0

    invoke-static {v0}, Lio/minio/messages/Tags;->newObjectTags(Ljava/util/Map;)Lio/minio/messages/Tags;

    move-result-object v0

    .line 160
    .local v0, "tagsCopy":Lio/minio/messages/Tags;
    :goto_0
    iget-object v1, p0, Lio/minio/ObjectWriteArgs$Builder;->operations:Ljava/util/List;

    new-instance v2, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v2, v0}, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda0;-><init>(Lio/minio/messages/Tags;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 161
    return-object p0
.end method

.method public tags(Ljava/util/Map;)Lio/minio/ObjectWriteArgs$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)TB;"
        }
    .end annotation

    .line 153
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    .local p1, "map":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p1, :cond_0

    new-instance v0, Lio/minio/messages/Tags;

    invoke-direct {v0}, Lio/minio/messages/Tags;-><init>()V

    goto :goto_0

    :cond_0
    invoke-static {p1}, Lio/minio/messages/Tags;->newObjectTags(Ljava/util/Map;)Lio/minio/messages/Tags;

    move-result-object v0

    .line 154
    .local v0, "tags":Lio/minio/messages/Tags;
    :goto_0
    iget-object v1, p0, Lio/minio/ObjectWriteArgs$Builder;->operations:Ljava/util/List;

    new-instance v2, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda4;

    invoke-direct {v2, v0}, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda4;-><init>(Lio/minio/messages/Tags;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 155
    return-object p0
.end method

.method public userMetadata(Lcom/google/common/collect/Multimap;)Lio/minio/ObjectWriteArgs$Builder;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)TB;"
        }
    .end annotation

    .line 132
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    .local p1, "userMetadata":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    .line 133
    .local v0, "userMetadataCopy":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p1, :cond_1

    .line 134
    invoke-interface {p1}, Lcom/google/common/collect/Multimap;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 135
    .local v2, "key":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 136
    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v2, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    const-string/jumbo v5, "x-amz-meta-"

    invoke-virtual {v4, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    const-string v5, ""

    :cond_0
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 137
    invoke-interface {p1, v2}, Lcom/google/common/collect/Multimap;->get(Ljava/lang/Object;)Ljava/util/Collection;

    move-result-object v4

    .line 135
    invoke-interface {v0, v3, v4}, Lcom/google/common/collect/Multimap;->putAll(Ljava/lang/Object;Ljava/lang/Iterable;)Z

    .line 138
    .end local v2    # "key":Ljava/lang/String;
    goto :goto_0

    .line 141
    :cond_1
    nop

    .line 142
    invoke-static {v0}, Lcom/google/common/collect/Multimaps;->unmodifiableMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v1

    .line 143
    .local v1, "finalUserMetadata":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v2, p0, Lio/minio/ObjectWriteArgs$Builder;->operations:Ljava/util/List;

    new-instance v3, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda7;

    invoke-direct {v3, v1}, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda7;-><init>(Lcom/google/common/collect/Multimap;)V

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 144
    return-object p0
.end method

.method public userMetadata(Ljava/util/Map;)Lio/minio/ObjectWriteArgs$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)TB;"
        }
    .end annotation

    .line 128
    .local p0, "this":Lio/minio/ObjectWriteArgs$Builder;, "Lio/minio/ObjectWriteArgs$Builder<TB;TA;>;"
    .local p1, "userMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p1, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-static {p1}, Lcom/google/common/collect/Multimaps;->forMap(Ljava/util/Map;)Lcom/google/common/collect/SetMultimap;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, v0}, Lio/minio/ObjectWriteArgs$Builder;->userMetadata(Lcom/google/common/collect/Multimap;)Lio/minio/ObjectWriteArgs$Builder;

    move-result-object v0

    return-object v0
.end method
