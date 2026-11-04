.class public Lio/minio/messages/NotificationConfiguration;
.super Ljava/lang/Object;
.source "NotificationConfiguration.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "NotificationConfiguration"
    strict = false
.end annotation


# instance fields
.field private cloudFunctionConfigurationList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/CloudFunctionConfiguration;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "CloudFunctionConfiguration"
        required = false
    .end annotation
.end field

.field private queueConfigurationList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/QueueConfiguration;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "QueueConfiguration"
        required = false
    .end annotation
.end field

.field private topicConfigurationList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/TopicConfiguration;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "TopicConfiguration"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public cloudFunctionConfigurationList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/CloudFunctionConfiguration;",
            ">;"
        }
    .end annotation

    .line 51
    iget-object v0, p0, Lio/minio/messages/NotificationConfiguration;->cloudFunctionConfigurationList:Ljava/util/List;

    if-nez v0, :cond_0

    .line 52
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    goto :goto_0

    .line 53
    :cond_0
    iget-object v0, p0, Lio/minio/messages/NotificationConfiguration;->cloudFunctionConfigurationList:Ljava/util/List;

    .line 50
    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public queueConfigurationList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/QueueConfiguration;",
            ">;"
        }
    .end annotation

    .line 66
    iget-object v0, p0, Lio/minio/messages/NotificationConfiguration;->queueConfigurationList:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/NotificationConfiguration;->queueConfigurationList:Ljava/util/List;

    .line 65
    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public setCloudFunctionConfigurationList(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lio/minio/messages/CloudFunctionConfiguration;",
            ">;)V"
        }
    .end annotation

    .line 59
    .local p1, "cloudFunctionConfigurationList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/CloudFunctionConfiguration;>;"
    nop

    .line 60
    invoke-static {p1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lio/minio/messages/NotificationConfiguration;->cloudFunctionConfigurationList:Ljava/util/List;

    .line 61
    return-void
.end method

.method public setQueueConfigurationList(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lio/minio/messages/QueueConfiguration;",
            ">;)V"
        }
    .end annotation

    .line 71
    .local p1, "queueConfigurationList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/QueueConfiguration;>;"
    invoke-static {p1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lio/minio/messages/NotificationConfiguration;->queueConfigurationList:Ljava/util/List;

    .line 72
    return-void
.end method

.method public setTopicConfigurationList(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lio/minio/messages/TopicConfiguration;",
            ">;)V"
        }
    .end annotation

    .line 82
    .local p1, "topicConfigurationList":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/TopicConfiguration;>;"
    invoke-static {p1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lio/minio/messages/NotificationConfiguration;->topicConfigurationList:Ljava/util/List;

    .line 83
    return-void
.end method

.method public topicConfigurationList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/TopicConfiguration;",
            ">;"
        }
    .end annotation

    .line 77
    iget-object v0, p0, Lio/minio/messages/NotificationConfiguration;->topicConfigurationList:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/NotificationConfiguration;->topicConfigurationList:Ljava/util/List;

    .line 76
    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method
