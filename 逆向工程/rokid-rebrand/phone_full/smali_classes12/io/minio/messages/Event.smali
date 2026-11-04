.class public Lio/minio/messages/Event;
.super Ljava/lang/Object;
.source "Event.java"


# instance fields
.field private awsRegion:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private eventName:Lio/minio/messages/EventType;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private eventSource:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private eventTime:Lio/minio/messages/ResponseDate;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private eventVersion:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private requestParameters:Ljava/util/Map;
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

.field private responseElements:Ljava/util/Map;
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

.field private s3:Lio/minio/messages/EventMetadata;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private source:Lio/minio/messages/Source;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field

.field private userIdentity:Lio/minio/messages/Identity;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bucketArn()Ljava/lang/String;
    .locals 1

    .line 90
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    if-nez v0, :cond_0

    .line 91
    const/4 v0, 0x0

    return-object v0

    .line 94
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    invoke-virtual {v0}, Lio/minio/messages/EventMetadata;->bucketArn()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public bucketName()Ljava/lang/String;
    .locals 1

    .line 74
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    if-nez v0, :cond_0

    .line 75
    const/4 v0, 0x0

    return-object v0

    .line 78
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    invoke-virtual {v0}, Lio/minio/messages/EventMetadata;->bucketName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public bucketOwner()Ljava/lang/String;
    .locals 1

    .line 82
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    if-nez v0, :cond_0

    .line 83
    const/4 v0, 0x0

    return-object v0

    .line 86
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    invoke-virtual {v0}, Lio/minio/messages/EventMetadata;->bucketOwner()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public etag()Ljava/lang/String;
    .locals 1

    .line 114
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    if-nez v0, :cond_0

    .line 115
    const/4 v0, 0x0

    return-object v0

    .line 118
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    invoke-virtual {v0}, Lio/minio/messages/EventMetadata;->etag()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public eventTime()Ljava/time/ZonedDateTime;
    .locals 1

    .line 48
    iget-object v0, p0, Lio/minio/messages/Event;->eventTime:Lio/minio/messages/ResponseDate;

    invoke-virtual {v0}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v0

    return-object v0
.end method

.method public eventType()Lio/minio/messages/EventType;
    .locals 1

    .line 52
    iget-object v0, p0, Lio/minio/messages/Event;->eventName:Lio/minio/messages/EventType;

    return-object v0
.end method

.method public host()Ljava/lang/String;
    .locals 1

    .line 146
    iget-object v0, p0, Lio/minio/messages/Event;->source:Lio/minio/messages/Source;

    if-nez v0, :cond_0

    .line 147
    const/4 v0, 0x0

    return-object v0

    .line 150
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->source:Lio/minio/messages/Source;

    invoke-virtual {v0}, Lio/minio/messages/Source;->host()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public objectName()Ljava/lang/String;
    .locals 1

    .line 98
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    if-nez v0, :cond_0

    .line 99
    const/4 v0, 0x0

    return-object v0

    .line 102
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    invoke-virtual {v0}, Lio/minio/messages/EventMetadata;->objectName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public objectSize()J
    .locals 2

    .line 106
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    if-nez v0, :cond_0

    .line 107
    const-wide/16 v0, -0x1

    return-wide v0

    .line 110
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    invoke-virtual {v0}, Lio/minio/messages/EventMetadata;->objectSize()J

    move-result-wide v0

    return-wide v0
.end method

.method public objectVersionId()Ljava/lang/String;
    .locals 1

    .line 122
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    if-nez v0, :cond_0

    .line 123
    const/4 v0, 0x0

    return-object v0

    .line 126
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    invoke-virtual {v0}, Lio/minio/messages/EventMetadata;->objectVersionId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public port()Ljava/lang/String;
    .locals 1

    .line 154
    iget-object v0, p0, Lio/minio/messages/Event;->source:Lio/minio/messages/Source;

    if-nez v0, :cond_0

    .line 155
    const/4 v0, 0x0

    return-object v0

    .line 158
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->source:Lio/minio/messages/Source;

    invoke-virtual {v0}, Lio/minio/messages/Source;->port()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public region()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/messages/Event;->awsRegion:Ljava/lang/String;

    return-object v0
.end method

.method public requestParameters()Ljava/util/Map;
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

    .line 65
    iget-object v0, p0, Lio/minio/messages/Event;->requestParameters:Ljava/util/Map;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->requestParameters:Ljava/util/Map;

    .line 64
    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public responseElements()Ljava/util/Map;
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

    .line 70
    iget-object v0, p0, Lio/minio/messages/Event;->responseElements:Ljava/util/Map;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->responseElements:Ljava/util/Map;

    .line 69
    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public sequencer()Ljava/lang/String;
    .locals 1

    .line 130
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    if-nez v0, :cond_0

    .line 131
    const/4 v0, 0x0

    return-object v0

    .line 134
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    invoke-virtual {v0}, Lio/minio/messages/EventMetadata;->sequencer()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public userAgent()Ljava/lang/String;
    .locals 1

    .line 162
    iget-object v0, p0, Lio/minio/messages/Event;->source:Lio/minio/messages/Source;

    if-nez v0, :cond_0

    .line 163
    const/4 v0, 0x0

    return-object v0

    .line 166
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->source:Lio/minio/messages/Source;

    invoke-virtual {v0}, Lio/minio/messages/Source;->userAgent()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public userId()Ljava/lang/String;
    .locals 1

    .line 56
    iget-object v0, p0, Lio/minio/messages/Event;->userIdentity:Lio/minio/messages/Identity;

    if-nez v0, :cond_0

    .line 57
    const/4 v0, 0x0

    return-object v0

    .line 60
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->userIdentity:Lio/minio/messages/Identity;

    invoke-virtual {v0}, Lio/minio/messages/Identity;->principalId()Ljava/lang/String;

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

    .line 138
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    if-nez v0, :cond_0

    .line 139
    const/4 v0, 0x0

    return-object v0

    .line 142
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Event;->s3:Lio/minio/messages/EventMetadata;

    invoke-virtual {v0}, Lio/minio/messages/EventMetadata;->userMetadata()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method
