.class public Lio/minio/messages/ReplicationTime;
.super Ljava/lang/Object;
.source "ReplicationTime.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ReplicationTime"
.end annotation


# instance fields
.field private status:Lio/minio/messages/Status;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Status"
    .end annotation
.end field

.field private time:Lio/minio/messages/ReplicationTimeValue;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Time"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/ReplicationTimeValue;Lio/minio/messages/Status;)V
    .locals 1
    .param p1, "time"    # Lio/minio/messages/ReplicationTimeValue;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Time"
        .end annotation
    .end param
    .param p2, "status"    # Lio/minio/messages/Status;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Status"
        .end annotation
    .end param

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    const-string v0, "Time must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ReplicationTimeValue;

    iput-object v0, p0, Lio/minio/messages/ReplicationTime;->time:Lio/minio/messages/ReplicationTimeValue;

    .line 39
    const-string v0, "Status must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Status;

    iput-object v0, p0, Lio/minio/messages/ReplicationTime;->status:Lio/minio/messages/Status;

    .line 40
    return-void
.end method


# virtual methods
.method public status()Lio/minio/messages/Status;
    .locals 1

    .line 47
    iget-object v0, p0, Lio/minio/messages/ReplicationTime;->status:Lio/minio/messages/Status;

    return-object v0
.end method

.method public time()Lio/minio/messages/ReplicationTimeValue;
    .locals 1

    .line 43
    iget-object v0, p0, Lio/minio/messages/ReplicationTime;->time:Lio/minio/messages/ReplicationTimeValue;

    return-object v0
.end method
