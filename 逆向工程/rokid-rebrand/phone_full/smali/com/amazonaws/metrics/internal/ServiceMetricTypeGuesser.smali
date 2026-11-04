.class public final enum Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;
.super Ljava/lang/Enum;
.source "ServiceMetricTypeGuesser.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 32
    const/4 v0, 0x0

    new-array v0, v0, [Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;

    sput-object v0, Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;->$VALUES:[Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 32
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static guessThroughputMetricType(Lcom/amazonaws/Request;Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/metrics/ThroughputMetricType;
    .locals 6
    .param p1, "metricNameSuffix"    # Ljava/lang/String;
    .param p2, "byteCountMetricNameSuffix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lcom/amazonaws/metrics/ThroughputMetricType;"
        }
    .end annotation

    .line 43
    .local p0, "req":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    invoke-static {}, Lcom/amazonaws/metrics/AwsSdkMetrics;->isMetricsEnabled()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 44
    return-object v1

    .line 45
    :cond_0
    invoke-interface {p0}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v0

    .line 46
    .local v0, "orig":Lcom/amazonaws/AmazonWebServiceRequest;
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.amazonaws.services.s3"

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 47
    new-instance v1, Lcom/amazonaws/metrics/SimpleThroughputMetricType;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "S3"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 49
    invoke-interface {p0}, Lcom/amazonaws/Request;->getServiceName()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v4, v3}, Lcom/amazonaws/metrics/SimpleThroughputMetricType;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 47
    return-object v1

    .line 52
    :cond_1
    return-object v1
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 32
    const-class v0, Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;
    .locals 1

    .line 32
    sget-object v0, Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;->$VALUES:[Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;

    invoke-virtual {v0}, [Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/metrics/internal/ServiceMetricTypeGuesser;

    return-object v0
.end method
