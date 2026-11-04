.class public Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "ListMultipartUploadsRequest.java"


# instance fields
.field private bucketName:Ljava/lang/String;

.field private delimiter:Ljava/lang/String;

.field private encodingType:Ljava/lang/String;

.field private keyMarker:Ljava/lang/String;

.field private maxUploads:Ljava/lang/Integer;

.field private prefix:Ljava/lang/String;

.field private uploadIdMarker:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 99
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 100
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->bucketName:Ljava/lang/String;

    .line 101
    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 109
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getDelimiter()Ljava/lang/String;
    .locals 1

    .line 291
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->delimiter:Ljava/lang/String;

    return-object v0
.end method

.method public getEncodingType()Ljava/lang/String;
    .locals 1

    .line 380
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->encodingType:Ljava/lang/String;

    return-object v0
.end method

.method public getKeyMarker()Ljava/lang/String;
    .locals 1

    .line 185
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->keyMarker:Ljava/lang/String;

    return-object v0
.end method

.method public getMaxUploads()Ljava/lang/Integer;
    .locals 1

    .line 141
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->maxUploads:Ljava/lang/Integer;

    return-object v0
.end method

.method public getPrefix()Ljava/lang/String;
    .locals 1

    .line 341
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->prefix:Ljava/lang/String;

    return-object v0
.end method

.method public getUploadIdMarker()Ljava/lang/String;
    .locals 1

    .line 235
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->uploadIdMarker:Ljava/lang/String;

    return-object v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 118
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->bucketName:Ljava/lang/String;

    .line 119
    return-void
.end method

.method public setDelimiter(Ljava/lang/String;)V
    .locals 0
    .param p1, "delimiter"    # Ljava/lang/String;

    .line 307
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->delimiter:Ljava/lang/String;

    .line 308
    return-void
.end method

.method public setEncodingType(Ljava/lang/String;)V
    .locals 0
    .param p1, "encodingType"    # Ljava/lang/String;

    .line 395
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->encodingType:Ljava/lang/String;

    .line 396
    return-void
.end method

.method public setKeyMarker(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyMarker"    # Ljava/lang/String;

    .line 207
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->keyMarker:Ljava/lang/String;

    .line 208
    return-void
.end method

.method public setMaxUploads(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "maxUploads"    # Ljava/lang/Integer;

    .line 150
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->maxUploads:Ljava/lang/Integer;

    .line 151
    return-void
.end method

.method public setPrefix(Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 353
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->prefix:Ljava/lang/String;

    .line 354
    return-void
.end method

.method public setUploadIdMarker(Ljava/lang/String;)V
    .locals 0
    .param p1, "uploadIdMarker"    # Ljava/lang/String;

    .line 252
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->uploadIdMarker:Ljava/lang/String;

    .line 253
    return-void
.end method

.method public withBucketName(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 130
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->bucketName:Ljava/lang/String;

    .line 131
    return-object p0
.end method

.method public withDelimiter(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;
    .locals 0
    .param p1, "delimiter"    # Ljava/lang/String;

    .line 327
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->setDelimiter(Ljava/lang/String;)V

    .line 328
    return-object p0
.end method

.method public withEncodingType(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;
    .locals 0
    .param p1, "encodingType"    # Ljava/lang/String;

    .line 412
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->setEncodingType(Ljava/lang/String;)V

    .line 413
    return-object p0
.end method

.method public withKeyMarker(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;
    .locals 0
    .param p1, "keyMarker"    # Ljava/lang/String;

    .line 217
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->keyMarker:Ljava/lang/String;

    .line 218
    return-object p0
.end method

.method public withMaxUploads(I)Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;
    .locals 1
    .param p1, "maxUploadsInt"    # I

    .line 162
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->maxUploads:Ljava/lang/Integer;

    .line 163
    return-object p0
.end method

.method public withPrefix(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 369
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->setPrefix(Ljava/lang/String;)V

    .line 370
    return-object p0
.end method

.method public withUploadIdMarker(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;
    .locals 0
    .param p1, "uploadIdMarker"    # Ljava/lang/String;

    .line 271
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListMultipartUploadsRequest;->uploadIdMarker:Ljava/lang/String;

    .line 272
    return-object p0
.end method
