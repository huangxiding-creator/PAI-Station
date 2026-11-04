.class public Lio/minio/messages/SseConfigurationRule;
.super Ljava/lang/Object;
.source "SseConfigurationRule.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Rule"
.end annotation


# instance fields
.field private kmsMasterKeyId:Ljava/lang/String;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "KMSMasterKeyID"
        required = false
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/Path;
        value = "ApplyServerSideEncryptionByDefault"
    .end annotation
.end field

.field private sseAlgorithm:Lio/minio/messages/SseAlgorithm;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "SSEAlgorithm"
    .end annotation

    .annotation runtime Lorg/simpleframework/xml/Path;
        value = "ApplyServerSideEncryptionByDefault"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/SseAlgorithm;Ljava/lang/String;)V
    .locals 1
    .param p1, "sseAlgorithm"    # Lio/minio/messages/SseAlgorithm;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "SSEAlgorithm"
        .end annotation
    .end param
    .param p2, "kmsMasterKeyId"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "KMSMasterKeyID"
            required = false
        .end annotation
    .end param

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    const-string v0, "SSE Algorithm must be provided"

    invoke-static {p1, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/SseAlgorithm;

    iput-object v0, p0, Lio/minio/messages/SseConfigurationRule;->sseAlgorithm:Lio/minio/messages/SseAlgorithm;

    .line 47
    iput-object p2, p0, Lio/minio/messages/SseConfigurationRule;->kmsMasterKeyId:Ljava/lang/String;

    .line 48
    return-void
.end method


# virtual methods
.method public kmsMasterKeyId()Ljava/lang/String;
    .locals 1

    .line 51
    iget-object v0, p0, Lio/minio/messages/SseConfigurationRule;->kmsMasterKeyId:Ljava/lang/String;

    return-object v0
.end method

.method public sseAlgorithm()Lio/minio/messages/SseAlgorithm;
    .locals 1

    .line 55
    iget-object v0, p0, Lio/minio/messages/SseConfigurationRule;->sseAlgorithm:Lio/minio/messages/SseAlgorithm;

    return-object v0
.end method
