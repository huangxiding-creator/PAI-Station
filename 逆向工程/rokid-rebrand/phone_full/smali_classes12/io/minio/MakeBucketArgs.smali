.class public Lio/minio/MakeBucketArgs;
.super Lio/minio/BucketArgs;
.source "MakeBucketArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/MakeBucketArgs$Builder;
    }
.end annotation


# instance fields
.field private objectLock:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lio/minio/MakeBucketArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/MakeBucketArgs;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/minio/MakeBucketArgs;->objectLock:Z

    return p1
.end method

.method public static builder()Lio/minio/MakeBucketArgs$Builder;
    .locals 1

    .line 30
    new-instance v0, Lio/minio/MakeBucketArgs$Builder;

    invoke-direct {v0}, Lio/minio/MakeBucketArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 43
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 44
    :cond_0
    instance-of v1, p1, Lio/minio/MakeBucketArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 45
    :cond_1
    invoke-super {p0, p1}, Lio/minio/BucketArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 46
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/MakeBucketArgs;

    .line 47
    .local v1, "that":Lio/minio/MakeBucketArgs;
    iget-boolean v3, p0, Lio/minio/MakeBucketArgs;->objectLock:Z

    iget-boolean v4, v1, Lio/minio/MakeBucketArgs;->objectLock:Z

    if-ne v3, v4, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 2

    .line 52
    invoke-super {p0}, Lio/minio/BucketArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-boolean v1, p0, Lio/minio/MakeBucketArgs;->objectLock:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public objectLock()Z
    .locals 1

    .line 26
    iget-boolean v0, p0, Lio/minio/MakeBucketArgs;->objectLock:Z

    return v0
.end method
