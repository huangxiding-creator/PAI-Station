.class public Lio/minio/messages/Retention;
.super Ljava/lang/Object;
.source "Retention.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Retention"
    strict = false
.end annotation


# instance fields
.field private mode:Lio/minio/messages/RetentionMode;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Mode"
        required = false
    .end annotation
.end field

.field private retainUntilDate:Lio/minio/messages/ResponseDate;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "RetainUntilDate"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Lio/minio/messages/RetentionMode;Ljava/time/ZonedDateTime;)V
    .locals 2
    .param p1, "mode"    # Lio/minio/messages/RetentionMode;
    .param p2, "retainUntilDate"    # Ljava/time/ZonedDateTime;

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    if-eqz p1, :cond_1

    .line 49
    if-eqz p2, :cond_0

    .line 53
    iput-object p1, p0, Lio/minio/messages/Retention;->mode:Lio/minio/messages/RetentionMode;

    .line 54
    new-instance v0, Lio/minio/messages/ResponseDate;

    invoke-direct {v0, p2}, Lio/minio/messages/ResponseDate;-><init>(Ljava/time/ZonedDateTime;)V

    iput-object v0, p0, Lio/minio/messages/Retention;->retainUntilDate:Lio/minio/messages/ResponseDate;

    .line 55
    return-void

    .line 50
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "null retainUntilDate is not allowed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 46
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "null mode is not allowed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public mode()Lio/minio/messages/RetentionMode;
    .locals 1

    .line 59
    iget-object v0, p0, Lio/minio/messages/Retention;->mode:Lio/minio/messages/RetentionMode;

    return-object v0
.end method

.method public retainUntilDate()Ljava/time/ZonedDateTime;
    .locals 1

    .line 64
    iget-object v0, p0, Lio/minio/messages/Retention;->retainUntilDate:Lio/minio/messages/ResponseDate;

    if-eqz v0, :cond_0

    .line 65
    iget-object v0, p0, Lio/minio/messages/Retention;->retainUntilDate:Lio/minio/messages/ResponseDate;

    invoke-virtual {v0}, Lio/minio/messages/ResponseDate;->zonedDateTime()Ljava/time/ZonedDateTime;

    move-result-object v0

    return-object v0

    .line 68
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method
