.class public Lio/minio/messages/GlacierJobParameters;
.super Ljava/lang/Object;
.source "GlacierJobParameters.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "GlacierJobParameters"
.end annotation


# instance fields
.field private tier:Lio/minio/messages/Tier;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Tier"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/Tier;)V
    .locals 1
    .param p1, "tier"    # Lio/minio/messages/Tier;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    const-string v0, "Tier must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Tier;

    iput-object v0, p0, Lio/minio/messages/GlacierJobParameters;->tier:Lio/minio/messages/Tier;

    .line 33
    return-void
.end method
