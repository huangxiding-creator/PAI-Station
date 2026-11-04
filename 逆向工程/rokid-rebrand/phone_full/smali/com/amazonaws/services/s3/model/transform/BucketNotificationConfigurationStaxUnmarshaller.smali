.class public Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;
.super Ljava/lang/Object;
.source "BucketNotificationConfigurationStaxUnmarshaller.java"

# interfaces
.implements Lcom/amazonaws/transform/Unmarshaller;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/amazonaws/transform/Unmarshaller<",
        "Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;",
        "Ljava/io/InputStream;",
        ">;"
    }
.end annotation


# static fields
.field private static instance:Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;

.field private static final xmlPullParserFactory:Lorg/xmlpull/v1/XmlPullParserFactory;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 33
    new-instance v0, Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;

    invoke-direct {v0}, Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;-><init>()V

    sput-object v0, Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;->instance:Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;

    .line 42
    :try_start_0
    invoke-static {}, Lorg/xmlpull/v1/XmlPullParserFactory;->newInstance()Lorg/xmlpull/v1/XmlPullParserFactory;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;->xmlPullParserFactory:Lorg/xmlpull/v1/XmlPullParserFactory;
    :try_end_0
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_0 .. :try_end_0} :catch_0

    .line 45
    nop

    .line 46
    return-void

    .line 43
    :catch_0
    move-exception v0

    .line 44
    .local v0, "xppe":Lorg/xmlpull/v1/XmlPullParserException;
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    const-string v2, "Couldn\'t initialize XmlPullParserFactory"

    invoke-direct {v1, v2, v0}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method private constructor <init>()V
    .locals 0

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    return-void
.end method

.method public static getInstance()Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;
    .locals 1

    .line 36
    sget-object v0, Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;->instance:Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;

    return-object v0
.end method


# virtual methods
.method public unmarshall(Ljava/io/InputStream;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
    .locals 9
    .param p1, "inputStream"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 54
    sget-object v0, Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;->xmlPullParserFactory:Lorg/xmlpull/v1/XmlPullParserFactory;

    invoke-virtual {v0}, Lorg/xmlpull/v1/XmlPullParserFactory;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v0

    .line 55
    .local v0, "xpp":Lorg/xmlpull/v1/XmlPullParser;
    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/InputStream;Ljava/lang/String;)V

    .line 57
    new-instance v2, Lcom/amazonaws/transform/StaxUnmarshallerContext;

    invoke-direct {v2, v0, v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;-><init>(Lorg/xmlpull/v1/XmlPullParser;Ljava/util/Map;)V

    move-object v1, v2

    .line 60
    .local v1, "context":Lcom/amazonaws/transform/StaxUnmarshallerContext;
    invoke-virtual {v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->getCurrentDepth()I

    move-result v2

    .line 61
    .local v2, "originalDepth":I
    add-int/lit8 v3, v2, 0x1

    .line 63
    .local v3, "targetDepth":I
    invoke-virtual {v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->isStartOfDocument()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 64
    add-int/lit8 v3, v3, 0x1

    .line 67
    :cond_0
    new-instance v4, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    invoke-direct {v4}, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;-><init>()V

    .line 70
    .local v4, "config":Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
    :goto_0
    invoke-virtual {v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->nextEvent()I

    move-result v5

    .line 71
    .local v5, "xmlEvent":I
    const/4 v6, 0x1

    if-ne v5, v6, :cond_1

    .line 72
    nop

    .line 94
    .end local v5    # "xmlEvent":I
    return-object v4

    .line 73
    .restart local v5    # "xmlEvent":I
    :cond_1
    const/4 v6, 0x2

    if-ne v5, v6, :cond_5

    .line 74
    const-string v6, "TopicConfiguration"

    invoke-virtual {v1, v6, v3}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 75
    invoke-static {}, Lcom/amazonaws/services/s3/model/transform/TopicConfigurationStaxUnmarshaller;->getInstance()Lcom/amazonaws/services/s3/model/transform/TopicConfigurationStaxUnmarshaller;

    move-result-object v6

    .line 76
    invoke-virtual {v6, v1}, Lcom/amazonaws/services/s3/model/transform/TopicConfigurationStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/util/Map$Entry;

    move-result-object v6

    .line 77
    .local v6, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    invoke-interface {v6}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-interface {v6}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/amazonaws/services/s3/model/NotificationConfiguration;

    invoke-virtual {v4, v7, v8}, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->addConfiguration(Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 78
    .end local v6    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    goto :goto_2

    :cond_2
    const-string v6, "QueueConfiguration"

    invoke-virtual {v1, v6, v3}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 79
    invoke-static {}, Lcom/amazonaws/services/s3/model/transform/QueueConfigurationStaxUnmarshaller;->getInstance()Lcom/amazonaws/services/s3/model/transform/QueueConfigurationStaxUnmarshaller;

    move-result-object v6

    .line 80
    invoke-virtual {v6, v1}, Lcom/amazonaws/services/s3/model/transform/QueueConfigurationStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/util/Map$Entry;

    move-result-object v6

    .line 81
    .restart local v6    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    invoke-interface {v6}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-interface {v6}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/amazonaws/services/s3/model/NotificationConfiguration;

    invoke-virtual {v4, v7, v8}, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->addConfiguration(Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .end local v6    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    goto :goto_1

    .line 82
    :cond_3
    const-string v6, "CloudFunctionConfiguration"

    invoke-virtual {v1, v6, v3}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 83
    invoke-static {}, Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;->getInstance()Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;

    move-result-object v6

    .line 84
    invoke-virtual {v6, v1}, Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/util/Map$Entry;

    move-result-object v6

    .line 85
    .restart local v6    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    invoke-interface {v6}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-interface {v6}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/amazonaws/services/s3/model/NotificationConfiguration;

    invoke-virtual {v4, v7, v8}, Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;->addConfiguration(Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 86
    .end local v6    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/amazonaws/services/s3/model/NotificationConfiguration;>;"
    goto :goto_2

    .line 82
    :cond_4
    :goto_1
    goto :goto_2

    .line 87
    :cond_5
    const/4 v6, 0x3

    if-ne v5, v6, :cond_6

    .line 88
    invoke-virtual {v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->getCurrentDepth()I

    move-result v6

    if-ge v6, v2, :cond_6

    .line 89
    return-object v4

    .line 92
    .end local v5    # "xmlEvent":I
    :cond_6
    :goto_2
    goto :goto_0
.end method

.method public bridge synthetic unmarshall(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 30
    check-cast p1, Ljava/io/InputStream;

    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/transform/BucketNotificationConfigurationStaxUnmarshaller;->unmarshall(Ljava/io/InputStream;)Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    move-result-object p1

    return-object p1
.end method
