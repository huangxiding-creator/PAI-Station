.class public Lio/minio/DownloadObjectArgs;
.super Lio/minio/ObjectReadArgs;
.source "DownloadObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/DownloadObjectArgs$Builder;
    }
.end annotation


# instance fields
.field private filename:Ljava/lang/String;

.field private overwrite:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Lio/minio/ObjectReadArgs;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lio/minio/DownloadObjectArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/DownloadObjectArgs;
    .param p1, "x1"    # Z

    .line 24
    iput-boolean p1, p0, Lio/minio/DownloadObjectArgs;->overwrite:Z

    return p1
.end method

.method static synthetic access$102(Lio/minio/DownloadObjectArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/DownloadObjectArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 24
    iput-object p1, p0, Lio/minio/DownloadObjectArgs;->filename:Ljava/lang/String;

    return-object p1
.end method

.method public static builder()Lio/minio/DownloadObjectArgs$Builder;
    .locals 1

    .line 37
    new-instance v0, Lio/minio/DownloadObjectArgs$Builder;

    invoke-direct {v0}, Lio/minio/DownloadObjectArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 60
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 61
    :cond_0
    instance-of v1, p1, Lio/minio/DownloadObjectArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 62
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectReadArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 63
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/DownloadObjectArgs;

    .line 64
    .local v1, "that":Lio/minio/DownloadObjectArgs;
    iget-object v3, p0, Lio/minio/DownloadObjectArgs;->filename:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/DownloadObjectArgs;->filename:Ljava/lang/String;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    .line 65
    :cond_3
    iget-boolean v3, p0, Lio/minio/DownloadObjectArgs;->overwrite:Z

    iget-boolean v4, v1, Lio/minio/DownloadObjectArgs;->overwrite:Z

    if-ne v3, v4, :cond_4

    goto :goto_0

    :cond_4
    move v0, v2

    :goto_0
    return v0
.end method

.method public filename()Ljava/lang/String;
    .locals 1

    .line 29
    iget-object v0, p0, Lio/minio/DownloadObjectArgs;->filename:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    .line 70
    invoke-super {p0}, Lio/minio/ObjectReadArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/DownloadObjectArgs;->filename:Ljava/lang/String;

    iget-boolean v2, p0, Lio/minio/DownloadObjectArgs;->overwrite:Z

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public overwrite()Z
    .locals 1

    .line 33
    iget-boolean v0, p0, Lio/minio/DownloadObjectArgs;->overwrite:Z

    return v0
.end method
