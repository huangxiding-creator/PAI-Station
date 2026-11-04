.class public Lio/minio/messages/ListPartsResult;
.super Ljava/lang/Object;
.source "ListPartsResult.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ListPartsResult"
    strict = false
.end annotation


# instance fields
.field private bucketName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Bucket"
    .end annotation
.end field

.field private initiator:Lio/minio/messages/Initiator;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Initiator"
    .end annotation
.end field

.field private isTruncated:Z
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "IsTruncated"
    .end annotation
.end field

.field private maxParts:I
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "MaxParts"
    .end annotation
.end field

.field private nextPartNumberMarker:I
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "NextPartNumberMarker"
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

.field private partList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lio/minio/messages/Part;",
            ">;"
        }
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/ElementList;
        inline = true
        name = "Part"
        required = false
    .end annotation
.end field

.field private partNumberMarker:I
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "PartNumberMarker"
    .end annotation
.end field

.field private storageClass:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "StorageClass"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bucketName()Ljava/lang/String;
    .locals 1

    .line 69
    iget-object v0, p0, Lio/minio/messages/ListPartsResult;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public initiator()Lio/minio/messages/Initiator;
    .locals 1

    .line 84
    iget-object v0, p0, Lio/minio/messages/ListPartsResult;->initiator:Lio/minio/messages/Initiator;

    return-object v0
.end method

.method public isTruncated()Z
    .locals 1

    .line 99
    iget-boolean v0, p0, Lio/minio/messages/ListPartsResult;->isTruncated:Z

    return v0
.end method

.method public maxParts()I
    .locals 1

    .line 94
    iget v0, p0, Lio/minio/messages/ListPartsResult;->maxParts:I

    return v0
.end method

.method public nextPartNumberMarker()I
    .locals 1

    .line 109
    iget v0, p0, Lio/minio/messages/ListPartsResult;->nextPartNumberMarker:I

    return v0
.end method

.method public objectName()Ljava/lang/String;
    .locals 1

    .line 74
    iget-object v0, p0, Lio/minio/messages/ListPartsResult;->objectName:Ljava/lang/String;

    return-object v0
.end method

.method public owner()Lio/minio/messages/Owner;
    .locals 1

    .line 89
    iget-object v0, p0, Lio/minio/messages/ListPartsResult;->owner:Lio/minio/messages/Owner;

    return-object v0
.end method

.method public partList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lio/minio/messages/Part;",
            ">;"
        }
    .end annotation

    .line 114
    iget-object v0, p0, Lio/minio/messages/ListPartsResult;->partList:Ljava/util/List;

    if-nez v0, :cond_0

    .line 115
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0

    .line 118
    :cond_0
    iget-object v0, p0, Lio/minio/messages/ListPartsResult;->partList:Ljava/util/List;

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public partNumberMarker()I
    .locals 1

    .line 104
    iget v0, p0, Lio/minio/messages/ListPartsResult;->partNumberMarker:I

    return v0
.end method

.method public storageClass()Ljava/lang/String;
    .locals 1

    .line 79
    iget-object v0, p0, Lio/minio/messages/ListPartsResult;->storageClass:Ljava/lang/String;

    return-object v0
.end method
