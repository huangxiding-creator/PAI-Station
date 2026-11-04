.class abstract Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller;
.super Ljava/lang/Object;
.source "NotificationConfigurationStaxUnmarshaller.java"

# interfaces
.implements Lcom/amazonaws/transform/Unmarshaller;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/amazonaws/services/s3/model/NotificationConfiguration;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/amazonaws/transform/Unmarshaller<",
        "Ljava/util/Map$Entry<",
        "Ljava/lang/String;",
        "Lcom/amazonaws/services/s3/model/NotificationConfiguration;",
        ">;",
        "Lcom/amazonaws/transform/StaxUnmarshallerContext;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 37
    .local p0, "this":Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller;, "Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method protected abstract createConfiguration()Lcom/amazonaws/services/s3/model/NotificationConfiguration;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation
.end method

.method protected abstract handleXmlEvent(Lcom/amazonaws/services/s3/model/NotificationConfiguration;Lcom/amazonaws/transform/StaxUnmarshallerContext;I)Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/amazonaws/transform/StaxUnmarshallerContext;",
            "I)Z"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public bridge synthetic unmarshall(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 37
    .local p0, "this":Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller;, "Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller<TT;>;"
    check-cast p1, Lcom/amazonaws/transform/StaxUnmarshallerContext;

    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/util/Map$Entry;

    move-result-object p1

    return-object p1
.end method

.method public unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/util/Map$Entry;
    .locals 6
    .param p1, "context"    # Lcom/amazonaws/transform/StaxUnmarshallerContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/transform/StaxUnmarshallerContext;",
            ")",
            "Ljava/util/Map$Entry<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/s3/model/NotificationConfiguration;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 47
    .local p0, "this":Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller;, "Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller<TT;>;"
    invoke-virtual {p1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->getCurrentDepth()I

    move-result v0

    .line 48
    .local v0, "originalDepth":I
    add-int/lit8 v1, v0, 0x1

    .line 50
    .local v1, "targetDepth":I
    invoke-virtual {p1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->isStartOfDocument()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 51
    add-int/lit8 v1, v1, 0x1

    .line 54
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller;->createConfiguration()Lcom/amazonaws/services/s3/model/NotificationConfiguration;

    move-result-object v2

    .line 55
    .local v2, "topicConfig":Lcom/amazonaws/services/s3/model/NotificationConfiguration;, "TT;"
    const/4 v3, 0x0

    .line 58
    .local v3, "id":Ljava/lang/String;
    :goto_0
    invoke-virtual {p1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->nextEvent()I

    move-result v4

    .line 59
    .local v4, "xmlEvent":I
    const/4 v5, 0x1

    if-ne v4, v5, :cond_1

    .line 60
    nop

    .line 78
    .end local v4    # "xmlEvent":I
    const/4 v4, 0x0

    return-object v4

    .line 61
    .restart local v4    # "xmlEvent":I
    :cond_1
    const/4 v5, 0x2

    if-ne v4, v5, :cond_5

    .line 62
    invoke-virtual {p0, v2, p1, v1}, Lcom/amazonaws/services/s3/model/transform/NotificationConfigurationStaxUnmarshaller;->handleXmlEvent(Lcom/amazonaws/services/s3/model/NotificationConfiguration;Lcom/amazonaws/transform/StaxUnmarshallerContext;I)Z

    move-result v5

    if-eqz v5, :cond_2

    goto :goto_1

    .line 64
    :cond_2
    const-string v5, "Id"

    invoke-virtual {p1, v5, v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 65
    invoke-static {}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->getInstance()Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;

    move-result-object v5

    invoke-virtual {v5, p1}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 66
    :cond_3
    const-string v5, "Event"

    invoke-virtual {p1, v5, v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 67
    invoke-static {}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->getInstance()Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;

    move-result-object v5

    invoke-virtual {v5, p1}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->addEvent(Ljava/lang/String;)V

    goto :goto_1

    .line 68
    :cond_4
    const-string v5, "Filter"

    invoke-virtual {p1, v5, v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 69
    invoke-static {}, Lcom/amazonaws/services/s3/model/transform/FilterStaxUnmarshaller;->getInstance()Lcom/amazonaws/services/s3/model/transform/FilterStaxUnmarshaller;

    move-result-object v5

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/s3/model/transform/FilterStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Lcom/amazonaws/services/s3/model/Filter;

    move-result-object v5

    invoke-virtual {v2, v5}, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->setFilter(Lcom/amazonaws/services/s3/model/Filter;)V

    goto :goto_1

    .line 71
    :cond_5
    const/4 v5, 0x3

    if-ne v4, v5, :cond_6

    .line 72
    invoke-virtual {p1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->getCurrentDepth()I

    move-result v5

    if-ge v5, v0, :cond_6

    .line 73
    new-instance v5, Ljava/util/AbstractMap$SimpleEntry;

    invoke-direct {v5, v3, v2}, Ljava/util/AbstractMap$SimpleEntry;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v5

    .line 76
    .end local v4    # "xmlEvent":I
    :cond_6
    :goto_1
    goto :goto_0
.end method
