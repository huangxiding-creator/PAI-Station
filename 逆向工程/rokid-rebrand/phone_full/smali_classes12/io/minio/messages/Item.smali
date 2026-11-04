.class public abstract Lio/minio/messages/Item;
.super Ljava/lang/Object;
.source "Item.java"


# static fields
.field private static final UTF_8:Ljava/lang/String;


# instance fields
.field private encodingType:Ljava/lang/String;

.field private etag:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ETag"
        required = false
    .end annotation
.end field

.field private isDir:Z

.field private isLatest:Z
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "IsLatest"
        required = false
    .end annotation
.end field

.field private lastModified:Lio/minio/messages/ResponseDate;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "LastModified"
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
        required = false
    .end annotation
.end field

.field private size:J
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Size"
        required = false
    .end annotation
.end field

.field private storageClass:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "StorageClass"
        required = false
    .end annotation
.end field

.field private userMetadata:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementMap;
        attribute = false
        entry = "Items"
        inline = true
        key = "Key"
        required = false
        value = "Value"
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/Path;
        value = "UserMetadata"
    .end annotation
.end field

.field private versionId:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "VersionId"
        required = false
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 35
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0}, Ljava/nio/charset/Charset;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lio/minio/messages/Item;->UTF_8:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 71
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/minio/messages/Item;->isDir:Z

    .line 72
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/messages/Item;->encodingType:Ljava/lang/String;

    .line 74
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 71
    const/4 v0, 0x0

    iput-boolean v0, p0, Lio/minio/messages/Item;->isDir:Z

    .line 72
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/messages/Item;->encodingType:Ljava/lang/String;

    .line 78
    iput-object p1, p0, Lio/minio/messages/Item;->objectName:Ljava/lang/String;

    .line 79
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/minio/messages/Item;->isDir:Z

    .line 80
    return-void
.end method


# virtual methods
.method public etag()Ljava/lang/String;
    .locals 1

    .line 102
    iget-object v0, p0, Lio/minio/messages/Item;->etag:Ljava/lang/String;

    return-object v0
.end method

.method public isDeleteMarker()Z
    .locals 1

    .line 142
    instance-of v0, p0, Lio/minio/messages/DeleteMarker;

    return v0
.end method

.method public isDir()Z
    .locals 1

    .line 137
    iget-boolean v0, p0, Lio/minio/messages/Item;->isDir:Z

    return v0
.end method

.method public isLatest()Z
    .locals 1

    .line 127
    iget-boolean v0, p0, Lio/minio/messages/Item;->isLatest:Z

    return v0
.end method

.method public lastModified()Ljava/time/ZonedDateTime;
    .locals 1

    .line 97
    iget-object v0, p0, Lio/minio/messages/Item;->lastModified:Lio/minio/messages/ResponseDate;

    invoke-virtual {v0}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v0

    return-object v0
.end method

.method public objectName()Ljava/lang/String;
    .locals 2

    .line 89
    :try_start_0
    const-string/jumbo v0, "url"

    iget-object v1, p0, Lio/minio/messages/Item;->encodingType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lio/minio/messages/Item;->objectName:Ljava/lang/String;

    sget-object v1, Lio/minio/messages/Item;->UTF_8:Ljava/lang/String;

    invoke-static {v0, v1}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/Item;->objectName:Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-object v0

    .line 90
    :catch_0
    move-exception v0

    .line 91
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public owner()Lio/minio/messages/Owner;
    .locals 1

    .line 117
    iget-object v0, p0, Lio/minio/messages/Item;->owner:Lio/minio/messages/Owner;

    return-object v0
.end method

.method public setEncodingType(Ljava/lang/String;)V
    .locals 0
    .param p1, "encodingType"    # Ljava/lang/String;

    .line 83
    iput-object p1, p0, Lio/minio/messages/Item;->encodingType:Ljava/lang/String;

    .line 84
    return-void
.end method

.method public size()J
    .locals 2

    .line 107
    iget-wide v0, p0, Lio/minio/messages/Item;->size:J

    return-wide v0
.end method

.method public storageClass()Ljava/lang/String;
    .locals 1

    .line 112
    iget-object v0, p0, Lio/minio/messages/Item;->storageClass:Ljava/lang/String;

    return-object v0
.end method

.method public userMetadata()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 122
    iget-object v0, p0, Lio/minio/messages/Item;->userMetadata:Ljava/util/Map;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lio/minio/messages/Item;->userMetadata:Ljava/util/Map;

    :goto_0
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public versionId()Ljava/lang/String;
    .locals 1

    .line 132
    iget-object v0, p0, Lio/minio/messages/Item;->versionId:Ljava/lang/String;

    return-object v0
.end method
