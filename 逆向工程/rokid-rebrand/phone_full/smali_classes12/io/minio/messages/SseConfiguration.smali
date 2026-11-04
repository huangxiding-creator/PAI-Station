.class public Lio/minio/messages/SseConfiguration;
.super Ljava/lang/Object;
.source "SseConfiguration.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Namespace;
    reference = "http://s3.amazonaws.com/doc/2006-03-01/"
.end annotation

.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ServerSideEncryptionConfiguration"
.end annotation


# instance fields
.field private rule:Lio/minio/messages/SseConfigurationRule;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Rule"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lio/minio/messages/SseConfigurationRule;)V
    .locals 0
    .param p1, "rule"    # Lio/minio/messages/SseConfigurationRule;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Rule"
            required = false
        .end annotation
    .end param

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    iput-object p1, p0, Lio/minio/messages/SseConfiguration;->rule:Lio/minio/messages/SseConfigurationRule;

    .line 42
    return-void
.end method

.method public static newConfigWithSseKmsRule(Ljava/lang/String;)Lio/minio/messages/SseConfiguration;
    .locals 3
    .param p0, "kmsMasterKeyId"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 49
    new-instance v0, Lio/minio/messages/SseConfiguration;

    new-instance v1, Lio/minio/messages/SseConfigurationRule;

    sget-object v2, Lio/minio/messages/SseAlgorithm;->AWS_KMS:Lio/minio/messages/SseAlgorithm;

    invoke-direct {v1, v2, p0}, Lio/minio/messages/SseConfigurationRule;-><init>(Lio/minio/messages/SseAlgorithm;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Lio/minio/messages/SseConfiguration;-><init>(Lio/minio/messages/SseConfigurationRule;)V

    return-object v0
.end method

.method public static newConfigWithSseS3Rule()Lio/minio/messages/SseConfiguration;
    .locals 4

    .line 45
    new-instance v0, Lio/minio/messages/SseConfiguration;

    new-instance v1, Lio/minio/messages/SseConfigurationRule;

    sget-object v2, Lio/minio/messages/SseAlgorithm;->AES256:Lio/minio/messages/SseAlgorithm;

    const/4 v3, 0x0

    invoke-direct {v1, v2, v3}, Lio/minio/messages/SseConfigurationRule;-><init>(Lio/minio/messages/SseAlgorithm;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Lio/minio/messages/SseConfiguration;-><init>(Lio/minio/messages/SseConfigurationRule;)V

    return-object v0
.end method


# virtual methods
.method public rule()Lio/minio/messages/SseConfigurationRule;
    .locals 1

    .line 53
    iget-object v0, p0, Lio/minio/messages/SseConfiguration;->rule:Lio/minio/messages/SseConfigurationRule;

    return-object v0
.end method
