.class public abstract Lio/minio/ObjectReadArgs$Builder;
.super Lio/minio/ObjectVersionArgs$Builder;
.source "ObjectReadArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/ObjectReadArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<B:",
        "Lio/minio/ObjectReadArgs$Builder<",
        "TB;TA;>;A:",
        "Lio/minio/ObjectReadArgs;",
        ">",
        "Lio/minio/ObjectVersionArgs$Builder<",
        "TB;TA;>;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 35
    .local p0, "this":Lio/minio/ObjectReadArgs$Builder;, "Lio/minio/ObjectReadArgs$Builder<TB;TA;>;"
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$ssec$0(Lio/minio/ServerSideEncryptionCustomerKey;Lio/minio/ObjectReadArgs;)V
    .locals 0
    .param p0, "ssec"    # Lio/minio/ServerSideEncryptionCustomerKey;
    .param p1, "args"    # Lio/minio/ObjectReadArgs;

    .line 39
    iput-object p0, p1, Lio/minio/ObjectReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    return-void
.end method


# virtual methods
.method public ssec(Lio/minio/ServerSideEncryptionCustomerKey;)Lio/minio/ObjectReadArgs$Builder;
    .locals 2
    .param p1, "ssec"    # Lio/minio/ServerSideEncryptionCustomerKey;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/minio/ServerSideEncryptionCustomerKey;",
            ")TB;"
        }
    .end annotation

    .line 39
    .local p0, "this":Lio/minio/ObjectReadArgs$Builder;, "Lio/minio/ObjectReadArgs$Builder<TB;TA;>;"
    iget-object v0, p0, Lio/minio/ObjectReadArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectReadArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/ObjectReadArgs$Builder$$ExternalSyntheticLambda0;-><init>(Lio/minio/ServerSideEncryptionCustomerKey;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 40
    return-object p0
.end method
