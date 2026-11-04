.class public Lio/minio/messages/NoncurrentVersionTransition;
.super Lio/minio/messages/NoncurrentVersionExpiration;
.source "NoncurrentVersionTransition.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "NoncurrentVersionTransition"
.end annotation


# instance fields
.field private storageClass:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "StorageClass"
    .end annotation
.end field


# direct methods
.method public constructor <init>(ILjava/lang/String;)V
    .locals 2
    .param p1, "noncurrentDays"    # I
        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "NoncurrentDays"
            required = false
        .end annotation
    .end param
    .param p2, "storageClass"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "StorageClass"
            required = false
        .end annotation
    .end param

    .line 33
    invoke-direct {p0, p1}, Lio/minio/messages/NoncurrentVersionExpiration;-><init>(I)V

    .line 34
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 37
    iput-object p2, p0, Lio/minio/messages/NoncurrentVersionTransition;->storageClass:Ljava/lang/String;

    .line 38
    return-void

    .line 35
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "StorageClass must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public storageClass()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lio/minio/messages/NoncurrentVersionTransition;->storageClass:Ljava/lang/String;

    return-object v0
.end method
