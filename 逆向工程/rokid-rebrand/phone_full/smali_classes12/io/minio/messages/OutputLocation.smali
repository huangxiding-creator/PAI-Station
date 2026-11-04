.class public Lio/minio/messages/OutputLocation;
.super Ljava/lang/Object;
.source "OutputLocation.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "OutputLocation"
.end annotation


# instance fields
.field private s3OutputLocation:Lio/minio/messages/S3OutputLocation;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "S3"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/S3OutputLocation;)V
    .locals 1
    .param p1, "s3OutputLocation"    # Lio/minio/messages/S3OutputLocation;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    nop

    .line 33
    const-string v0, "S3OutputLocation must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/S3OutputLocation;

    iput-object v0, p0, Lio/minio/messages/OutputLocation;->s3OutputLocation:Lio/minio/messages/S3OutputLocation;

    .line 34
    return-void
.end method
