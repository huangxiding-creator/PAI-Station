.class public final Lio/minio/SetObjectLockConfigurationArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "SetObjectLockConfigurationArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/SetObjectLockConfigurationArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/SetObjectLockConfigurationArgs$Builder;",
        "Lio/minio/SetObjectLockConfigurationArgs;",
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

.method static synthetic lambda$config$0(Lio/minio/messages/ObjectLockConfiguration;Lio/minio/SetObjectLockConfigurationArgs;)V
    .locals 0
    .param p0, "config"    # Lio/minio/messages/ObjectLockConfiguration;
    .param p1, "args"    # Lio/minio/SetObjectLockConfigurationArgs;

    .line 53
    invoke-static {p1, p0}, Lio/minio/SetObjectLockConfigurationArgs;->access$002(Lio/minio/SetObjectLockConfigurationArgs;Lio/minio/messages/ObjectLockConfiguration;)Lio/minio/messages/ObjectLockConfiguration;

    return-void
.end method

.method private validateConfig(Lio/minio/messages/ObjectLockConfiguration;)V
    .locals 1
    .param p1, "config"    # Lio/minio/messages/ObjectLockConfiguration;

    .line 42
    const-string v0, "object-lock configuration"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetObjectLockConfigurationArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    return-void
.end method


# virtual methods
.method public config(Lio/minio/messages/ObjectLockConfiguration;)Lio/minio/SetObjectLockConfigurationArgs$Builder;
    .locals 2
    .param p1, "config"    # Lio/minio/messages/ObjectLockConfiguration;

    .line 52
    invoke-direct {p0, p1}, Lio/minio/SetObjectLockConfigurationArgs$Builder;->validateConfig(Lio/minio/messages/ObjectLockConfiguration;)V

    .line 53
    iget-object v0, p0, Lio/minio/SetObjectLockConfigurationArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetObjectLockConfigurationArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/SetObjectLockConfigurationArgs$Builder$$ExternalSyntheticLambda0;-><init>(Lio/minio/messages/ObjectLockConfiguration;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 54
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 39
    check-cast p1, Lio/minio/SetObjectLockConfigurationArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetObjectLockConfigurationArgs$Builder;->validate(Lio/minio/SetObjectLockConfigurationArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 39
    check-cast p1, Lio/minio/SetObjectLockConfigurationArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetObjectLockConfigurationArgs$Builder;->validate(Lio/minio/SetObjectLockConfigurationArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/SetObjectLockConfigurationArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/SetObjectLockConfigurationArgs;

    .line 47
    invoke-super {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    .line 48
    invoke-static {p1}, Lio/minio/SetObjectLockConfigurationArgs;->access$000(Lio/minio/SetObjectLockConfigurationArgs;)Lio/minio/messages/ObjectLockConfiguration;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SetObjectLockConfigurationArgs$Builder;->validateConfig(Lio/minio/messages/ObjectLockConfiguration;)V

    .line 49
    return-void
.end method
