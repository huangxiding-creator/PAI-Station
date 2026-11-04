.class public abstract Lio/minio/BaseArgs;
.super Ljava/lang/Object;
.source "BaseArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/BaseArgs$Builder;
    }
.end annotation


# instance fields
.field protected extraHeaders:Lcom/google/common/collect/Multimap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/common/collect/Multimap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field protected extraQueryParams:Lcom/google/common/collect/Multimap;
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

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    nop

    .line 34
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    invoke-static {v0}, Lcom/google/common/collect/Multimaps;->unmodifiableMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    iput-object v0, p0, Lio/minio/BaseArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    .line 35
    nop

    .line 36
    invoke-static {}, Lcom/google/common/collect/HashMultimap;->create()Lcom/google/common/collect/HashMultimap;

    move-result-object v0

    invoke-static {v0}, Lcom/google/common/collect/Multimaps;->unmodifiableMultimap(Lcom/google/common/collect/Multimap;)Lcom/google/common/collect/Multimap;

    move-result-object v0

    iput-object v0, p0, Lio/minio/BaseArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    .line 35
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 157
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 158
    :cond_0
    instance-of v1, p1, Lio/minio/BaseArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 159
    :cond_1
    move-object v1, p1

    check-cast v1, Lio/minio/BaseArgs;

    .line 160
    .local v1, "baseArgs":Lio/minio/BaseArgs;
    iget-object v3, p0, Lio/minio/BaseArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    iget-object v4, v1, Lio/minio/BaseArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, p0, Lio/minio/BaseArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    iget-object v4, v1, Lio/minio/BaseArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    .line 161
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    goto :goto_0

    :cond_2
    move v0, v2

    .line 160
    :goto_0
    return v0
.end method

.method public extraHeaders()Lcom/google/common/collect/Multimap;
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

    .line 39
    iget-object v0, p0, Lio/minio/BaseArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    return-object v0
.end method

.method public extraQueryParams()Lcom/google/common/collect/Multimap;
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

    .line 43
    iget-object v0, p0, Lio/minio/BaseArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 166
    iget-object v0, p0, Lio/minio/BaseArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    iget-object v1, p0, Lio/minio/BaseArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method
