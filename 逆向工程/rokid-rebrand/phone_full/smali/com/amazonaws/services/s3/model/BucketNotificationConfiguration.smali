.class public Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
.super Ljava/lang/Object;
.source "BucketNotificationConfiguration.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;
    }
.end annotation


# instance fields
.field private configurations:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/s3/model/NotificationConfiguration;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 80
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    .line 81
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    .line 82
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "notificationConfiguration"    # Lcom/amazonaws/services/s3/model/NotificationConfiguration;

    .line 95
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    .line 96
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    .line 97
    invoke-virtual {p0, p1, p2}, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->addConfiguration(Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 98
    return-void
.end method

.method public constructor <init>(Ljava/util/Collection;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;",
            ">;)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 192
    .local p1, "topicConfigurations":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    .line 193
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    .line 194
    if-eqz p1, :cond_0

    .line 195
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;

    .line 196
    .local v1, "config":Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2, v1}, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->addConfiguration(Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 197
    .end local v1    # "config":Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;
    goto :goto_0

    .line 199
    :cond_0
    return-void
.end method


# virtual methods
.method public addConfiguration(Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "notificationConfiguration"    # Lcom/amazonaws/services/s3/model/NotificationConfiguration;

    .line 124
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 125
    return-object p0
.end method

.method public getConfigurationByName(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/NotificationConfiguration;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 154
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;

    return-object v0
.end method

.method public getConfigurations()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/s3/model/NotificationConfiguration;",
            ">;"
        }
    .end annotation

    .line 133
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    return-object v0
.end method

.method public getTopicConfigurations()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;",
            ">;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 271
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 272
    .local v0, "topicConfigs":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;>;"
    iget-object v1, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    .line 273
    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    .line 272
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 274
    .local v2, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    instance-of v3, v3, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;

    if-eqz v3, :cond_0

    .line 275
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 277
    .end local v2    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    :cond_0
    goto :goto_0

    .line 278
    :cond_1
    return-object v0
.end method

.method public removeConfiguration(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/NotificationConfiguration;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 172
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;

    return-object v0
.end method

.method public setConfigurations(Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/s3/model/NotificationConfiguration;",
            ">;)V"
        }
    .end annotation

    .line 144
    .local p1, "configurations":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    .line 145
    return-void
.end method

.method public setTopicConfigurations(Ljava/util/Collection;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;",
            ">;)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 240
    .local p1, "topicConfigurations":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;>;"
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 242
    if-eqz p1, :cond_0

    .line 243
    invoke-interface {p1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;

    .line 244
    .local v1, "topicConfiguration":Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2, v1}, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->addConfiguration(Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 246
    .end local v1    # "topicConfiguration":Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;
    goto :goto_0

    .line 248
    :cond_0
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 283
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->getConfigurations()Ljava/util/Map;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public withNotificationConfiguration(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/s3/model/NotificationConfiguration;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;"
        }
    .end annotation

    .line 108
    .local p1, "notificationConfiguration":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 109
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->configurations:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 110
    return-object p0
.end method

.method public varargs withTopicConfigurations([Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
    .locals 1
    .param p1, "topicConfigurations"    # [Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration$TopicConfiguration;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 221
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->setTopicConfigurations(Ljava/util/Collection;)V

    .line 222
    return-object p0
.end method
