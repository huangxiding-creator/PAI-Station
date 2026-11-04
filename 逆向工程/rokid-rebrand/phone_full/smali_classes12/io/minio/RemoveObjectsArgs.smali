.class public Lio/minio/RemoveObjectsArgs;
.super Lio/minio/BucketArgs;
.source "RemoveObjectsArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/RemoveObjectsArgs$Builder;
    }
.end annotation


# instance fields
.field private bypassGovernanceMode:Z

.field private objects:Ljava/lang/Iterable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Iterable<",
            "Lio/minio/messages/DeleteObject;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 27
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    .line 29
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lio/minio/RemoveObjectsArgs;->objects:Ljava/lang/Iterable;

    return-void
.end method

.method static synthetic access$002(Lio/minio/RemoveObjectsArgs;Ljava/lang/Iterable;)Ljava/lang/Iterable;
    .locals 0
    .param p0, "x0"    # Lio/minio/RemoveObjectsArgs;
    .param p1, "x1"    # Ljava/lang/Iterable;

    .line 27
    iput-object p1, p0, Lio/minio/RemoveObjectsArgs;->objects:Ljava/lang/Iterable;

    return-object p1
.end method

.method static synthetic access$102(Lio/minio/RemoveObjectsArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/RemoveObjectsArgs;
    .param p1, "x1"    # Z

    .line 27
    iput-boolean p1, p0, Lio/minio/RemoveObjectsArgs;->bypassGovernanceMode:Z

    return p1
.end method

.method public static builder()Lio/minio/RemoveObjectsArgs$Builder;
    .locals 1

    .line 40
    new-instance v0, Lio/minio/RemoveObjectsArgs$Builder;

    invoke-direct {v0}, Lio/minio/RemoveObjectsArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public bypassGovernanceMode()Z
    .locals 1

    .line 32
    iget-boolean v0, p0, Lio/minio/RemoveObjectsArgs;->bypassGovernanceMode:Z

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 59
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 60
    :cond_0
    instance-of v1, p1, Lio/minio/RemoveObjectsArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 61
    :cond_1
    invoke-super {p0, p1}, Lio/minio/BucketArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 62
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/RemoveObjectsArgs;

    .line 63
    .local v1, "that":Lio/minio/RemoveObjectsArgs;
    iget-boolean v3, p0, Lio/minio/RemoveObjectsArgs;->bypassGovernanceMode:Z

    iget-boolean v4, v1, Lio/minio/RemoveObjectsArgs;->bypassGovernanceMode:Z

    if-ne v3, v4, :cond_3

    iget-object v3, p0, Lio/minio/RemoveObjectsArgs;->objects:Ljava/lang/Iterable;

    iget-object v4, v1, Lio/minio/RemoveObjectsArgs;->objects:Ljava/lang/Iterable;

    .line 64
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    .line 63
    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 3

    .line 69
    invoke-super {p0}, Lio/minio/BucketArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-boolean v1, p0, Lio/minio/RemoveObjectsArgs;->bypassGovernanceMode:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    iget-object v2, p0, Lio/minio/RemoveObjectsArgs;->objects:Ljava/lang/Iterable;

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public objects()Ljava/lang/Iterable;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Iterable<",
            "Lio/minio/messages/DeleteObject;",
            ">;"
        }
    .end annotation

    .line 36
    iget-object v0, p0, Lio/minio/RemoveObjectsArgs;->objects:Ljava/lang/Iterable;

    return-object v0
.end method
