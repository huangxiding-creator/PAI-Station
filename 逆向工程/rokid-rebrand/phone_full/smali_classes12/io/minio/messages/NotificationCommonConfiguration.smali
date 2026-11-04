.class public abstract Lio/minio/messages/NotificationCommonConfiguration;
.super Ljava/lang/Object;
.source "NotificationCommonConfiguration.java"


# instance fields
.field private events:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/EventType;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "Event"
    .end annotation
.end field

.field private filter:Lio/minio/messages/Filter;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Filter"
        required = false
    .end annotation
.end field

.field private id:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Id"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public events()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/EventType;",
            ">;"
        }
    .end annotation

    .line 54
    iget-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->events:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->events:Ljava/util/List;

    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public filterRuleList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/FilterRule;",
            ">;"
        }
    .end annotation

    .line 83
    iget-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->filter:Lio/minio/messages/Filter;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->filter:Lio/minio/messages/Filter;

    invoke-virtual {v0}, Lio/minio/messages/Filter;->filterRuleList()Ljava/util/List;

    move-result-object v0

    .line 82
    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public id()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->id:Ljava/lang/String;

    return-object v0
.end method

.method public setEvents(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lio/minio/messages/EventType;",
            ">;)V"
        }
    .end annotation

    .line 59
    .local p1, "events":Ljava/util/List;, "Ljava/util/List<Lio/minio/messages/EventType;>;"
    invoke-static {p1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->events:Ljava/util/List;

    .line 60
    return-void
.end method

.method public setId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 49
    iput-object p1, p0, Lio/minio/messages/NotificationCommonConfiguration;->id:Ljava/lang/String;

    .line 50
    return-void
.end method

.method public setPrefixRule(Ljava/lang/String;)V
    .locals 1
    .param p1, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 64
    iget-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->filter:Lio/minio/messages/Filter;

    if-nez v0, :cond_0

    .line 65
    new-instance v0, Lio/minio/messages/Filter;

    invoke-direct {v0}, Lio/minio/messages/Filter;-><init>()V

    iput-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->filter:Lio/minio/messages/Filter;

    .line 68
    :cond_0
    iget-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->filter:Lio/minio/messages/Filter;

    invoke-virtual {v0, p1}, Lio/minio/messages/Filter;->setPrefixRule(Ljava/lang/String;)V

    .line 69
    return-void
.end method

.method public setSuffixRule(Ljava/lang/String;)V
    .locals 1
    .param p1, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 73
    iget-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->filter:Lio/minio/messages/Filter;

    if-nez v0, :cond_0

    .line 74
    new-instance v0, Lio/minio/messages/Filter;

    invoke-direct {v0}, Lio/minio/messages/Filter;-><init>()V

    iput-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->filter:Lio/minio/messages/Filter;

    .line 77
    :cond_0
    iget-object v0, p0, Lio/minio/messages/NotificationCommonConfiguration;->filter:Lio/minio/messages/Filter;

    invoke-virtual {v0, p1}, Lio/minio/messages/Filter;->setSuffixRule(Ljava/lang/String;)V

    .line 78
    return-void
.end method
