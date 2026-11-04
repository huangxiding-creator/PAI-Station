.class public Lio/minio/messages/Metrics;
.super Ljava/lang/Object;
.source "Metrics.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Metrics"
.end annotation


# instance fields
.field private eventThreshold:Lio/minio/messages/ReplicationTimeValue;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "EventThreshold"
    .end annotation
.end field

.field private status:Lio/minio/messages/Status;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Status"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/ReplicationTimeValue;Lio/minio/messages/Status;)V
    .locals 1
    .param p1, "eventThreshold"    # Lio/minio/messages/ReplicationTimeValue;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "EventThreshold"
        .end annotation
    .end param
    .param p2, "status"    # Lio/minio/messages/Status;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Status"
        .end annotation
    .end param

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    nop

    .line 37
    const-string v0, "Event threshold must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ReplicationTimeValue;

    iput-object v0, p0, Lio/minio/messages/Metrics;->eventThreshold:Lio/minio/messages/ReplicationTimeValue;

    .line 38
    const-string v0, "Status must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Status;

    iput-object v0, p0, Lio/minio/messages/Metrics;->status:Lio/minio/messages/Status;

    .line 39
    return-void
.end method


# virtual methods
.method public eventThreshold()Lio/minio/messages/ReplicationTimeValue;
    .locals 1

    .line 42
    iget-object v0, p0, Lio/minio/messages/Metrics;->eventThreshold:Lio/minio/messages/ReplicationTimeValue;

    return-object v0
.end method

.method public status()Lio/minio/messages/Status;
    .locals 1

    .line 46
    iget-object v0, p0, Lio/minio/messages/Metrics;->status:Lio/minio/messages/Status;

    return-object v0
.end method
