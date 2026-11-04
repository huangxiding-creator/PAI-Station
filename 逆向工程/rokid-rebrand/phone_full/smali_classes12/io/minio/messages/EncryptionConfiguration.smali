.class public Lio/minio/messages/EncryptionConfiguration;
.super Ljava/lang/Object;
.source "EncryptionConfiguration.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "EncryptionConfiguration"
.end annotation


# instance fields
.field private replicaKmsKeyID:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ReplicaKmsKeyID"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "replicaKmsKeyID"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "ReplicaKmsKeyID"
            required = false
        .end annotation
    .end param

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    iput-object p1, p0, Lio/minio/messages/EncryptionConfiguration;->replicaKmsKeyID:Ljava/lang/String;

    .line 35
    return-void
.end method


# virtual methods
.method public replicaKmsKeyID()Ljava/lang/String;
    .locals 1

    .line 38
    iget-object v0, p0, Lio/minio/messages/EncryptionConfiguration;->replicaKmsKeyID:Ljava/lang/String;

    return-object v0
.end method
