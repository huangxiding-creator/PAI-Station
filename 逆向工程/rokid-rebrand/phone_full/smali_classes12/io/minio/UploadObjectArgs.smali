.class public Lio/minio/UploadObjectArgs;
.super Lio/minio/PutObjectBaseArgs;
.source "UploadObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/UploadObjectArgs$Builder;
    }
.end annotation


# instance fields
.field private filename:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Lio/minio/PutObjectBaseArgs;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lio/minio/UploadObjectArgs;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lio/minio/UploadObjectArgs;

    .line 25
    iget-object v0, p0, Lio/minio/UploadObjectArgs;->filename:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/UploadObjectArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/UploadObjectArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 25
    iput-object p1, p0, Lio/minio/UploadObjectArgs;->filename:Ljava/lang/String;

    return-object p1
.end method

.method public static builder()Lio/minio/UploadObjectArgs$Builder;
    .locals 1

    .line 49
    new-instance v0, Lio/minio/UploadObjectArgs$Builder;

    invoke-direct {v0}, Lio/minio/UploadObjectArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public contentType()Ljava/lang/String;
    .locals 3
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

    .line 39
    return-object v0

    .line 42
    :cond_0
    iget-object v1, p0, Lio/minio/UploadObjectArgs;->filename:Ljava/lang/String;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/String;

    invoke-static {v1, v2}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v1

    invoke-static {v1}, Ljava/nio/file/Files;->probeContentType(Ljava/nio/file/Path;)Ljava/lang/String;

    move-result-object v0

    .line 43
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    .line 44
    move-object v1, v0

    goto :goto_0

    .line 45
    :cond_1
    const-string v1, "application/octet-stream"

    .line 43
    :goto_0
    return-object v1
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 95
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 96
    :cond_0
    instance-of v0, p1, Lio/minio/UploadObjectArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 97
    :cond_1
    invoke-super {p0, p1}, Lio/minio/PutObjectBaseArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 98
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/UploadObjectArgs;

    .line 99
    .local v0, "that":Lio/minio/UploadObjectArgs;
    iget-object v1, p0, Lio/minio/UploadObjectArgs;->filename:Ljava/lang/String;

    iget-object v2, v0, Lio/minio/UploadObjectArgs;->filename:Ljava/lang/String;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public filename()Ljava/lang/String;
    .locals 1

    .line 29
    iget-object v0, p0, Lio/minio/UploadObjectArgs;->filename:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 104
    invoke-super {p0}, Lio/minio/PutObjectBaseArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/UploadObjectArgs;->filename:Ljava/lang/String;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method
