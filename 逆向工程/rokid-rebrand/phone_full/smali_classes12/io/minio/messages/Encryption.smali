.class public Lio/minio/messages/Encryption;
.super Ljava/lang/Object;
.source "Encryption.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Encryption"
.end annotation


# instance fields
.field private encryptionType:Lio/minio/messages/SseAlgorithm;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "EncryptionType"
    .end annotation
.end field

.field private kmsContext:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "KMSContext"
        required = false
    .end annotation
.end field

.field private kmsKeyId:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "KMSKeyId"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/SseAlgorithm;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "encryptionType"    # Lio/minio/messages/SseAlgorithm;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "kmsContext"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param
    .param p3, "kmsKeyId"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    nop

    .line 45
    const-string v0, "Encryption type must not be null"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/SseAlgorithm;

    iput-object v0, p0, Lio/minio/messages/Encryption;->encryptionType:Lio/minio/messages/SseAlgorithm;

    .line 46
    iput-object p2, p0, Lio/minio/messages/Encryption;->kmsContext:Ljava/lang/String;

    .line 47
    iput-object p3, p0, Lio/minio/messages/Encryption;->kmsKeyId:Ljava/lang/String;

    .line 48
    return-void
.end method
