.class public Lio/minio/messages/S3OutputLocation;
.super Ljava/lang/Object;
.source "S3OutputLocation.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "S3OutputLocation"
.end annotation


# instance fields
.field private accessControlList:Lio/minio/messages/AccessControlList;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "AccessControlList"
        required = false
    .end annotation
.end field

.field private bucketName:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "BucketName"
    .end annotation
.end field

.field private cannedAcl:Lio/minio/messages/CannedAcl;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "CannedACL"
        required = false
    .end annotation
.end field

.field private encryption:Lio/minio/messages/Encryption;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Encryption"
        required = false
    .end annotation
.end field

.field private prefix:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Prefix"
    .end annotation
.end field

.field private storageClass:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "StorageClass"
        required = false
    .end annotation
.end field

.field private tagging:Lio/minio/messages/Tags;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Tagging"
        required = false
    .end annotation
.end field

.field private userMetadata:Lio/minio/messages/UserMetadata;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "UserMetadata"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Lio/minio/messages/AccessControlList;Lio/minio/messages/CannedAcl;Lio/minio/messages/Encryption;Ljava/lang/String;Lio/minio/messages/Tags;Lio/minio/messages/UserMetadata;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "prefix"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "accessControlList"    # Lio/minio/messages/AccessControlList;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p4, "cannedAcl"    # Lio/minio/messages/CannedAcl;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p5, "encryption"    # Lio/minio/messages/Encryption;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p6, "storageClass"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p7, "tagging"    # Lio/minio/messages/Tags;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p8, "userMetadata"    # Lio/minio/messages/UserMetadata;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 64
    const-string v0, "Bucket name must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/messages/S3OutputLocation;->bucketName:Ljava/lang/String;

    .line 65
    const-string v0, "Prefix must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iput-object v0, p0, Lio/minio/messages/S3OutputLocation;->prefix:Ljava/lang/String;

    .line 66
    iput-object p3, p0, Lio/minio/messages/S3OutputLocation;->accessControlList:Lio/minio/messages/AccessControlList;

    .line 67
    iput-object p4, p0, Lio/minio/messages/S3OutputLocation;->cannedAcl:Lio/minio/messages/CannedAcl;

    .line 68
    iput-object p5, p0, Lio/minio/messages/S3OutputLocation;->encryption:Lio/minio/messages/Encryption;

    .line 69
    iput-object p6, p0, Lio/minio/messages/S3OutputLocation;->storageClass:Ljava/lang/String;

    .line 70
    iput-object p7, p0, Lio/minio/messages/S3OutputLocation;->tagging:Lio/minio/messages/Tags;

    .line 71
    iput-object p8, p0, Lio/minio/messages/S3OutputLocation;->userMetadata:Lio/minio/messages/UserMetadata;

    .line 72
    return-void
.end method
