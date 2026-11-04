.class public final Lio/minio/SetObjectRetentionArgs$Builder;
.super Lio/minio/ObjectVersionArgs$Builder;
.source "SetObjectRetentionArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/SetObjectRetentionArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectVersionArgs$Builder<",
        "Lio/minio/SetObjectRetentionArgs$Builder;",
        "Lio/minio/SetObjectRetentionArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 44
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$bypassGovernanceMode$1(ZLio/minio/SetObjectRetentionArgs;)V
    .locals 0
    .param p0, "bypassGovernanceMode"    # Z
    .param p1, "args"    # Lio/minio/SetObjectRetentionArgs;

    .line 62
    invoke-static {p1, p0}, Lio/minio/SetObjectRetentionArgs;->access$102(Lio/minio/SetObjectRetentionArgs;Z)Z

    return-void
.end method

.method static synthetic lambda$config$0(Lio/minio/messages/Retention;Lio/minio/SetObjectRetentionArgs;)V
    .locals 0
    .param p0, "config"    # Lio/minio/messages/Retention;
    .param p1, "args"    # Lio/minio/SetObjectRetentionArgs;

    .line 57
    invoke-static {p1, p0}, Lio/minio/SetObjectRetentionArgs;->access$002(Lio/minio/SetObjectRetentionArgs;Lio/minio/messages/Retention;)Lio/minio/messages/Retention;

    return-void
.end method

.method private validateConfig(Lio/minio/messages/Retention;)V
    .locals 1
    .param p1, "config"    # Lio/minio/messages/Retention;

    .line 47
    const-string v0, "retention configuration"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetObjectRetentionArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    return-void
.end method


# virtual methods
.method public bypassGovernanceMode(Z)Lio/minio/SetObjectRetentionArgs$Builder;
    .locals 2
    .param p1, "bypassGovernanceMode"    # Z

    .line 62
    iget-object v0, p0, Lio/minio/SetObjectRetentionArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetObjectRetentionArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/SetObjectRetentionArgs$Builder$$ExternalSyntheticLambda0;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 63
    return-object p0
.end method

.method public config(Lio/minio/messages/Retention;)Lio/minio/SetObjectRetentionArgs$Builder;
    .locals 2
    .param p1, "config"    # Lio/minio/messages/Retention;

    .line 56
    invoke-direct {p0, p1}, Lio/minio/SetObjectRetentionArgs$Builder;->validateConfig(Lio/minio/messages/Retention;)V

    .line 57
    iget-object v0, p0, Lio/minio/SetObjectRetentionArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetObjectRetentionArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/SetObjectRetentionArgs$Builder$$ExternalSyntheticLambda1;-><init>(Lio/minio/messages/Retention;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 58
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 44
    check-cast p1, Lio/minio/SetObjectRetentionArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetObjectRetentionArgs$Builder;->validate(Lio/minio/SetObjectRetentionArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 44
    check-cast p1, Lio/minio/SetObjectRetentionArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetObjectRetentionArgs$Builder;->validate(Lio/minio/SetObjectRetentionArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 44
    check-cast p1, Lio/minio/SetObjectRetentionArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetObjectRetentionArgs$Builder;->validate(Lio/minio/SetObjectRetentionArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/SetObjectRetentionArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/SetObjectRetentionArgs;

    .line 51
    invoke-super {p0, p1}, Lio/minio/ObjectVersionArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 52
    invoke-static {p1}, Lio/minio/SetObjectRetentionArgs;->access$000(Lio/minio/SetObjectRetentionArgs;)Lio/minio/messages/Retention;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SetObjectRetentionArgs$Builder;->validateConfig(Lio/minio/messages/Retention;)V

    .line 53
    return-void
.end method
