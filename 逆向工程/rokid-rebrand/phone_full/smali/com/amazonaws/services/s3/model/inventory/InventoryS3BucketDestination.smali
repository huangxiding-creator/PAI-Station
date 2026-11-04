.class public Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;
.super Ljava/lang/Object;
.source "InventoryS3BucketDestination.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private accountId:Ljava/lang/String;

.field private bucketArn:Ljava/lang/String;

.field private format:Ljava/lang/String;

.field private prefix:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getAccountId()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->accountId:Ljava/lang/String;

    return-object v0
.end method

.method public getBucketArn()Ljava/lang/String;
    .locals 1

    .line 63
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->bucketArn:Ljava/lang/String;

    return-object v0
.end method

.method public getFormat()Ljava/lang/String;
    .locals 1

    .line 89
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->format:Ljava/lang/String;

    return-object v0
.end method

.method public getPrefix()Ljava/lang/String;
    .locals 1

    .line 134
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->prefix:Ljava/lang/String;

    return-object v0
.end method

.method public setAccountId(Ljava/lang/String;)V
    .locals 0
    .param p1, "accountId"    # Ljava/lang/String;

    .line 45
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->accountId:Ljava/lang/String;

    .line 46
    return-void
.end method

.method public setBucketArn(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketArn"    # Ljava/lang/String;

    .line 71
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->bucketArn:Ljava/lang/String;

    .line 72
    return-void
.end method

.method public setFormat(Lcom/amazonaws/services/s3/model/inventory/InventoryFormat;)V
    .locals 2
    .param p1, "format"    # Lcom/amazonaws/services/s3/model/inventory/InventoryFormat;

    .line 105
    if-nez p1, :cond_0

    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryFormat;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->setFormat(Ljava/lang/String;)V

    .line 106
    return-void
.end method

.method public setFormat(Ljava/lang/String;)V
    .locals 0
    .param p1, "format"    # Ljava/lang/String;

    .line 97
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->format:Ljava/lang/String;

    .line 98
    return-void
.end method

.method public setPrefix(Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 142
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->prefix:Ljava/lang/String;

    .line 143
    return-void
.end method

.method public withAccountId(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;
    .locals 0
    .param p1, "accountId"    # Ljava/lang/String;

    .line 55
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->setAccountId(Ljava/lang/String;)V

    .line 56
    return-object p0
.end method

.method public withBucketArn(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;
    .locals 0
    .param p1, "bucketArn"    # Ljava/lang/String;

    .line 81
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->setBucketArn(Ljava/lang/String;)V

    .line 82
    return-object p0
.end method

.method public withFormat(Lcom/amazonaws/services/s3/model/inventory/InventoryFormat;)Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;
    .locals 0
    .param p1, "format"    # Lcom/amazonaws/services/s3/model/inventory/InventoryFormat;

    .line 126
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->setFormat(Lcom/amazonaws/services/s3/model/inventory/InventoryFormat;)V

    .line 127
    return-object p0
.end method

.method public withFormat(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;
    .locals 0
    .param p1, "format"    # Ljava/lang/String;

    .line 115
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->setFormat(Ljava/lang/String;)V

    .line 116
    return-object p0
.end method

.method public withPrefix(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 152
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/inventory/InventoryS3BucketDestination;->setPrefix(Ljava/lang/String;)V

    .line 153
    return-object p0
.end method
