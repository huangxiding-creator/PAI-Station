.class public abstract Lio/minio/ObjectArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "ObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/ObjectArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<B:",
        "Lio/minio/ObjectArgs$Builder<",
        "TB;TA;>;A:",
        "Lio/minio/ObjectArgs;",
        ">",
        "Lio/minio/BucketArgs$Builder<",
        "TB;TA;>;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 43
    .local p0, "this":Lio/minio/ObjectArgs$Builder;, "Lio/minio/ObjectArgs$Builder<TB;TA;>;"
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$object$0(Ljava/lang/String;Lio/minio/ObjectArgs;)V
    .locals 0
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ObjectArgs;

    .line 63
    iput-object p0, p1, Lio/minio/ObjectArgs;->objectName:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public object(Ljava/lang/String;)Lio/minio/ObjectArgs$Builder;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")TB;"
        }
    .end annotation

    .line 62
    .local p0, "this":Lio/minio/ObjectArgs$Builder;, "Lio/minio/ObjectArgs$Builder<TB;TA;>;"
    invoke-virtual {p0, p1}, Lio/minio/ObjectArgs$Builder;->validateObjectName(Ljava/lang/String;)V

    .line 63
    iget-object v0, p0, Lio/minio/ObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/ObjectArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 64
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 43
    .local p0, "this":Lio/minio/ObjectArgs$Builder;, "Lio/minio/ObjectArgs$Builder<TB;TA;>;"
    check-cast p1, Lio/minio/ObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/ObjectArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 43
    .local p0, "this":Lio/minio/ObjectArgs$Builder;, "Lio/minio/ObjectArgs$Builder<TB;TA;>;"
    check-cast p1, Lio/minio/ObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/ObjectArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/ObjectArgs;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TA;)V"
        }
    .end annotation

    .line 56
    .local p0, "this":Lio/minio/ObjectArgs$Builder;, "Lio/minio/ObjectArgs$Builder<TB;TA;>;"
    .local p1, "args":Lio/minio/ObjectArgs;, "TA;"
    invoke-super {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    .line 57
    iget-object v0, p1, Lio/minio/ObjectArgs;->objectName:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lio/minio/ObjectArgs$Builder;->validateObjectName(Ljava/lang/String;)V

    .line 58
    return-void
.end method

.method protected validateObjectName(Ljava/lang/String;)V
    .locals 5
    .param p1, "name"    # Ljava/lang/String;

    .line 46
    .local p0, "this":Lio/minio/ObjectArgs$Builder;, "Lio/minio/ObjectArgs$Builder<TB;TA;>;"
    const-string v0, "object name"

    invoke-virtual {p0, p1, v0}, Lio/minio/ObjectArgs$Builder;->validateNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 47
    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 48
    .local v3, "token":Ljava/lang/String;
    const-string v4, "."

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    const-string v4, ".."

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 47
    .end local v3    # "token":Ljava/lang/String;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 49
    .restart local v3    # "token":Ljava/lang/String;
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "object name with \'.\' or \'..\' path segment is not supported"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 53
    .end local v3    # "token":Ljava/lang/String;
    :cond_1
    return-void
.end method
