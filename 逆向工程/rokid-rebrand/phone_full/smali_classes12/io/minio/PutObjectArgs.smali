.class public Lio/minio/PutObjectArgs;
.super Lio/minio/PutObjectBaseArgs;
.source "PutObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/PutObjectArgs$Builder;
    }
.end annotation


# instance fields
.field private stream:Ljava/io/BufferedInputStream;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Lio/minio/PutObjectBaseArgs;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lio/minio/PutObjectArgs;)Ljava/io/BufferedInputStream;
    .locals 1
    .param p0, "x0"    # Lio/minio/PutObjectArgs;

    .line 25
    iget-object v0, p0, Lio/minio/PutObjectArgs;->stream:Ljava/io/BufferedInputStream;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/PutObjectArgs;Ljava/io/BufferedInputStream;)Ljava/io/BufferedInputStream;
    .locals 0
    .param p0, "x0"    # Lio/minio/PutObjectArgs;
    .param p1, "x1"    # Ljava/io/BufferedInputStream;

    .line 25
    iput-object p1, p0, Lio/minio/PutObjectArgs;->stream:Ljava/io/BufferedInputStream;

    return-object p1
.end method

.method public static builder()Lio/minio/PutObjectArgs$Builder;
    .locals 1

    .line 42
    new-instance v0, Lio/minio/PutObjectArgs$Builder;

    invoke-direct {v0}, Lio/minio/PutObjectArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public contentType()Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 37
    invoke-super {p0}, Lio/minio/PutObjectBaseArgs;->contentType()Ljava/lang/String;

    move-result-object v0

    .line 38
    .local v0, "contentType":Ljava/lang/String;
    if-eqz v0, :cond_0

    move-object v1, v0

    goto :goto_0

    :cond_0
    const-string v1, "application/octet-stream"

    :goto_0
    return-object v1
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 97
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 98
    :cond_0
    instance-of v0, p1, Lio/minio/PutObjectArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 99
    :cond_1
    invoke-super {p0, p1}, Lio/minio/PutObjectBaseArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 100
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/PutObjectArgs;

    .line 101
    .local v0, "that":Lio/minio/PutObjectArgs;
    iget-object v1, p0, Lio/minio/PutObjectArgs;->stream:Ljava/io/BufferedInputStream;

    iget-object v2, v0, Lio/minio/PutObjectArgs;->stream:Ljava/io/BufferedInputStream;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 2

    .line 106
    invoke-super {p0}, Lio/minio/PutObjectBaseArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/PutObjectArgs;->stream:Ljava/io/BufferedInputStream;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public stream()Ljava/io/BufferedInputStream;
    .locals 1

    .line 29
    iget-object v0, p0, Lio/minio/PutObjectArgs;->stream:Ljava/io/BufferedInputStream;

    return-object v0
.end method
