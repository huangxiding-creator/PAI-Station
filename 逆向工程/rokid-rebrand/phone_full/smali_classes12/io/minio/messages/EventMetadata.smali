.class public Lio/minio/messages/EventMetadata;
.super Ljava/lang/Object;
.source "EventMetadata.java"


# instance fields
.field private bucket:Lio/minio/messages/BucketMetadata;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private configurationId:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private object:Lio/minio/messages/ObjectMetadata;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private s3SchemaVersion:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bucketArn()Ljava/lang/String;
    .locals 1

    .line 53
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->bucket:Lio/minio/messages/BucketMetadata;

    if-nez v0, :cond_0

    .line 54
    const/4 v0, 0x0

    return-object v0

    .line 57
    :cond_0
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->bucket:Lio/minio/messages/BucketMetadata;

    invoke-virtual {v0}, Lio/minio/messages/BucketMetadata;->arn()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public bucketName()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->bucket:Lio/minio/messages/BucketMetadata;

    if-nez v0, :cond_0

    .line 38
    const/4 v0, 0x0

    return-object v0

    .line 41
    :cond_0
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->bucket:Lio/minio/messages/BucketMetadata;

    invoke-virtual {v0}, Lio/minio/messages/BucketMetadata;->name()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public bucketOwner()Ljava/lang/String;
    .locals 1

    .line 45
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->bucket:Lio/minio/messages/BucketMetadata;

    if-nez v0, :cond_0

    .line 46
    const/4 v0, 0x0

    return-object v0

    .line 49
    :cond_0
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->bucket:Lio/minio/messages/BucketMetadata;

    invoke-virtual {v0}, Lio/minio/messages/BucketMetadata;->owner()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public etag()Ljava/lang/String;
    .locals 1

    .line 77
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    if-nez v0, :cond_0

    .line 78
    const/4 v0, 0x0

    return-object v0

    .line 81
    :cond_0
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    invoke-virtual {v0}, Lio/minio/messages/ObjectMetadata;->etag()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public objectName()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    if-nez v0, :cond_0

    .line 62
    const/4 v0, 0x0

    return-object v0

    .line 65
    :cond_0
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    invoke-virtual {v0}, Lio/minio/messages/ObjectMetadata;->key()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public objectSize()J
    .locals 2

    .line 69
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    if-nez v0, :cond_0

    .line 70
    const-wide/16 v0, -0x1

    return-wide v0

    .line 73
    :cond_0
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    invoke-virtual {v0}, Lio/minio/messages/ObjectMetadata;->size()J

    move-result-wide v0

    return-wide v0
.end method

.method public objectVersionId()Ljava/lang/String;
    .locals 1

    .line 85
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    if-nez v0, :cond_0

    .line 86
    const/4 v0, 0x0

    return-object v0

    .line 89
    :cond_0
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    invoke-virtual {v0}, Lio/minio/messages/ObjectMetadata;->versionId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public sequencer()Ljava/lang/String;
    .locals 1

    .line 93
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    if-nez v0, :cond_0

    .line 94
    const/4 v0, 0x0

    return-object v0

    .line 97
    :cond_0
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    invoke-virtual {v0}, Lio/minio/messages/ObjectMetadata;->sequencer()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public userMetadata()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 101
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    if-nez v0, :cond_0

    .line 102
    const/4 v0, 0x0

    return-object v0

    .line 105
    :cond_0
    iget-object v0, p0, Lio/minio/messages/EventMetadata;->object:Lio/minio/messages/ObjectMetadata;

    invoke-virtual {v0}, Lio/minio/messages/ObjectMetadata;->userMetadata()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method
