.class public Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;
.super Ljava/lang/Object;
.source "ListBucketMetricsConfigurationsResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private continuationToken:Ljava/lang/String;

.field private isTruncated:Z

.field private metricsConfigurationList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/metrics/MetricsConfiguration;",
            ">;"
        }
    .end annotation
.end field

.field private nextContinuationToken:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getContinuationToken()Ljava/lang/String;
    .locals 1

    .line 127
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->continuationToken:Ljava/lang/String;

    return-object v0
.end method

.method public getMetricsConfigurationList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/metrics/MetricsConfiguration;",
            ">;"
        }
    .end annotation

    .line 57
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->metricsConfigurationList:Ljava/util/List;

    return-object v0
.end method

.method public getNextContinuationToken()Ljava/lang/String;
    .locals 1

    .line 167
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->nextContinuationToken:Ljava/lang/String;

    return-object v0
.end method

.method public isTruncated()Z
    .locals 1

    .line 86
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->isTruncated:Z

    return v0
.end method

.method public setContinuationToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "continuationToken"    # Ljava/lang/String;

    .line 139
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->continuationToken:Ljava/lang/String;

    .line 140
    return-void
.end method

.method public setMetricsConfigurationList(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/metrics/MetricsConfiguration;",
            ">;)V"
        }
    .end annotation

    .line 64
    .local p1, "metricsConfigurationList":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/metrics/MetricsConfiguration;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->metricsConfigurationList:Ljava/util/List;

    .line 65
    return-void
.end method

.method public setNextContinuationToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "nextContinuationToken"    # Ljava/lang/String;

    .line 180
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->nextContinuationToken:Ljava/lang/String;

    .line 181
    return-void
.end method

.method public setTruncated(Z)V
    .locals 0
    .param p1, "isTruncated"    # Z

    .line 99
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->isTruncated:Z

    .line 100
    return-void
.end method

.method public withContinuationToken(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;
    .locals 0
    .param p1, "continuationToken"    # Ljava/lang/String;

    .line 154
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->setContinuationToken(Ljava/lang/String;)V

    .line 155
    return-object p0
.end method

.method public withMetricsConfigurationList(Ljava/util/List;)Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/metrics/MetricsConfiguration;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;"
        }
    .end annotation

    .line 72
    .local p1, "metricsConfigurationList":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/metrics/MetricsConfiguration;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->setMetricsConfigurationList(Ljava/util/List;)V

    .line 73
    return-object p0
.end method

.method public withNextContinuationToken(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;
    .locals 0
    .param p1, "nextContinuationToken"    # Ljava/lang/String;

    .line 196
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->setNextContinuationToken(Ljava/lang/String;)V

    .line 197
    return-object p0
.end method

.method public withTruncated(Z)Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;
    .locals 0
    .param p1, "isTruncated"    # Z

    .line 115
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListBucketMetricsConfigurationsResult;->setTruncated(Z)V

    .line 116
    return-object p0
.end method
