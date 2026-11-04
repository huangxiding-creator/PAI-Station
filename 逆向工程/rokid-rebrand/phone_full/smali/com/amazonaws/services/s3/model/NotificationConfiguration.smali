.class public abstract Lcom/amazonaws/services/s3/model/NotificationConfiguration;
.super Ljava/lang/Object;
.source "NotificationConfiguration.java"


# instance fields
.field private events:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private filter:Lcom/amazonaws/services/s3/model/Filter;

.field private objectPrefixes:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field


# direct methods
.method protected constructor <init>()V
    .locals 1

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    .line 38
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->objectPrefixes:Ljava/util/List;

    .line 47
    return-void
.end method

.method protected constructor <init>(Ljava/util/EnumSet;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/EnumSet<",
            "Lcom/amazonaws/services/s3/model/S3Event;",
            ">;)V"
        }
    .end annotation

    .line 55
    .local p1, "events":Ljava/util/EnumSet;, "Ljava/util/EnumSet<Lcom/amazonaws/services/s3/model/S3Event;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    .line 38
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->objectPrefixes:Ljava/util/List;

    .line 56
    if-eqz p1, :cond_0

    .line 57
    invoke-virtual {p1}, Ljava/util/EnumSet;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/services/s3/model/S3Event;

    .line 58
    .local v1, "s3Event":Lcom/amazonaws/services/s3/model/S3Event;
    iget-object v2, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/S3Event;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 59
    .end local v1    # "s3Event":Lcom/amazonaws/services/s3/model/S3Event;
    goto :goto_0

    .line 61
    :cond_0
    return-void
.end method

.method protected varargs constructor <init>([Ljava/lang/String;)V
    .locals 4
    .param p1, "events"    # [Ljava/lang/String;

    .line 69
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    .line 38
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->objectPrefixes:Ljava/util/List;

    .line 70
    if-eqz p1, :cond_0

    .line 71
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    aget-object v2, p1, v1

    .line 72
    .local v2, "event":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    invoke-interface {v3, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 71
    .end local v2    # "event":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 75
    :cond_0
    return-void
.end method


# virtual methods
.method public addEvent(Lcom/amazonaws/services/s3/model/S3Event;)V
    .locals 2
    .param p1, "event"    # Lcom/amazonaws/services/s3/model/S3Event;

    .line 154
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/S3Event;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 155
    return-void
.end method

.method public addEvent(Ljava/lang/String;)V
    .locals 1
    .param p1, "event"    # Ljava/lang/String;

    .line 144
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 145
    return-void
.end method

.method public addObjectPrefix(Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 163
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->objectPrefixes:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 164
    return-void
.end method

.method public getEvents()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 81
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    return-object v0
.end method

.method public getFilter()Lcom/amazonaws/services/s3/model/Filter;
    .locals 1

    .line 172
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->filter:Lcom/amazonaws/services/s3/model/Filter;

    return-object v0
.end method

.method public getObjectPrefixes()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 100
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->objectPrefixes:Ljava/util/List;

    return-object v0
.end method

.method public setEvents(Ljava/util/Set;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 91
    .local p1, "events":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    .line 92
    return-void
.end method

.method public setFilter(Lcom/amazonaws/services/s3/model/Filter;)V
    .locals 0
    .param p1, "filter"    # Lcom/amazonaws/services/s3/model/Filter;

    .line 182
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->filter:Lcom/amazonaws/services/s3/model/Filter;

    .line 183
    return-void
.end method

.method public setObjectPrefixes(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 109
    .local p1, "objectPrefixes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->objectPrefixes:Ljava/util/List;

    .line 110
    return-void
.end method

.method public withEvents(Ljava/util/Set;)Lcom/amazonaws/services/s3/model/NotificationConfiguration;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/NotificationConfiguration;"
        }
    .end annotation

    .line 120
    .local p1, "events":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->clear()V

    .line 121
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->events:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    .line 122
    return-object p0
.end method

.method public withFilter(Lcom/amazonaws/services/s3/model/Filter;)Lcom/amazonaws/services/s3/model/NotificationConfiguration;
    .locals 0
    .param p1, "filter"    # Lcom/amazonaws/services/s3/model/Filter;

    .line 194
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->setFilter(Lcom/amazonaws/services/s3/model/Filter;)V

    .line 195
    return-object p0
.end method

.method public varargs withObjectPrefixes([Ljava/lang/String;)Lcom/amazonaws/services/s3/model/NotificationConfiguration;
    .locals 2
    .param p1, "objectPrefixes"    # [Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 131
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->objectPrefixes:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 132
    if-eqz p1, :cond_0

    array-length v0, p1

    if-lez v0, :cond_0

    .line 133
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->objectPrefixes:Ljava/util/List;

    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 134
    :cond_0
    return-object p0
.end method
