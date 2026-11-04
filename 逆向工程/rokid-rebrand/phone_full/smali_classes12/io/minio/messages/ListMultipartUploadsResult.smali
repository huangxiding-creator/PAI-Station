.class public Lio/minio/messages/ListMultipartUploadsResult;
.super Ljava/lang/Object;
.source "ListMultipartUploadsResult.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ListMultipartUploadsResult"
    strict = false
.end annotation


# instance fields
.field private bucketName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Bucket"
    .end annotation
.end field

.field private encodingType:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "EncodingType"
        required = false
    .end annotation
.end field

.field private isTruncated:Z
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "IsTruncated"
        required = false
    .end annotation
.end field

.field private keyMarker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "KeyMarker"
        required = false
    .end annotation
.end field

.field private maxUploads:I
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "MaxUploads"
    .end annotation
.end field

.field private nextKeyMarker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NextKeyMarker"
        required = false
    .end annotation
.end field

.field private nextUploadIdMarker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NextUploadIdMarker"
        required = false
    .end annotation
.end field

.field private uploadIdMarker:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "UploadIdMarker"
        required = false
    .end annotation
.end field

.field uploads:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/Upload;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "Upload"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "value"    # Ljava/lang/String;

    .line 70
    if-eqz p1, :cond_0

    :try_start_0
    const-string/jumbo v0, "url"

    iget-object v1, p0, Lio/minio/messages/ListMultipartUploadsResult;->encodingType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 71
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0}, Ljava/nio/charset/Charset;->name()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 73
    :catch_0
    move-exception v0

    .line 75
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 72
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_0
    move-object v0, p1

    .line 70
    :goto_0
    return-object v0
.end method


# virtual methods
.method public bucketName()Ljava/lang/String;
    .locals 1

    .line 86
    iget-object v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public encodingType()Ljava/lang/String;
    .locals 1

    .line 115
    iget-object v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->encodingType:Ljava/lang/String;

    return-object v0
.end method

.method public isTruncated()Z
    .locals 1

    .line 81
    iget-boolean v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->isTruncated:Z

    return v0
.end method

.method public keyMarker()Ljava/lang/String;
    .locals 1

    .line 91
    iget-object v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->keyMarker:Ljava/lang/String;

    invoke-direct {p0, v0}, Lio/minio/messages/ListMultipartUploadsResult;->decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public maxUploads()I
    .locals 1

    .line 111
    iget v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->maxUploads:I

    return v0
.end method

.method public nextKeyMarker()Ljava/lang/String;
    .locals 1

    .line 101
    iget-object v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->nextKeyMarker:Ljava/lang/String;

    invoke-direct {p0, v0}, Lio/minio/messages/ListMultipartUploadsResult;->decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public nextUploadIdMarker()Ljava/lang/String;
    .locals 1

    .line 106
    iget-object v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->nextUploadIdMarker:Ljava/lang/String;

    return-object v0
.end method

.method public uploadIdMarker()Ljava/lang/String;
    .locals 1

    .line 96
    iget-object v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->uploadIdMarker:Ljava/lang/String;

    return-object v0
.end method

.method public uploads()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/Upload;",
            ">;"
        }
    .end annotation

    .line 120
    iget-object v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->uploads:Ljava/util/List;

    if-nez v0, :cond_0

    .line 121
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0

    .line 124
    :cond_0
    iget-object v0, p0, Lio/minio/messages/ListMultipartUploadsResult;->uploads:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method
