.class public abstract Lio/minio/BucketArgs;
.super Lio/minio/BaseArgs;
.source "BucketArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/BucketArgs$Builder;
    }
.end annotation


# instance fields
.field protected bucketName:Ljava/lang/String;

.field protected region:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Lio/minio/BaseArgs;-><init>()V

    return-void
.end method


# virtual methods
.method public bucket()Ljava/lang/String;
    .locals 1

    .line 27
    iget-object v0, p0, Lio/minio/BucketArgs;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 87
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 88
    :cond_0
    instance-of v1, p1, Lio/minio/BucketArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 89
    :cond_1
    invoke-super {p0, p1}, Lio/minio/BaseArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 90
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/BucketArgs;

    .line 91
    .local v1, "that":Lio/minio/BucketArgs;
    iget-object v3, p0, Lio/minio/BucketArgs;->bucketName:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/BucketArgs;->bucketName:Ljava/lang/String;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/BucketArgs;->region:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/BucketArgs;->region:Ljava/lang/String;

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

    .line 96
    invoke-super {p0}, Lio/minio/BaseArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/BucketArgs;->bucketName:Ljava/lang/String;

    iget-object v2, p0, Lio/minio/BucketArgs;->region:Ljava/lang/String;

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public region()Ljava/lang/String;
    .locals 1

    .line 31
    iget-object v0, p0, Lio/minio/BucketArgs;->region:Ljava/lang/String;

    return-object v0
.end method
