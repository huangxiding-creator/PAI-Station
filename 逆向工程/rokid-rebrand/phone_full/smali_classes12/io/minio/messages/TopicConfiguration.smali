.class public Lio/minio/messages/TopicConfiguration;
.super Lio/minio/messages/NotificationCommonConfiguration;
.source "TopicConfiguration.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "TopicConfiguration"
    strict = false
.end annotation


# instance fields
.field private topic:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Topic"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Lio/minio/messages/NotificationCommonConfiguration;-><init>()V

    .line 30
    return-void
.end method


# virtual methods
.method public setTopic(Ljava/lang/String;)V
    .locals 0
    .param p1, "topic"    # Ljava/lang/String;

    .line 39
    iput-object p1, p0, Lio/minio/messages/TopicConfiguration;->topic:Ljava/lang/String;

    .line 40
    return-void
.end method

.method public topic()Ljava/lang/String;
    .locals 1

    .line 34
    iget-object v0, p0, Lio/minio/messages/TopicConfiguration;->topic:Ljava/lang/String;

    return-object v0
.end method
