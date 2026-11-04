.class public Lio/minio/messages/Upload;
.super Ljava/lang/Object;
.source "Upload.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Upload"
    strict = false
.end annotation


# instance fields
.field private aggregatedPartSize:J

.field private encodingType:Ljava/lang/String;

.field private initiated:Lio/minio/messages/ResponseDate;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Initiated"
    .end annotation
.end field

.field private initiator:Lio/minio/messages/Initiator;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Initiator"
    .end annotation
.end field

.field private objectName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Key"
    .end annotation
.end field

.field private owner:Lio/minio/messages/Owner;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Owner"
    .end annotation
.end field

.field private storageClass:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "StorageClass"
    .end annotation
.end field

.field private uploadId:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "UploadId"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/messages/Upload;->encodingType:Ljava/lang/String;

    .line 56
    return-void
.end method


# virtual methods
.method public aggregatedPartSize()J
    .locals 2

    .line 97
    iget-wide v0, p0, Lio/minio/messages/Upload;->aggregatedPartSize:J

    return-wide v0
.end method

.method public initiated()Ljava/time/ZonedDateTime;
    .locals 1

    .line 92
    iget-object v0, p0, Lio/minio/messages/Upload;->initiated:Lio/minio/messages/ResponseDate;

    invoke-virtual {v0}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v0

    return-object v0
.end method

.method public initiator()Lio/minio/messages/Initiator;
    .locals 1

    .line 77
    iget-object v0, p0, Lio/minio/messages/Upload;->initiator:Lio/minio/messages/Initiator;

    return-object v0
.end method

.method public objectName()Ljava/lang/String;
    .locals 2

    .line 61
    :try_start_0
    const-string/jumbo v0, "url"

    iget-object v1, p0, Lio/minio/messages/Upload;->encodingType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 62
    iget-object v0, p0, Lio/minio/messages/Upload;->objectName:Ljava/lang/String;

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v1}, Ljava/nio/charset/Charset;->name()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 63
    :cond_0
    iget-object v0, p0, Lio/minio/messages/Upload;->objectName:Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 61
    :goto_0
    return-object v0

    .line 64
    :catch_0
    move-exception v0

    .line 66
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public owner()Lio/minio/messages/Owner;
    .locals 1

    .line 82
    iget-object v0, p0, Lio/minio/messages/Upload;->owner:Lio/minio/messages/Owner;

    return-object v0
.end method

.method public setAggregatedPartSize(J)V
    .locals 0
    .param p1, "size"    # J

    .line 102
    iput-wide p1, p0, Lio/minio/messages/Upload;->aggregatedPartSize:J

    .line 103
    return-void
.end method

.method public setEncodingType(Ljava/lang/String;)V
    .locals 0
    .param p1, "encodingType"    # Ljava/lang/String;

    .line 106
    iput-object p1, p0, Lio/minio/messages/Upload;->encodingType:Ljava/lang/String;

    .line 107
    return-void
.end method

.method public storageClass()Ljava/lang/String;
    .locals 1

    .line 87
    iget-object v0, p0, Lio/minio/messages/Upload;->storageClass:Ljava/lang/String;

    return-object v0
.end method

.method public uploadId()Ljava/lang/String;
    .locals 1

    .line 72
    iget-object v0, p0, Lio/minio/messages/Upload;->uploadId:Ljava/lang/String;

    return-object v0
.end method
