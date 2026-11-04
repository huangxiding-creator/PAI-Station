.class public Lcom/amazonaws/services/s3/model/ListVersionsRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "ListVersionsRequest.java"


# instance fields
.field private bucketName:Ljava/lang/String;

.field private delimiter:Ljava/lang/String;

.field private encodingType:Ljava/lang/String;

.field private keyMarker:Ljava/lang/String;

.field private maxResults:Ljava/lang/Integer;

.field private prefix:Ljava/lang/String;

.field private versionIdMarker:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 165
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 166
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "keyMarker"    # Ljava/lang/String;
    .param p4, "versionIdMarker"    # Ljava/lang/String;
    .param p5, "delimiter"    # Ljava/lang/String;
    .param p6, "maxResults"    # Ljava/lang/Integer;

    .line 183
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 184
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setBucketName(Ljava/lang/String;)V

    .line 185
    invoke-virtual {p0, p2}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setPrefix(Ljava/lang/String;)V

    .line 186
    invoke-virtual {p0, p3}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setKeyMarker(Ljava/lang/String;)V

    .line 187
    invoke-virtual {p0, p4}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setVersionIdMarker(Ljava/lang/String;)V

    .line 188
    invoke-virtual {p0, p5}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setDelimiter(Ljava/lang/String;)V

    .line 189
    invoke-virtual {p0, p6}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setMaxResults(Ljava/lang/Integer;)V

    .line 190
    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 200
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getDelimiter()Ljava/lang/String;
    .locals 1

    .line 409
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->delimiter:Ljava/lang/String;

    return-object v0
.end method

.method public getEncodingType()Ljava/lang/String;
    .locals 1

    .line 509
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->encodingType:Ljava/lang/String;

    return-object v0
.end method

.method public getKeyMarker()Ljava/lang/String;
    .locals 1

    .line 297
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->keyMarker:Ljava/lang/String;

    return-object v0
.end method

.method public getMaxResults()Ljava/lang/Integer;
    .locals 1

    .line 466
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->maxResults:Ljava/lang/Integer;

    return-object v0
.end method

.method public getPrefix()Ljava/lang/String;
    .locals 1

    .line 244
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->prefix:Ljava/lang/String;

    return-object v0
.end method

.method public getVersionIdMarker()Ljava/lang/String;
    .locals 1

    .line 353
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->versionIdMarker:Ljava/lang/String;

    return-object v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 212
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->bucketName:Ljava/lang/String;

    .line 213
    return-void
.end method

.method public setDelimiter(Ljava/lang/String;)V
    .locals 0
    .param p1, "delimiter"    # Ljava/lang/String;

    .line 427
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->delimiter:Ljava/lang/String;

    .line 428
    return-void
.end method

.method public setEncodingType(Ljava/lang/String;)V
    .locals 0
    .param p1, "encodingType"    # Ljava/lang/String;

    .line 524
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->encodingType:Ljava/lang/String;

    .line 525
    return-void
.end method

.method public setKeyMarker(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyMarker"    # Ljava/lang/String;

    .line 312
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->keyMarker:Ljava/lang/String;

    .line 313
    return-void
.end method

.method public setMaxResults(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "maxResults"    # Ljava/lang/Integer;

    .line 480
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->maxResults:Ljava/lang/Integer;

    .line 481
    return-void
.end method

.method public setPrefix(Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 257
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->prefix:Ljava/lang/String;

    .line 258
    return-void
.end method

.method public setVersionIdMarker(Ljava/lang/String;)V
    .locals 0
    .param p1, "versionIdMarker"    # Ljava/lang/String;

    .line 368
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->versionIdMarker:Ljava/lang/String;

    .line 369
    return-void
.end method

.method public withBucketName(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListVersionsRequest;
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 228
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setBucketName(Ljava/lang/String;)V

    .line 229
    return-object p0
.end method

.method public withDelimiter(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListVersionsRequest;
    .locals 0
    .param p1, "delimiter"    # Ljava/lang/String;

    .line 449
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setDelimiter(Ljava/lang/String;)V

    .line 450
    return-object p0
.end method

.method public withEncodingType(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListVersionsRequest;
    .locals 0
    .param p1, "encodingType"    # Ljava/lang/String;

    .line 541
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setEncodingType(Ljava/lang/String;)V

    .line 542
    return-object p0
.end method

.method public withKeyMarker(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListVersionsRequest;
    .locals 0
    .param p1, "keyMarker"    # Ljava/lang/String;

    .line 330
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setKeyMarker(Ljava/lang/String;)V

    .line 331
    return-object p0
.end method

.method public withMaxResults(Ljava/lang/Integer;)Lcom/amazonaws/services/s3/model/ListVersionsRequest;
    .locals 0
    .param p1, "maxResults"    # Ljava/lang/Integer;

    .line 498
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setMaxResults(Ljava/lang/Integer;)V

    .line 499
    return-object p0
.end method

.method public withPrefix(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListVersionsRequest;
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 273
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setPrefix(Ljava/lang/String;)V

    .line 274
    return-object p0
.end method

.method public withVersionIdMarker(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListVersionsRequest;
    .locals 0
    .param p1, "versionIdMarker"    # Ljava/lang/String;

    .line 386
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListVersionsRequest;->setVersionIdMarker(Ljava/lang/String;)V

    .line 387
    return-object p0
.end method
