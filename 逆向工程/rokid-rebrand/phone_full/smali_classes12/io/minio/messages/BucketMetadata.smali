.class public Lio/minio/messages/BucketMetadata;
.super Ljava/lang/Object;
.source "BucketMetadata.java"


# instance fields
.field private arn:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private name:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private ownerIdentity:Lio/minio/messages/Identity;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public arn()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/messages/BucketMetadata;->arn:Ljava/lang/String;

    return-object v0
.end method

.method public name()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lio/minio/messages/BucketMetadata;->name:Ljava/lang/String;

    return-object v0
.end method

.method public owner()Ljava/lang/String;
    .locals 1

    .line 36
    iget-object v0, p0, Lio/minio/messages/BucketMetadata;->ownerIdentity:Lio/minio/messages/Identity;

    if-nez v0, :cond_0

    .line 37
    const/4 v0, 0x0

    return-object v0

    .line 40
    :cond_0
    iget-object v0, p0, Lio/minio/messages/BucketMetadata;->ownerIdentity:Lio/minio/messages/Identity;

    invoke-virtual {v0}, Lio/minio/messages/Identity;->principalId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
