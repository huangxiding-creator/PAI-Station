.class public Lio/minio/messages/InitiateMultipartUploadResult;
.super Ljava/lang/Object;
.source "InitiateMultipartUploadResult.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "InitiateMultipartUploadResult"
    strict = false
.end annotation


# instance fields
.field private bucketName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Bucket"
    .end annotation
.end field

.field private objectName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Key"
    .end annotation
.end field

.field private uploadId:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "UploadId"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bucketName()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/messages/InitiateMultipartUploadResult;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public objectName()Ljava/lang/String;
    .locals 1

    .line 49
    iget-object v0, p0, Lio/minio/messages/InitiateMultipartUploadResult;->objectName:Ljava/lang/String;

    return-object v0
.end method

.method public uploadId()Ljava/lang/String;
    .locals 1

    .line 54
    iget-object v0, p0, Lio/minio/messages/InitiateMultipartUploadResult;->uploadId:Ljava/lang/String;

    return-object v0
.end method
