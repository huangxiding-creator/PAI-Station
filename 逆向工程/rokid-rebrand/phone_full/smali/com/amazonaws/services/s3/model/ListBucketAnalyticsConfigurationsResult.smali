.class public Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;
.super Ljava/lang/Object;
.source "ListBucketAnalyticsConfigurationsResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private analyticsConfigurationList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/analytics/AnalyticsConfiguration;",
            ">;"
        }
    .end annotation
.end field

.field private continuationToken:Ljava/lang/String;

.field private isTruncated:Z

.field private nextContinuationToken:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getAnalyticsConfigurationList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/analytics/AnalyticsConfiguration;",
            ">;"
        }
    .end annotation

    .line 56
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->analyticsConfigurationList:Ljava/util/List;

    return-object v0
.end method

.method public getContinuationToken()Ljava/lang/String;
    .locals 1

    .line 126
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->continuationToken:Ljava/lang/String;

    return-object v0
.end method

.method public getNextContinuationToken()Ljava/lang/String;
    .locals 1

    .line 166
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->nextContinuationToken:Ljava/lang/String;

    return-object v0
.end method

.method public isTruncated()Z
    .locals 1

    .line 85
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->isTruncated:Z

    return v0
.end method

.method public setAnalyticsConfigurationList(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/analytics/AnalyticsConfiguration;",
            ">;)V"
        }
    .end annotation

    .line 63
    .local p1, "analyticsConfigurationList":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/analytics/AnalyticsConfiguration;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->analyticsConfigurationList:Ljava/util/List;

    .line 64
    return-void
.end method

.method public setContinuationToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "continuationToken"    # Ljava/lang/String;

    .line 138
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->continuationToken:Ljava/lang/String;

    .line 139
    return-void
.end method

.method public setNextContinuationToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "nextContinuationToken"    # Ljava/lang/String;

    .line 179
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->nextContinuationToken:Ljava/lang/String;

    .line 180
    return-void
.end method

.method public setTruncated(Z)V
    .locals 0
    .param p1, "isTruncated"    # Z

    .line 98
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->isTruncated:Z

    .line 99
    return-void
.end method

.method public withAnalyticsConfigurationList(Ljava/util/List;)Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/analytics/AnalyticsConfiguration;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;"
        }
    .end annotation

    .line 71
    .local p1, "analyticsConfigurationList":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/analytics/AnalyticsConfiguration;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->setAnalyticsConfigurationList(Ljava/util/List;)V

    .line 72
    return-object p0
.end method

.method public withContinuationToken(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;
    .locals 0
    .param p1, "continuationToken"    # Ljava/lang/String;

    .line 153
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->setContinuationToken(Ljava/lang/String;)V

    .line 154
    return-object p0
.end method

.method public withNextContinuationToken(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;
    .locals 0
    .param p1, "nextContinuationToken"    # Ljava/lang/String;

    .line 195
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->setNextContinuationToken(Ljava/lang/String;)V

    .line 196
    return-object p0
.end method

.method public withTruncated(Z)Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;
    .locals 0
    .param p1, "isTruncated"    # Z

    .line 114
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListBucketAnalyticsConfigurationsResult;->setTruncated(Z)V

    .line 115
    return-object p0
.end method
