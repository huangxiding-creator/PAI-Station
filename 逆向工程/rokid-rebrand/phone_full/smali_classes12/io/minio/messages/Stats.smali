.class public Lio/minio/messages/Stats;
.super Ljava/lang/Object;
.source "Stats.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Stats"
    strict = false
.end annotation


# instance fields
.field private bytesProcessed:J
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "BytesProcessed"
    .end annotation
.end field

.field private bytesReturned:J
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "BytesReturned"
    .end annotation
.end field

.field private bytesScanned:J
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "BytesScanned"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lio/minio/messages/Stats;->bytesScanned:J

    .line 30
    iput-wide v0, p0, Lio/minio/messages/Stats;->bytesProcessed:J

    .line 33
    iput-wide v0, p0, Lio/minio/messages/Stats;->bytesReturned:J

    .line 37
    return-void
.end method


# virtual methods
.method public bytesProcessed()J
    .locals 2

    .line 46
    iget-wide v0, p0, Lio/minio/messages/Stats;->bytesProcessed:J

    return-wide v0
.end method

.method public bytesReturned()J
    .locals 2

    .line 51
    iget-wide v0, p0, Lio/minio/messages/Stats;->bytesReturned:J

    return-wide v0
.end method

.method public bytesScanned()J
    .locals 2

    .line 41
    iget-wide v0, p0, Lio/minio/messages/Stats;->bytesScanned:J

    return-wide v0
.end method
