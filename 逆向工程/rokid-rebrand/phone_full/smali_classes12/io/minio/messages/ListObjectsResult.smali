.class public abstract Lio/minio/messages/ListObjectsResult;
.super Ljava/lang/Object;
.source "ListObjectsResult.java"


# static fields
.field private static final deleteMarkers:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/DeleteMarker;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private commonPrefixes:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/Prefix;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "CommonPrefixes"
        required = false
    .end annotation
.end field

.field private delimiter:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Delimiter"
        required = false
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

.field private maxKeys:I
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "MaxKeys"
        required = false
    .end annotation
.end field

.field private name:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Name"
    .end annotation
.end field

.field private prefix:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Prefix"
        required = false
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 57
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    .line 58
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lio/minio/messages/ListObjectsResult;->deleteMarkers:Ljava/util/List;

    .line 57
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public commonPrefixes()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/Prefix;",
            ">;"
        }
    .end annotation

    .line 105
    iget-object v0, p0, Lio/minio/messages/ListObjectsResult;->commonPrefixes:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/ListObjectsResult;->commonPrefixes:Ljava/util/List;

    .line 104
    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public abstract contents()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "+",
            "Lio/minio/messages/Item;",
            ">;"
        }
    .end annotation
.end method

.method protected decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "value"    # Ljava/lang/String;

    .line 64
    if-eqz p1, :cond_0

    :try_start_0
    const-string/jumbo v0, "url"

    iget-object v1, p0, Lio/minio/messages/ListObjectsResult;->encodingType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 65
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0}, Ljava/nio/charset/Charset;->name()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 67
    :catch_0
    move-exception v0

    .line 69
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 66
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_0
    move-object v0, p1

    .line 64
    :goto_0
    return-object v0
.end method

.method public deleteMarkers()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/DeleteMarker;",
            ">;"
        }
    .end annotation

    .line 109
    sget-object v0, Lio/minio/messages/ListObjectsResult;->deleteMarkers:Ljava/util/List;

    return-object v0
.end method

.method public delimiter()Ljava/lang/String;
    .locals 1

    .line 89
    iget-object v0, p0, Lio/minio/messages/ListObjectsResult;->delimiter:Ljava/lang/String;

    return-object v0
.end method

.method protected emptyIfNull(Ljava/util/List;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Lio/minio/messages/Item;",
            ">(",
            "Ljava/util/List<",
            "TT;>;)",
            "Ljava/util/List<",
            "TT;>;"
        }
    .end annotation

    .line 113
    .local p1, "lst":Ljava/util/List;, "Ljava/util/List<TT;>;"
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    invoke-static {p1, v0}, Lcom/google/common/base/MoreObjects;->firstNonNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public encodingType()Ljava/lang/String;
    .locals 1

    .line 79
    iget-object v0, p0, Lio/minio/messages/ListObjectsResult;->encodingType:Ljava/lang/String;

    return-object v0
.end method

.method public isTruncated()Z
    .locals 1

    .line 94
    iget-boolean v0, p0, Lio/minio/messages/ListObjectsResult;->isTruncated:Z

    return v0
.end method

.method public maxKeys()I
    .locals 1

    .line 99
    iget v0, p0, Lio/minio/messages/ListObjectsResult;->maxKeys:I

    return v0
.end method

.method public name()Ljava/lang/String;
    .locals 1

    .line 75
    iget-object v0, p0, Lio/minio/messages/ListObjectsResult;->name:Ljava/lang/String;

    return-object v0
.end method

.method public prefix()Ljava/lang/String;
    .locals 1

    .line 84
    iget-object v0, p0, Lio/minio/messages/ListObjectsResult;->prefix:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lio/minio/messages/ListObjectsResult;->decodeIfNeeded(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
