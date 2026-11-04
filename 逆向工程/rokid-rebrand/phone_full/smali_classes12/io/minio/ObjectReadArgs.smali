.class public abstract Lio/minio/ObjectReadArgs;
.super Lio/minio/ObjectVersionArgs;
.source "ObjectReadArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ObjectReadArgs$Builder;
    }
.end annotation


# instance fields
.field protected ssec:Lio/minio/ServerSideEncryptionCustomerKey;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 46
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 47
    :cond_0
    instance-of v0, p1, Lio/minio/ObjectReadArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 48
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectVersionArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 49
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/ObjectReadArgs;

    .line 50
    .local v0, "that":Lio/minio/ObjectReadArgs;
    iget-object v1, p0, Lio/minio/ObjectReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    iget-object v2, v0, Lio/minio/ObjectReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 2

    .line 55
    invoke-super {p0}, Lio/minio/ObjectVersionArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/ObjectReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public ssec()Lio/minio/ServerSideEncryptionCustomerKey;
    .locals 1

    .line 27
    iget-object v0, p0, Lio/minio/ObjectReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    return-object v0
.end method

.method protected validateSsec(Lokhttp3/HttpUrl;)V
    .locals 1
    .param p1, "url"    # Lokhttp3/HttpUrl;

    .line 31
    iget-object v0, p0, Lio/minio/ObjectReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    invoke-virtual {p0, v0, p1}, Lio/minio/ObjectReadArgs;->checkSse(Lio/minio/ServerSideEncryption;Lokhttp3/HttpUrl;)V

    .line 32
    return-void
.end method
