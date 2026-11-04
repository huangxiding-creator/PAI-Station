.class public final Lio/minio/SetBucketEncryptionArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "SetBucketEncryptionArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/SetBucketEncryptionArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/SetBucketEncryptionArgs$Builder;",
        "Lio/minio/SetBucketEncryptionArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 39
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$config$0(Lio/minio/messages/SseConfiguration;Lio/minio/SetBucketEncryptionArgs;)V
    .locals 0
    .param p0, "config"    # Lio/minio/messages/SseConfiguration;
    .param p1, "args"    # Lio/minio/SetBucketEncryptionArgs;

    .line 51
    invoke-static {p1, p0}, Lio/minio/SetBucketEncryptionArgs;->access$002(Lio/minio/SetBucketEncryptionArgs;Lio/minio/messages/SseConfiguration;)Lio/minio/messages/SseConfiguration;

    return-void
.end method

.method private validateConfig(Lio/minio/messages/SseConfiguration;)V
    .locals 1
    .param p1, "config"    # Lio/minio/messages/SseConfiguration;

    .line 41
    const-string v0, "encryption configuration"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetBucketEncryptionArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    return-void
.end method


# virtual methods
.method public config(Lio/minio/messages/SseConfiguration;)Lio/minio/SetBucketEncryptionArgs$Builder;
    .locals 2
    .param p1, "config"    # Lio/minio/messages/SseConfiguration;

    .line 50
    invoke-direct {p0, p1}, Lio/minio/SetBucketEncryptionArgs$Builder;->validateConfig(Lio/minio/messages/SseConfiguration;)V

    .line 51
    iget-object v0, p0, Lio/minio/SetBucketEncryptionArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetBucketEncryptionArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/SetBucketEncryptionArgs$Builder$$ExternalSyntheticLambda0;-><init>(Lio/minio/messages/SseConfiguration;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 52
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 39
    check-cast p1, Lio/minio/SetBucketEncryptionArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketEncryptionArgs$Builder;->validate(Lio/minio/SetBucketEncryptionArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 39
    check-cast p1, Lio/minio/SetBucketEncryptionArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketEncryptionArgs$Builder;->validate(Lio/minio/SetBucketEncryptionArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/SetBucketEncryptionArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/SetBucketEncryptionArgs;

    .line 45
    invoke-super {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    .line 46
    invoke-static {p1}, Lio/minio/SetBucketEncryptionArgs;->access$000(Lio/minio/SetBucketEncryptionArgs;)Lio/minio/messages/SseConfiguration;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SetBucketEncryptionArgs$Builder;->validateConfig(Lio/minio/messages/SseConfiguration;)V

    .line 47
    return-void
.end method
