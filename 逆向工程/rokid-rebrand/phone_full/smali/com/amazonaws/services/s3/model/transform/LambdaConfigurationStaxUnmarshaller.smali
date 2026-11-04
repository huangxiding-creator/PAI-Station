.class Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;
.super Ljava/lang/Object;
.source "LambdaConfigurationStaxUnmarshaller.java"

# interfaces
.implements Lcom/amazonaws/transform/Unmarshaller;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
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


# static fields
.field private static instance:Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 43
    new-instance v0, Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;

    invoke-direct {v0}, Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;-><init>()V

    sput-object v0, Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;->instance:Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 50
    return-void
.end method

.method private createLambdaConfig(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/model/Filter;)Ljava/util/Map$Entry;
    .locals 3
    .param p1, "id"    # Ljava/lang/String;
    .param p3, "functionArn"    # Ljava/lang/String;
    .param p4, "invocationRole"    # Ljava/lang/String;
    .param p5, "filter"    # Lcom/amazonaws/services/s3/model/Filter;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/s3/model/Filter;",
            ")",
            "Ljava/util/Map$Entry<",
            "Ljava/lang/String;",
            "Lcom/amazonaws/services/s3/model/NotificationConfiguration;",
            ">;"
        }
    .end annotation

    .line 99
    .local p2, "events":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const/4 v0, 0x0

    if-nez p4, :cond_0

    .line 100
    new-instance v1, Lcom/amazonaws/services/s3/model/LambdaConfiguration;

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {p2, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    invoke-direct {v1, p3, v0}, Lcom/amazonaws/services/s3/model/LambdaConfiguration;-><init>(Ljava/lang/String;[Ljava/lang/String;)V

    move-object v0, v1

    .local v0, "config":Lcom/amazonaws/services/s3/model/NotificationConfiguration;
    goto :goto_0

    .line 102
    .end local v0    # "config":Lcom/amazonaws/services/s3/model/NotificationConfiguration;
    :cond_0
    new-instance v1, Lcom/amazonaws/services/s3/model/CloudFunctionConfiguration;

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {p2, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    invoke-direct {v1, p4, p3, v0}, Lcom/amazonaws/services/s3/model/CloudFunctionConfiguration;-><init>(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;)V

    move-object v0, v1

    .line 104
    .restart local v0    # "config":Lcom/amazonaws/services/s3/model/NotificationConfiguration;
    :goto_0
    new-instance v1, Ljava/util/AbstractMap$SimpleEntry;

    invoke-virtual {v0, p5}, Lcom/amazonaws/services/s3/model/NotificationConfiguration;->withFilter(Lcom/amazonaws/services/s3/model/Filter;)Lcom/amazonaws/services/s3/model/NotificationConfiguration;

    move-result-object v2

    invoke-direct {v1, p1, v2}, Ljava/util/AbstractMap$SimpleEntry;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v1
.end method

.method public static getInstance()Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;
    .locals 1

    .line 46
    sget-object v0, Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;->instance:Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;

    return-object v0
.end method


# virtual methods
.method public bridge synthetic unmarshall(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 40
    check-cast p1, Lcom/amazonaws/transform/StaxUnmarshallerContext;

    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/util/Map$Entry;

    move-result-object p1

    return-object p1
.end method

.method public unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/util/Map$Entry;
    .locals 14
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

    .line 54
    invoke-virtual {p1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->getCurrentDepth()I

    move-result v0

    .line 55
    .local v0, "originalDepth":I
    add-int/lit8 v1, v0, 0x1

    .line 57
    .local v1, "targetDepth":I
    invoke-virtual {p1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->isStartOfDocument()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 58
    add-int/lit8 v1, v1, 0x1

    .line 61
    :cond_0
    const/4 v2, 0x0

    .line 62
    .local v2, "id":Ljava/lang/String;
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 63
    .local v3, "events":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const/4 v4, 0x0

    .line 64
    .local v4, "filter":Lcom/amazonaws/services/s3/model/Filter;
    const/4 v5, 0x0

    .line 65
    .local v5, "functionArn":Ljava/lang/String;
    const/4 v6, 0x0

    move-object v10, v4

    move-object v11, v5

    move-object v12, v6

    .line 68
    .end local v4    # "filter":Lcom/amazonaws/services/s3/model/Filter;
    .end local v5    # "functionArn":Ljava/lang/String;
    .local v10, "filter":Lcom/amazonaws/services/s3/model/Filter;
    .local v11, "functionArn":Ljava/lang/String;
    .local v12, "invocationRole":Ljava/lang/String;
    :goto_0
    invoke-virtual {p1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->nextEvent()I

    move-result v13

    .line 69
    .local v13, "xmlEvent":I
    const/4 v4, 0x1

    if-ne v13, v4, :cond_1

    .line 70
    nop

    .line 90
    .end local v13    # "xmlEvent":I
    const/4 v4, 0x0

    return-object v4

    .line 71
    .restart local v13    # "xmlEvent":I
    :cond_1
    const/4 v4, 0x2

    if-ne v13, v4, :cond_6

    .line 72
    const-string v4, "Id"

    invoke-virtual {p1, v4, v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 73
    invoke-static {}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->getInstance()Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;

    move-result-object v4

    invoke-virtual {v4, p1}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/lang/String;

    move-result-object v2

    goto/16 :goto_1

    .line 74
    :cond_2
    const-string v4, "Event"

    invoke-virtual {p1, v4, v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 75
    invoke-static {}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->getInstance()Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;

    move-result-object v4

    invoke-virtual {v4, p1}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 76
    :cond_3
    const-string v4, "Filter"

    invoke-virtual {p1, v4, v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 77
    invoke-static {}, Lcom/amazonaws/services/s3/model/transform/FilterStaxUnmarshaller;->getInstance()Lcom/amazonaws/services/s3/model/transform/FilterStaxUnmarshaller;

    move-result-object v4

    invoke-virtual {v4, p1}, Lcom/amazonaws/services/s3/model/transform/FilterStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Lcom/amazonaws/services/s3/model/Filter;

    move-result-object v4

    move-object v10, v4

    .end local v10    # "filter":Lcom/amazonaws/services/s3/model/Filter;
    .restart local v4    # "filter":Lcom/amazonaws/services/s3/model/Filter;
    goto :goto_1

    .line 78
    .end local v4    # "filter":Lcom/amazonaws/services/s3/model/Filter;
    .restart local v10    # "filter":Lcom/amazonaws/services/s3/model/Filter;
    :cond_4
    const-string v4, "CloudFunction"

    invoke-virtual {p1, v4, v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 79
    invoke-static {}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->getInstance()Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;

    move-result-object v4

    invoke-virtual {v4, p1}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/lang/String;

    move-result-object v4

    move-object v11, v4

    .end local v11    # "functionArn":Ljava/lang/String;
    .local v4, "functionArn":Ljava/lang/String;
    goto :goto_1

    .line 80
    .end local v4    # "functionArn":Ljava/lang/String;
    .restart local v11    # "functionArn":Ljava/lang/String;
    :cond_5
    const-string v4, "InvocationRole"

    invoke-virtual {p1, v4, v1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->testExpression(Ljava/lang/String;I)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 81
    invoke-static {}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->getInstance()Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;

    move-result-object v4

    invoke-virtual {v4, p1}, Lcom/amazonaws/transform/SimpleTypeStaxUnmarshallers$StringStaxUnmarshaller;->unmarshall(Lcom/amazonaws/transform/StaxUnmarshallerContext;)Ljava/lang/String;

    move-result-object v4

    move-object v12, v4

    .end local v12    # "invocationRole":Ljava/lang/String;
    .local v4, "invocationRole":Ljava/lang/String;
    goto :goto_1

    .line 83
    .end local v4    # "invocationRole":Ljava/lang/String;
    .restart local v12    # "invocationRole":Ljava/lang/String;
    :cond_6
    const/4 v4, 0x3

    if-ne v13, v4, :cond_7

    .line 84
    invoke-virtual {p1}, Lcom/amazonaws/transform/StaxUnmarshallerContext;->getCurrentDepth()I

    move-result v4

    if-ge v4, v0, :cond_7

    .line 85
    move-object v4, p0

    move-object v5, v2

    move-object v6, v3

    move-object v7, v11

    move-object v8, v12

    move-object v9, v10

    invoke-direct/range {v4 .. v9}, Lcom/amazonaws/services/s3/model/transform/LambdaConfigurationStaxUnmarshaller;->createLambdaConfig(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/model/Filter;)Ljava/util/Map$Entry;

    move-result-object v4

    return-object v4

    .line 88
    .end local v13    # "xmlEvent":I
    :cond_7
    :goto_1
    goto :goto_0
.end method
