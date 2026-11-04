.class public Lio/minio/messages/ExistingObjectReplication;
.super Ljava/lang/Object;
.source "ExistingObjectReplication.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ExistingObjectReplication"
.end annotation


# instance fields
.field private status:Lio/minio/messages/Status;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Status"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/Status;)V
    .locals 1
    .param p1, "status"    # Lio/minio/messages/Status;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Status"
        .end annotation
    .end param

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    const-string v0, "Status must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/Status;

    iput-object v0, p0, Lio/minio/messages/ExistingObjectReplication;->status:Lio/minio/messages/Status;

    .line 32
    return-void
.end method


# virtual methods
.method public status()Lio/minio/messages/Status;
    .locals 1

    .line 35
    iget-object v0, p0, Lio/minio/messages/ExistingObjectReplication;->status:Lio/minio/messages/Status;

    return-object v0
.end method
