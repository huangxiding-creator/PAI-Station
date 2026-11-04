.class public Lcom/amazonaws/services/s3/model/ListObjectsV2Result;
.super Ljava/lang/Object;
.source "ListObjectsV2Result.java"


# instance fields
.field private bucketName:Ljava/lang/String;

.field private commonPrefixes:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private continuationToken:Ljava/lang/String;

.field private delimiter:Ljava/lang/String;

.field private encodingType:Ljava/lang/String;

.field private isTruncated:Z

.field private keyCount:I

.field private maxKeys:I

.field private nextContinuationToken:Ljava/lang/String;

.field private objectSummaries:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/S3ObjectSummary;",
            ">;"
        }
    .end annotation
.end field

.field private prefix:Ljava/lang/String;

.field private startAfter:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->objectSummaries:Ljava/util/List;

    .line 35
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->commonPrefixes:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 128
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getCommonPrefixes()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 378
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->commonPrefixes:Ljava/util/List;

    return-object v0
.end method

.method public getContinuationToken()Ljava/lang/String;
    .locals 1

    .line 229
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->continuationToken:Ljava/lang/String;

    return-object v0
.end method

.method public getDelimiter()Ljava/lang/String;
    .locals 1

    .line 181
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->delimiter:Ljava/lang/String;

    return-object v0
.end method

.method public getEncodingType()Ljava/lang/String;
    .locals 1

    .line 207
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->encodingType:Ljava/lang/String;

    return-object v0
.end method

.method public getKeyCount()I
    .locals 1

    .line 276
    iget v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->keyCount:I

    return v0
.end method

.method public getMaxKeys()I
    .locals 1

    .line 299
    iget v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->maxKeys:I

    return v0
.end method

.method public getNextContinuationToken()Ljava/lang/String;
    .locals 1

    .line 253
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->nextContinuationToken:Ljava/lang/String;

    return-object v0
.end method

.method public getObjectSummaries()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/S3ObjectSummary;",
            ">;"
        }
    .end annotation

    .line 346
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->objectSummaries:Ljava/util/List;

    return-object v0
.end method

.method public getPrefix()Ljava/lang/String;
    .locals 1

    .line 151
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->prefix:Ljava/lang/String;

    return-object v0
.end method

.method public getStartAfter()Ljava/lang/String;
    .locals 1

    .line 320
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->startAfter:Ljava/lang/String;

    return-object v0
.end method

.method public isTruncated()Z
    .locals 1

    .line 104
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->isTruncated:Z

    return v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 139
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->bucketName:Ljava/lang/String;

    .line 140
    return-void
.end method

.method public setCommonPrefixes(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 389
    .local p1, "commonPrefixes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->commonPrefixes:Ljava/util/List;

    .line 390
    return-void
.end method

.method public setContinuationToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "continuationToken"    # Ljava/lang/String;

    .line 241
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->continuationToken:Ljava/lang/String;

    .line 242
    return-void
.end method

.method public setDelimiter(Ljava/lang/String;)V
    .locals 0
    .param p1, "delimiter"    # Ljava/lang/String;

    .line 192
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->delimiter:Ljava/lang/String;

    .line 193
    return-void
.end method

.method public setEncodingType(Ljava/lang/String;)V
    .locals 0
    .param p1, "encodingType"    # Ljava/lang/String;

    .line 218
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->encodingType:Ljava/lang/String;

    .line 219
    return-void
.end method

.method public setKeyCount(I)V
    .locals 0
    .param p1, "keyCount"    # I

    .line 285
    iput p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->keyCount:I

    .line 286
    return-void
.end method

.method public setMaxKeys(I)V
    .locals 0
    .param p1, "maxKeys"    # I

    .line 310
    iput p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->maxKeys:I

    .line 311
    return-void
.end method

.method public setNextContinuationToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "nextContinuationToken"    # Ljava/lang/String;

    .line 267
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->nextContinuationToken:Ljava/lang/String;

    .line 268
    return-void
.end method

.method public setPrefix(Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 162
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->prefix:Ljava/lang/String;

    .line 163
    return-void
.end method

.method public setStartAfter(Ljava/lang/String;)V
    .locals 0
    .param p1, "startAfter"    # Ljava/lang/String;

    .line 331
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->startAfter:Ljava/lang/String;

    .line 332
    return-void
.end method

.method public setTruncated(Z)V
    .locals 0
    .param p1, "isTruncated"    # Z

    .line 117
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/ListObjectsV2Result;->isTruncated:Z

    .line 118
    return-void
.end method
