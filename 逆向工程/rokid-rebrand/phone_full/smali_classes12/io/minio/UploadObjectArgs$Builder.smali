.class public final Lio/minio/UploadObjectArgs$Builder;
.super Lio/minio/PutObjectBaseArgs$Builder;
.source "UploadObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/UploadObjectArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/PutObjectBaseArgs$Builder<",
        "Lio/minio/UploadObjectArgs$Builder;",
        "Lio/minio/UploadObjectArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 53
    invoke-direct {p0}, Lio/minio/PutObjectBaseArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$contentType$4(Ljava/lang/String;Lio/minio/UploadObjectArgs;)V
    .locals 0
    .param p0, "contentType"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/UploadObjectArgs;

    .line 88
    iput-object p0, p1, Lio/minio/UploadObjectArgs;->contentType:Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$filename$0(Ljava/lang/String;Lio/minio/UploadObjectArgs;)V
    .locals 0
    .param p0, "filename"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/UploadObjectArgs;

    .line 75
    invoke-static {p1, p0}, Lio/minio/UploadObjectArgs;->access$002(Lio/minio/UploadObjectArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$filename$1(JLio/minio/UploadObjectArgs;)V
    .locals 0
    .param p0, "objectSize"    # J
    .param p2, "args"    # Lio/minio/UploadObjectArgs;

    .line 76
    iput-wide p0, p2, Lio/minio/UploadObjectArgs;->objectSize:J

    return-void
.end method

.method static synthetic lambda$filename$2(JLio/minio/UploadObjectArgs;)V
    .locals 0
    .param p0, "pSize"    # J
    .param p2, "args"    # Lio/minio/UploadObjectArgs;

    .line 77
    iput-wide p0, p2, Lio/minio/UploadObjectArgs;->partSize:J

    return-void
.end method

.method static synthetic lambda$filename$3(ILio/minio/UploadObjectArgs;)V
    .locals 0
    .param p0, "partCount"    # I
    .param p1, "args"    # Lio/minio/UploadObjectArgs;

    .line 78
    iput p0, p1, Lio/minio/UploadObjectArgs;->partCount:I

    return-void
.end method

.method private validateFilename(Ljava/lang/String;)V
    .locals 3
    .param p1, "filename"    # Ljava/lang/String;

    .line 61
    const-string v0, "filename"

    invoke-virtual {p0, p1, v0}, Lio/minio/UploadObjectArgs$Builder;->validateNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 62
    const/4 v0, 0x0

    new-array v1, v0, [Ljava/lang/String;

    invoke-static {p1, v1}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v1

    new-array v0, v0, [Ljava/nio/file/LinkOption;

    invoke-static {v1, v0}, Ljava/nio/file/Files;->isRegularFile(Ljava/nio/file/Path;[Ljava/nio/file/LinkOption;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 65
    return-void

    .line 63
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " not a regular file"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public contentType(Ljava/lang/String;)Lio/minio/UploadObjectArgs$Builder;
    .locals 2
    .param p1, "contentType"    # Ljava/lang/String;

    .line 87
    const-string v0, "content type"

    invoke-virtual {p0, p1, v0}, Lio/minio/UploadObjectArgs$Builder;->validateNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 88
    iget-object v0, p0, Lio/minio/UploadObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda4;

    invoke-direct {v1, p1}, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda4;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 89
    return-object p0
.end method

.method public filename(Ljava/lang/String;)Lio/minio/UploadObjectArgs$Builder;
    .locals 2
    .param p1, "filename"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 83
    const-wide/16 v0, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lio/minio/UploadObjectArgs$Builder;->filename(Ljava/lang/String;J)Lio/minio/UploadObjectArgs$Builder;

    move-result-object v0

    return-object v0
.end method

.method public filename(Ljava/lang/String;J)Lio/minio/UploadObjectArgs$Builder;
    .locals 8
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "partSize"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 68
    invoke-direct {p0, p1}, Lio/minio/UploadObjectArgs$Builder;->validateFilename(Ljava/lang/String;)V

    .line 69
    const/4 v0, 0x0

    new-array v1, v0, [Ljava/lang/String;

    invoke-static {p1, v1}, Ljava/nio/file/Paths;->get(Ljava/lang/String;[Ljava/lang/String;)Ljava/nio/file/Path;

    move-result-object v1

    invoke-static {v1}, Ljava/nio/file/Files;->size(Ljava/nio/file/Path;)J

    move-result-wide v1

    .line 71
    .local v1, "objectSize":J
    invoke-virtual {p0, v1, v2, p2, p3}, Lio/minio/UploadObjectArgs$Builder;->getPartInfo(JJ)[J

    move-result-object v3

    .line 72
    .local v3, "partinfo":[J
    aget-wide v4, v3, v0

    .line 73
    .local v4, "pSize":J
    const/4 v0, 0x1

    aget-wide v6, v3, v0

    long-to-int v0, v6

    .line 75
    .local v0, "partCount":I
    iget-object v6, p0, Lio/minio/UploadObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v7, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v7, p1}, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v6, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 76
    iget-object v6, p0, Lio/minio/UploadObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v7, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v7, v1, v2}, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda1;-><init>(J)V

    invoke-interface {v6, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 77
    iget-object v6, p0, Lio/minio/UploadObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v7, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda2;

    invoke-direct {v7, v4, v5}, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda2;-><init>(J)V

    invoke-interface {v6, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 78
    iget-object v6, p0, Lio/minio/UploadObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v7, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda3;

    invoke-direct {v7, v0}, Lio/minio/UploadObjectArgs$Builder$$ExternalSyntheticLambda3;-><init>(I)V

    invoke-interface {v6, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 79
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 53
    check-cast p1, Lio/minio/UploadObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/UploadObjectArgs$Builder;->validate(Lio/minio/UploadObjectArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 53
    check-cast p1, Lio/minio/UploadObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/UploadObjectArgs$Builder;->validate(Lio/minio/UploadObjectArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 53
    check-cast p1, Lio/minio/UploadObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/UploadObjectArgs$Builder;->validate(Lio/minio/UploadObjectArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/UploadObjectArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/UploadObjectArgs;

    .line 56
    invoke-super {p0, p1}, Lio/minio/PutObjectBaseArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 57
    invoke-static {p1}, Lio/minio/UploadObjectArgs;->access$000(Lio/minio/UploadObjectArgs;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/UploadObjectArgs$Builder;->validateFilename(Ljava/lang/String;)V

    .line 58
    return-void
.end method
