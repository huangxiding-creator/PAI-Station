.class public abstract Lio/minio/ObjectArgs;
.super Lio/minio/BucketArgs;
.source "ObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ObjectArgs$Builder;
    }
.end annotation


# instance fields
.field protected objectName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method


# virtual methods
.method protected checkSse(Lio/minio/ServerSideEncryption;Lokhttp3/HttpUrl;)V
    .locals 3
    .param p1, "sse"    # Lio/minio/ServerSideEncryption;
    .param p2, "url"    # Lokhttp3/HttpUrl;

    .line 32
    if-nez p1, :cond_0

    .line 33
    return-void

    .line 36
    :cond_0
    invoke-virtual {p1}, Lio/minio/ServerSideEncryption;->tlsRequired()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p2}, Lokhttp3/HttpUrl;->isHttps()Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    .line 37
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " operations must be performed over a secure connection."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 40
    :cond_2
    :goto_0
    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 70
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 71
    :cond_0
    instance-of v0, p1, Lio/minio/ObjectArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 72
    :cond_1
    invoke-super {p0, p1}, Lio/minio/BucketArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 73
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/ObjectArgs;

    .line 74
    .local v0, "that":Lio/minio/ObjectArgs;
    iget-object v1, p0, Lio/minio/ObjectArgs;->objectName:Ljava/lang/String;

    iget-object v2, v0, Lio/minio/ObjectArgs;->objectName:Ljava/lang/String;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 2

    .line 79
    invoke-super {p0}, Lio/minio/BucketArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/ObjectArgs;->objectName:Ljava/lang/String;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public object()Ljava/lang/String;
    .locals 1

    .line 28
    iget-object v0, p0, Lio/minio/ObjectArgs;->objectName:Ljava/lang/String;

    return-object v0
.end method
