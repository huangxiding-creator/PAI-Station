.class public final Lio/minio/UploadSnowballObjectsArgs$Builder;
.super Lio/minio/ObjectWriteArgs$Builder;
.source "UploadSnowballObjectsArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/UploadSnowballObjectsArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectWriteArgs$Builder<",
        "Lio/minio/UploadSnowballObjectsArgs$Builder;",
        "Lio/minio/UploadSnowballObjectsArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 51
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$compression$2(ZLio/minio/UploadSnowballObjectsArgs;)V
    .locals 0
    .param p0, "compression"    # Z
    .param p1, "args"    # Lio/minio/UploadSnowballObjectsArgs;

    .line 79
    invoke-static {p1, p0}, Lio/minio/UploadSnowballObjectsArgs;->access$202(Lio/minio/UploadSnowballObjectsArgs;Z)Z

    return-void
.end method

.method static synthetic lambda$objects$0(Ljava/lang/Iterable;Lio/minio/UploadSnowballObjectsArgs;)V
    .locals 0
    .param p0, "objects"    # Ljava/lang/Iterable;
    .param p1, "args"    # Lio/minio/UploadSnowballObjectsArgs;

    .line 66
    invoke-static {p1, p0}, Lio/minio/UploadSnowballObjectsArgs;->access$102(Lio/minio/UploadSnowballObjectsArgs;Ljava/lang/Iterable;)Ljava/lang/Iterable;

    return-void
.end method

.method static synthetic lambda$stagingFilename$1(Ljava/lang/String;Lio/minio/UploadSnowballObjectsArgs;)V
    .locals 0
    .param p0, "stagingFilename"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/UploadSnowballObjectsArgs;

    .line 74
    invoke-static {p1, p0}, Lio/minio/UploadSnowballObjectsArgs;->access$302(Lio/minio/UploadSnowballObjectsArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method private validateObjects(Ljava/lang/Iterable;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable<",
            "Lio/minio/SnowballObject;",
            ">;)V"
        }
    .end annotation

    .line 54
    .local p1, "objects":Ljava/lang/Iterable;, "Ljava/lang/Iterable<Lio/minio/SnowballObject;>;"
    const-string v0, "objects"

    invoke-virtual {p0, p1, v0}, Lio/minio/UploadSnowballObjectsArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 55
    return-void
.end method


# virtual methods
.method public compression(Z)Lio/minio/UploadSnowballObjectsArgs$Builder;
    .locals 2
    .param p1, "compression"    # Z

    .line 79
    iget-object v0, p0, Lio/minio/UploadSnowballObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/UploadSnowballObjectsArgs$Builder$$ExternalSyntheticLambda2;

    invoke-direct {v1, p1}, Lio/minio/UploadSnowballObjectsArgs$Builder$$ExternalSyntheticLambda2;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 80
    return-object p0
.end method

.method public objects(Ljava/lang/Iterable;)Lio/minio/UploadSnowballObjectsArgs$Builder;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable<",
            "Lio/minio/SnowballObject;",
            ">;)",
            "Lio/minio/UploadSnowballObjectsArgs$Builder;"
        }
    .end annotation

    .line 65
    .local p1, "objects":Ljava/lang/Iterable;, "Ljava/lang/Iterable<Lio/minio/SnowballObject;>;"
    invoke-direct {p0, p1}, Lio/minio/UploadSnowballObjectsArgs$Builder;->validateObjects(Ljava/lang/Iterable;)V

    .line 66
    iget-object v0, p0, Lio/minio/UploadSnowballObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/UploadSnowballObjectsArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/UploadSnowballObjectsArgs$Builder$$ExternalSyntheticLambda1;-><init>(Ljava/lang/Iterable;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 67
    return-object p0
.end method

.method public stagingFilename(Ljava/lang/String;)Lio/minio/UploadSnowballObjectsArgs$Builder;
    .locals 2
    .param p1, "stagingFilename"    # Ljava/lang/String;

    .line 71
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 72
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string/jumbo v1, "staging filename must not be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 74
    :cond_1
    :goto_0
    iget-object v0, p0, Lio/minio/UploadSnowballObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/UploadSnowballObjectsArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/UploadSnowballObjectsArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 75
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 51
    check-cast p1, Lio/minio/UploadSnowballObjectsArgs;

    invoke-virtual {p0, p1}, Lio/minio/UploadSnowballObjectsArgs$Builder;->validate(Lio/minio/UploadSnowballObjectsArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 51
    check-cast p1, Lio/minio/UploadSnowballObjectsArgs;

    invoke-virtual {p0, p1}, Lio/minio/UploadSnowballObjectsArgs$Builder;->validate(Lio/minio/UploadSnowballObjectsArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 51
    check-cast p1, Lio/minio/UploadSnowballObjectsArgs;

    invoke-virtual {p0, p1}, Lio/minio/UploadSnowballObjectsArgs$Builder;->validate(Lio/minio/UploadSnowballObjectsArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/UploadSnowballObjectsArgs;)V
    .locals 3
    .param p1, "args"    # Lio/minio/UploadSnowballObjectsArgs;

    .line 59
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "snowball."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lio/minio/UploadSnowballObjectsArgs;->access$000()Ljava/util/Random;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/Random;->nextLong()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".tar"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lio/minio/UploadSnowballObjectsArgs;->objectName:Ljava/lang/String;

    .line 60
    invoke-static {p1}, Lio/minio/UploadSnowballObjectsArgs;->access$100(Lio/minio/UploadSnowballObjectsArgs;)Ljava/lang/Iterable;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/UploadSnowballObjectsArgs$Builder;->validateObjects(Ljava/lang/Iterable;)V

    .line 61
    invoke-super {p0, p1}, Lio/minio/ObjectWriteArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 62
    return-void
.end method
