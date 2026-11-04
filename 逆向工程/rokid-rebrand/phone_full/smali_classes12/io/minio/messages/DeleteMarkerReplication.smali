.class public Lio/minio/messages/DeleteMarkerReplication;
.super Ljava/lang/Object;
.source "DeleteMarkerReplication.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "DeleteMarkerReplication"
.end annotation


# instance fields
.field private status:Lio/minio/messages/Status;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Status"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/Status;)V
    .locals 1
    .param p1, "status"    # Lio/minio/messages/Status;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Status"
            required = false
        .end annotation
    .end param

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    if-nez p1, :cond_0

    sget-object v0, Lio/minio/messages/Status;->DISABLED:Lio/minio/messages/Status;

    goto :goto_0

    :cond_0
    move-object v0, p1

    :goto_0
    iput-object v0, p0, Lio/minio/messages/DeleteMarkerReplication;->status:Lio/minio/messages/Status;

    .line 33
    return-void
.end method


# virtual methods
.method public status()Lio/minio/messages/Status;
    .locals 1

    .line 36
    iget-object v0, p0, Lio/minio/messages/DeleteMarkerReplication;->status:Lio/minio/messages/Status;

    return-object v0
.end method
