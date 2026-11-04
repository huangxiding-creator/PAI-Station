.class public final Lio/minio/ComposeObjectArgs$Builder;
.super Lio/minio/ObjectWriteArgs$Builder;
.source "ComposeObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/ComposeObjectArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectWriteArgs$Builder<",
        "Lio/minio/ComposeObjectArgs$Builder;",
        "Lio/minio/ComposeObjectArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 66
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$sources$0(Ljava/util/List;Lio/minio/ComposeObjectArgs;)V
    .locals 0
    .param p0, "sources"    # Ljava/util/List;
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;

    .line 81
    iput-object p0, p1, Lio/minio/ComposeObjectArgs;->sources:Ljava/util/List;

    return-void
.end method

.method private validateSources(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lio/minio/ComposeSource;",
            ">;)V"
        }
    .end annotation

    .line 68
    .local p1, "sources":Ljava/util/List;, "Ljava/util/List<Lio/minio/ComposeSource;>;"
    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 71
    return-void

    .line 69
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "compose sources cannot be empty"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public sources(Ljava/util/List;)Lio/minio/ComposeObjectArgs$Builder;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lio/minio/ComposeSource;",
            ">;)",
            "Lio/minio/ComposeObjectArgs$Builder;"
        }
    .end annotation

    .line 80
    .local p1, "sources":Ljava/util/List;, "Ljava/util/List<Lio/minio/ComposeSource;>;"
    invoke-direct {p0, p1}, Lio/minio/ComposeObjectArgs$Builder;->validateSources(Ljava/util/List;)V

    .line 81
    iget-object v0, p0, Lio/minio/ComposeObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ComposeObjectArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/ComposeObjectArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/util/List;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 82
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 66
    check-cast p1, Lio/minio/ComposeObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/ComposeObjectArgs$Builder;->validate(Lio/minio/ComposeObjectArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 66
    check-cast p1, Lio/minio/ComposeObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/ComposeObjectArgs$Builder;->validate(Lio/minio/ComposeObjectArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/ComposeObjectArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/ComposeObjectArgs;

    .line 75
    invoke-super {p0, p1}, Lio/minio/ObjectWriteArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 76
    iget-object v0, p1, Lio/minio/ComposeObjectArgs;->sources:Ljava/util/List;

    invoke-direct {p0, v0}, Lio/minio/ComposeObjectArgs$Builder;->validateSources(Ljava/util/List;)V

    .line 77
    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 66
    check-cast p1, Lio/minio/ComposeObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/ComposeObjectArgs$Builder;->validate(Lio/minio/ComposeObjectArgs;)V

    return-void
.end method
