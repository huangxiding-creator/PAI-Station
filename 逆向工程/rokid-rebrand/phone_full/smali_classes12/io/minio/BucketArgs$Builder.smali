.class public abstract Lio/minio/BucketArgs$Builder;
.super Lio/minio/BaseArgs$Builder;
.source "BucketArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/BucketArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<B:",
        "Lio/minio/BucketArgs$Builder<",
        "TB;TA;>;A:",
        "Lio/minio/BucketArgs;",
        ">",
        "Lio/minio/BaseArgs$Builder<",
        "TB;TA;>;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 35
    .local p0, "this":Lio/minio/BucketArgs$Builder;, "Lio/minio/BucketArgs$Builder<TB;TA;>;"
    invoke-direct {p0}, Lio/minio/BaseArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$bucket$0(Ljava/lang/String;Lio/minio/BucketArgs;)V
    .locals 0
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/BucketArgs;

    .line 73
    iput-object p0, p1, Lio/minio/BucketArgs;->bucketName:Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$region$1(Ljava/lang/String;Lio/minio/BucketArgs;)V
    .locals 0
    .param p0, "region"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/BucketArgs;

    .line 80
    iput-object p0, p1, Lio/minio/BucketArgs;->region:Ljava/lang/String;

    return-void
.end method

.method private validateRegion(Ljava/lang/String;)V
    .locals 1
    .param p1, "region"    # Ljava/lang/String;

    .line 62
    .local p0, "this":Lio/minio/BucketArgs$Builder;, "Lio/minio/BucketArgs$Builder<TB;TA;>;"
    const-string v0, "region"

    invoke-virtual {p0, p1, v0}, Lio/minio/BucketArgs$Builder;->validateNullOrNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 63
    return-void
.end method


# virtual methods
.method public bucket(Ljava/lang/String;)Lio/minio/BucketArgs$Builder;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")TB;"
        }
    .end annotation

    .line 72
    .local p0, "this":Lio/minio/BucketArgs$Builder;, "Lio/minio/BucketArgs$Builder<TB;TA;>;"
    invoke-virtual {p0, p1}, Lio/minio/BucketArgs$Builder;->validateBucketName(Ljava/lang/String;)V

    .line 73
    iget-object v0, p0, Lio/minio/BucketArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/BucketArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/BucketArgs$Builder$$ExternalSyntheticLambda1;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 74
    return-object p0
.end method

.method public region(Ljava/lang/String;)Lio/minio/BucketArgs$Builder;
    .locals 2
    .param p1, "region"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")TB;"
        }
    .end annotation

    .line 79
    .local p0, "this":Lio/minio/BucketArgs$Builder;, "Lio/minio/BucketArgs$Builder<TB;TA;>;"
    invoke-direct {p0, p1}, Lio/minio/BucketArgs$Builder;->validateRegion(Ljava/lang/String;)V

    .line 80
    iget-object v0, p0, Lio/minio/BucketArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/BucketArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/BucketArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 81
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 35
    .local p0, "this":Lio/minio/BucketArgs$Builder;, "Lio/minio/BucketArgs$Builder<TB;TA;>;"
    check-cast p1, Lio/minio/BucketArgs;

    invoke-virtual {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/BucketArgs;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TA;)V"
        }
    .end annotation

    .line 67
    .local p0, "this":Lio/minio/BucketArgs$Builder;, "Lio/minio/BucketArgs$Builder<TB;TA;>;"
    .local p1, "args":Lio/minio/BucketArgs;, "TA;"
    iget-object v0, p1, Lio/minio/BucketArgs;->bucketName:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lio/minio/BucketArgs$Builder;->validateBucketName(Ljava/lang/String;)V

    .line 68
    return-void
.end method

.method protected validateBucketName(Ljava/lang/String;)V
    .locals 4
    .param p1, "name"    # Ljava/lang/String;

    .line 38
    .local p0, "this":Lio/minio/BucketArgs$Builder;, "Lio/minio/BucketArgs$Builder<TB;TA;>;"
    const-string v0, "bucket name"

    invoke-virtual {p0, p1, v0}, Lio/minio/BucketArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 41
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x3f

    if-gt v0, v1, :cond_2

    .line 46
    const-string v0, ".."

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    const-string v1, " : "

    if-nez v0, :cond_1

    .line 53
    const-string v0, "^[a-z0-9][a-z0-9\\.\\-]+[a-z0-9]$"

    invoke-virtual {p1, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 59
    return-void

    .line 54
    :cond_0
    const-string v0, "bucket name does not follow Amazon S3 standards. For more information refer http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html"

    .line 57
    .local v0, "msg":Ljava/lang/String;
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 47
    .end local v0    # "msg":Ljava/lang/String;
    :cond_1
    const-string v0, "bucket name cannot contain successive periods. For more information refer http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html"

    .line 50
    .restart local v0    # "msg":Ljava/lang/String;
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 42
    .end local v0    # "msg":Ljava/lang/String;
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " : bucket name must be at least 3 and no more than 63 characters long"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
