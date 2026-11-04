.class public Lio/minio/messages/ReplicationDestination;
.super Ljava/lang/Object;
.source "ReplicationDestination.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Destination"
.end annotation


# instance fields
.field private accessControlTranslation:Lio/minio/messages/AccessControlTranslation;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "AccessControlTranslation"
        required = false
    .end annotation
.end field

.field private account:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Account"
        required = false
    .end annotation
.end field

.field private bucketArn:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Bucket"
    .end annotation
.end field

.field private encryptionConfiguration:Lio/minio/messages/EncryptionConfiguration;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "EncryptionConfiguration"
        required = false
    .end annotation
.end field

.field private metrics:Lio/minio/messages/Metrics;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Metrics"
        required = false
    .end annotation
.end field

.field private replicationTime:Lio/minio/messages/ReplicationTime;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "ReplicationTime"
        required = false
    .end annotation
.end field

.field private storageClass:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "StorageClass"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/AccessControlTranslation;Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/EncryptionConfiguration;Lio/minio/messages/Metrics;Lio/minio/messages/ReplicationTime;Ljava/lang/String;)V
    .locals 1
    .param p1, "accessControlTranslation"    # Lio/minio/messages/AccessControlTranslation;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "AccessControlTranslation"
            required = false
        .end annotation
    .end param
    .param p2, "account"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Account"
            required = false
        .end annotation
    .end param
    .param p3, "bucketArn"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Bucket"
        .end annotation
    .end param
    .param p4, "encryptionConfiguration"    # Lio/minio/messages/EncryptionConfiguration;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "EncryptionConfiguration"
            required = false
        .end annotation
    .end param
    .param p5, "metrics"    # Lio/minio/messages/Metrics;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Metrics"
            required = false
        .end annotation
    .end param
    .param p6, "replicationTime"    # Lio/minio/messages/ReplicationTime;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "ReplicationTime"
            required = false
        .end annotation
    .end param
    .param p7, "storageClass"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "StorageClass"
            required = false
        .end annotation
    .end param

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 62
    iput-object p1, p0, Lio/minio/messages/ReplicationDestination;->accessControlTranslation:Lio/minio/messages/AccessControlTranslation;

    .line 63
    iput-object p2, p0, Lio/minio/messages/ReplicationDestination;->account:Ljava/lang/String;

    .line 64
    const-string v0, "Bucket ARN must not be null"

    invoke-static {p3, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/messages/ReplicationDestination;->bucketArn:Ljava/lang/String;

    .line 65
    iput-object p4, p0, Lio/minio/messages/ReplicationDestination;->encryptionConfiguration:Lio/minio/messages/EncryptionConfiguration;

    .line 66
    iput-object p5, p0, Lio/minio/messages/ReplicationDestination;->metrics:Lio/minio/messages/Metrics;

    .line 67
    iput-object p6, p0, Lio/minio/messages/ReplicationDestination;->replicationTime:Lio/minio/messages/ReplicationTime;

    .line 68
    iput-object p7, p0, Lio/minio/messages/ReplicationDestination;->storageClass:Ljava/lang/String;

    .line 69
    return-void
.end method


# virtual methods
.method public accessControlTranslation()Lio/minio/messages/AccessControlTranslation;
    .locals 1

    .line 72
    iget-object v0, p0, Lio/minio/messages/ReplicationDestination;->accessControlTranslation:Lio/minio/messages/AccessControlTranslation;

    return-object v0
.end method

.method public account()Ljava/lang/String;
    .locals 1

    .line 76
    iget-object v0, p0, Lio/minio/messages/ReplicationDestination;->account:Ljava/lang/String;

    return-object v0
.end method

.method public bucketArn()Ljava/lang/String;
    .locals 1

    .line 80
    iget-object v0, p0, Lio/minio/messages/ReplicationDestination;->bucketArn:Ljava/lang/String;

    return-object v0
.end method

.method public encryptionConfiguration()Lio/minio/messages/EncryptionConfiguration;
    .locals 1

    .line 84
    iget-object v0, p0, Lio/minio/messages/ReplicationDestination;->encryptionConfiguration:Lio/minio/messages/EncryptionConfiguration;

    return-object v0
.end method

.method public metrics()Lio/minio/messages/Metrics;
    .locals 1

    .line 88
    iget-object v0, p0, Lio/minio/messages/ReplicationDestination;->metrics:Lio/minio/messages/Metrics;

    return-object v0
.end method

.method public replicationTime()Lio/minio/messages/ReplicationTime;
    .locals 1

    .line 92
    iget-object v0, p0, Lio/minio/messages/ReplicationDestination;->replicationTime:Lio/minio/messages/ReplicationTime;

    return-object v0
.end method

.method public storageClass()Ljava/lang/String;
    .locals 1

    .line 96
    iget-object v0, p0, Lio/minio/messages/ReplicationDestination;->storageClass:Ljava/lang/String;

    return-object v0
.end method
