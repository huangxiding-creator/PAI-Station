.class public Lio/minio/messages/Bucket;
.super Ljava/lang/Object;
.source "Bucket.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Bucket"
    strict = false
.end annotation


# instance fields
.field private creationDate:Lio/minio/messages/ResponseDate;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "CreationDate"
    .end annotation
.end field

.field private name:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Name"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public creationDate()Ljava/time/ZonedDateTime;
    .locals 1

    .line 42
    iget-object v0, p0, Lio/minio/messages/Bucket;->creationDate:Lio/minio/messages/ResponseDate;

    invoke-virtual {v0}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v0

    return-object v0
.end method

.method public name()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lio/minio/messages/Bucket;->name:Ljava/lang/String;

    return-object v0
.end method
