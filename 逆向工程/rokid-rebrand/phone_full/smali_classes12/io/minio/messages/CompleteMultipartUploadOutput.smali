.class public Lio/minio/messages/CompleteMultipartUploadOutput;
.super Ljava/lang/Object;
.source "CompleteMultipartUploadOutput.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "CompleteMultipartUploadOutput"
.end annotation


# instance fields
.field private bucket:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Bucket"
    .end annotation
.end field

.field private checksumCRC32:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ChecksumCRC32"
        required = false
    .end annotation
.end field

.field private checksumCRC32C:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ChecksumCRC32C"
        required = false
    .end annotation
.end field

.field private checksumSHA1:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ChecksumSHA1"
        required = false
    .end annotation
.end field

.field private checksumSHA256:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ChecksumSHA256"
        required = false
    .end annotation
.end field

.field private etag:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ETag"
    .end annotation
.end field

.field private location:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Location"
    .end annotation
.end field

.field private object:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Key"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bucket()Ljava/lang/String;
    .locals 1

    .line 62
    iget-object v0, p0, Lio/minio/messages/CompleteMultipartUploadOutput;->bucket:Ljava/lang/String;

    return-object v0
.end method

.method public checksumCRC32()Ljava/lang/String;
    .locals 1

    .line 74
    iget-object v0, p0, Lio/minio/messages/CompleteMultipartUploadOutput;->checksumCRC32:Ljava/lang/String;

    return-object v0
.end method

.method public checksumCRC32C()Ljava/lang/String;
    .locals 1

    .line 78
    iget-object v0, p0, Lio/minio/messages/CompleteMultipartUploadOutput;->checksumCRC32C:Ljava/lang/String;

    return-object v0
.end method

.method public checksumSHA1()Ljava/lang/String;
    .locals 1

    .line 82
    iget-object v0, p0, Lio/minio/messages/CompleteMultipartUploadOutput;->checksumSHA1:Ljava/lang/String;

    return-object v0
.end method

.method public checksumSHA256()Ljava/lang/String;
    .locals 1

    .line 86
    iget-object v0, p0, Lio/minio/messages/CompleteMultipartUploadOutput;->checksumSHA256:Ljava/lang/String;

    return-object v0
.end method

.method public etag()Ljava/lang/String;
    .locals 1

    .line 70
    iget-object v0, p0, Lio/minio/messages/CompleteMultipartUploadOutput;->etag:Ljava/lang/String;

    return-object v0
.end method

.method public location()Ljava/lang/String;
    .locals 1

    .line 58
    iget-object v0, p0, Lio/minio/messages/CompleteMultipartUploadOutput;->location:Ljava/lang/String;

    return-object v0
.end method

.method public object()Ljava/lang/String;
    .locals 1

    .line 66
    iget-object v0, p0, Lio/minio/messages/CompleteMultipartUploadOutput;->object:Ljava/lang/String;

    return-object v0
.end method
