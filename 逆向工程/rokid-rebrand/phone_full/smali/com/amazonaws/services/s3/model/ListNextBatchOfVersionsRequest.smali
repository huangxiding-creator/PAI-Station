.class public Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "ListNextBatchOfVersionsRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;


# direct methods
.method public constructor <init>(Lcom/amazonaws/services/s3/model/VersionListing;)V
    .locals 0
    .param p1, "previousVersionListing"    # Lcom/amazonaws/services/s3/model/VersionListing;

    .line 33
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 34
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->setPreviousVersionListing(Lcom/amazonaws/services/s3/model/VersionListing;)V

    .line 35
    return-void
.end method


# virtual methods
.method public getPreviousVersionListing()Lcom/amazonaws/services/s3/model/VersionListing;
    .locals 1

    .line 42
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;

    return-object v0
.end method

.method public setPreviousVersionListing(Lcom/amazonaws/services/s3/model/VersionListing;)V
    .locals 2
    .param p1, "previousVersionListing"    # Lcom/amazonaws/services/s3/model/VersionListing;

    .line 51
    if-eqz p1, :cond_0

    .line 54
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;

    .line 55
    return-void

    .line 52
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The parameter previousVersionListing must be specified."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public toListVersionsRequest()Lcom/amazonaws/services/s3/model/ListVersionsRequest;
    .locals 8

    .line 75
    new-instance v7, Lcom/amazonaws/services/s3/model/ListVersionsRequest;

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/VersionListing;->getBucketName()Ljava/lang/String;

    move-result-object v1

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;

    .line 76
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/VersionListing;->getPrefix()Ljava/lang/String;

    move-result-object v2

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;

    .line 77
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/VersionListing;->getNextKeyMarker()Ljava/lang/String;

    move-result-object v3

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;

    .line 78
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/VersionListing;->getNextVersionIdMarker()Ljava/lang/String;

    move-result-object v4

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;

    .line 79
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/VersionListing;->getDelimiter()Ljava/lang/String;

    move-result-object v5

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;

    .line 80
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/VersionListing;->getMaxKeys()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;)V

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->previousVersionListing:Lcom/amazonaws/services/s3/model/VersionListing;

    .line 81
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/VersionListing;->getEncodingType()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v7, v0}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->withEncodingType(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListVersionsRequest;

    move-result-object v0

    .line 75
    return-object v0
.end method

.method public withPreviousVersionListing(Lcom/amazonaws/services/s3/model/VersionListing;)Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;
    .locals 0
    .param p1, "previousVersionListing"    # Lcom/amazonaws/services/s3/model/VersionListing;

    .line 66
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListNextBatchOfVersionsRequest;->setPreviousVersionListing(Lcom/amazonaws/services/s3/model/VersionListing;)V

    .line 67
    return-object p0
.end method
