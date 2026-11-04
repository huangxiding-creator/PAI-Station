.class public Lio/minio/messages/ObjectMetadata;
.super Ljava/lang/Object;
.source "ObjectMetadata.java"


# instance fields
.field private eTag:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private key:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private sequencer:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private size:J
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private userMetadata:Ljava/util/Map;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private versionId:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public etag()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/messages/ObjectMetadata;->eTag:Ljava/lang/String;

    return-object v0
.end method

.method public key()Ljava/lang/String;
    .locals 1

    .line 36
    iget-object v0, p0, Lio/minio/messages/ObjectMetadata;->key:Ljava/lang/String;

    return-object v0
.end method

.method public sequencer()Ljava/lang/String;
    .locals 1

    .line 52
    iget-object v0, p0, Lio/minio/messages/ObjectMetadata;->sequencer:Ljava/lang/String;

    return-object v0
.end method

.method public size()J
    .locals 2

    .line 40
    iget-wide v0, p0, Lio/minio/messages/ObjectMetadata;->size:J

    return-wide v0
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

    .line 56
    iget-object v0, p0, Lio/minio/messages/ObjectMetadata;->userMetadata:Ljava/util/Map;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/ObjectMetadata;->userMetadata:Ljava/util/Map;

    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public versionId()Ljava/lang/String;
    .locals 1

    .line 48
    iget-object v0, p0, Lio/minio/messages/ObjectMetadata;->versionId:Ljava/lang/String;

    return-object v0
.end method
