.class public abstract Lio/minio/ObjectVersionArgs$Builder;
.super Lio/minio/ObjectArgs$Builder;
.source "ObjectVersionArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/ObjectVersionArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<B:",
        "Lio/minio/ObjectVersionArgs$Builder<",
        "TB;TA;>;A:",
        "Lio/minio/ObjectVersionArgs;",
        ">",
        "Lio/minio/ObjectArgs$Builder<",
        "TB;TA;>;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 30
    .local p0, "this":Lio/minio/ObjectVersionArgs$Builder;, "Lio/minio/ObjectVersionArgs$Builder<TB;TA;>;"
    invoke-direct {p0}, Lio/minio/ObjectArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$versionId$0(Ljava/lang/String;Lio/minio/ObjectVersionArgs;)V
    .locals 0
    .param p0, "versionId"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ObjectVersionArgs;

    .line 34
    iput-object p0, p1, Lio/minio/ObjectVersionArgs;->versionId:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public versionId(Ljava/lang/String;)Lio/minio/ObjectVersionArgs$Builder;
    .locals 2
    .param p1, "versionId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")TB;"
        }
    .end annotation

    .line 34
    .local p0, "this":Lio/minio/ObjectVersionArgs$Builder;, "Lio/minio/ObjectVersionArgs$Builder<TB;TA;>;"
    iget-object v0, p0, Lio/minio/ObjectVersionArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectVersionArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/ObjectVersionArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 35
    return-object p0
.end method
