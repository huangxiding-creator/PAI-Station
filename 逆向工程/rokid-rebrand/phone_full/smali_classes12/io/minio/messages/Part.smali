.class public Lio/minio/messages/Part;
.super Ljava/lang/Object;
.source "Part.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Part"
    strict = false
.end annotation


# instance fields
.field private etag:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ETag"
    .end annotation
.end field

.field private lastModified:Lio/minio/messages/ResponseDate;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "LastModified"
        required = false
    .end annotation
.end field

.field private partNumber:I
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "PartNumber"
    .end annotation
.end field

.field private size:Ljava/lang/Long;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Size"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;)V
    .locals 0
    .param p1, "partNumber"    # I
    .param p2, "etag"    # Ljava/lang/String;

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    iput p1, p0, Lio/minio/messages/Part;->partNumber:I

    .line 48
    iput-object p2, p0, Lio/minio/messages/Part;->etag:Ljava/lang/String;

    .line 49
    return-void
.end method


# virtual methods
.method public etag()Ljava/lang/String;
    .locals 3

    .line 58
    iget-object v0, p0, Lio/minio/messages/Part;->etag:Ljava/lang/String;

    const-string v1, "\""

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public lastModified()Ljava/time/ZonedDateTime;
    .locals 1

    .line 63
    iget-object v0, p0, Lio/minio/messages/Part;->lastModified:Lio/minio/messages/ResponseDate;

    invoke-virtual {v0}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v0

    return-object v0
.end method

.method public partNumber()I
    .locals 1

    .line 53
    iget v0, p0, Lio/minio/messages/Part;->partNumber:I

    return v0
.end method

.method public partSize()J
    .locals 2

    .line 68
    iget-object v0, p0, Lio/minio/messages/Part;->size:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    return-wide v0
.end method
