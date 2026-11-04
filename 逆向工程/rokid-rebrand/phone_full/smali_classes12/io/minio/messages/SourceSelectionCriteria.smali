.class public Lio/minio/messages/SourceSelectionCriteria;
.super Ljava/lang/Object;
.source "SourceSelectionCriteria.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "SourceSelectionCriteria"
.end annotation


# instance fields
.field private replicaModifications:Lio/minio/messages/ReplicaModifications;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ReplicaModifications"
        required = false
    .end annotation
.end field

.field private sseKmsEncryptedObjects:Lio/minio/messages/SseKmsEncryptedObjects;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "SseKmsEncryptedObjects"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/SseKmsEncryptedObjects;)V
    .locals 1
    .param p1, "sseKmsEncryptedObjects"    # Lio/minio/messages/SseKmsEncryptedObjects;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 43
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lio/minio/messages/SourceSelectionCriteria;-><init>(Lio/minio/messages/SseKmsEncryptedObjects;Lio/minio/messages/ReplicaModifications;)V

    .line 44
    return-void
.end method

.method public constructor <init>(Lio/minio/messages/SseKmsEncryptedObjects;Lio/minio/messages/ReplicaModifications;)V
    .locals 0
    .param p1, "sseKmsEncryptedObjects"    # Lio/minio/messages/SseKmsEncryptedObjects;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "SseKmsEncryptedObjects"
            required = false
        .end annotation
    .end param
    .param p2, "replicaModifications"    # Lio/minio/messages/ReplicaModifications;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "ReplicaModifications"
            required = false
        .end annotation
    .end param

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    iput-object p1, p0, Lio/minio/messages/SourceSelectionCriteria;->sseKmsEncryptedObjects:Lio/minio/messages/SseKmsEncryptedObjects;

    .line 39
    iput-object p2, p0, Lio/minio/messages/SourceSelectionCriteria;->replicaModifications:Lio/minio/messages/ReplicaModifications;

    .line 40
    return-void
.end method


# virtual methods
.method public replicaModifications()Lio/minio/messages/ReplicaModifications;
    .locals 1

    .line 47
    iget-object v0, p0, Lio/minio/messages/SourceSelectionCriteria;->replicaModifications:Lio/minio/messages/ReplicaModifications;

    return-object v0
.end method

.method public sseKmsEncryptedObjects()Lio/minio/messages/SseKmsEncryptedObjects;
    .locals 1

    .line 51
    iget-object v0, p0, Lio/minio/messages/SourceSelectionCriteria;->sseKmsEncryptedObjects:Lio/minio/messages/SseKmsEncryptedObjects;

    return-object v0
.end method
