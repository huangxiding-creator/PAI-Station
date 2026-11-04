.class public Lio/minio/SetObjectRetentionArgs;
.super Lio/minio/ObjectVersionArgs;
.source "SetObjectRetentionArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/SetObjectRetentionArgs$Builder;
    }
.end annotation


# instance fields
.field private bypassGovernanceMode:Z

.field private config:Lio/minio/messages/Retention;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lio/minio/SetObjectRetentionArgs;)Lio/minio/messages/Retention;
    .locals 1
    .param p0, "x0"    # Lio/minio/SetObjectRetentionArgs;

    .line 27
    iget-object v0, p0, Lio/minio/SetObjectRetentionArgs;->config:Lio/minio/messages/Retention;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/SetObjectRetentionArgs;Lio/minio/messages/Retention;)Lio/minio/messages/Retention;
    .locals 0
    .param p0, "x0"    # Lio/minio/SetObjectRetentionArgs;
    .param p1, "x1"    # Lio/minio/messages/Retention;

    .line 27
    iput-object p1, p0, Lio/minio/SetObjectRetentionArgs;->config:Lio/minio/messages/Retention;

    return-object p1
.end method

.method static synthetic access$102(Lio/minio/SetObjectRetentionArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/SetObjectRetentionArgs;
    .param p1, "x1"    # Z

    .line 27
    iput-boolean p1, p0, Lio/minio/SetObjectRetentionArgs;->bypassGovernanceMode:Z

    return p1
.end method

.method public static builder()Lio/minio/SetObjectRetentionArgs$Builder;
    .locals 1

    .line 40
    new-instance v0, Lio/minio/SetObjectRetentionArgs$Builder;

    invoke-direct {v0}, Lio/minio/SetObjectRetentionArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public bypassGovernanceMode()Z
    .locals 1

    .line 36
    iget-boolean v0, p0, Lio/minio/SetObjectRetentionArgs;->bypassGovernanceMode:Z

    return v0
.end method

.method public config()Lio/minio/messages/Retention;
    .locals 1

    .line 32
    iget-object v0, p0, Lio/minio/SetObjectRetentionArgs;->config:Lio/minio/messages/Retention;

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 69
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 70
    :cond_0
    instance-of v1, p1, Lio/minio/SetObjectRetentionArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 71
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectVersionArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 72
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/SetObjectRetentionArgs;

    .line 73
    .local v1, "that":Lio/minio/SetObjectRetentionArgs;
    iget-boolean v3, p0, Lio/minio/SetObjectRetentionArgs;->bypassGovernanceMode:Z

    iget-boolean v4, v1, Lio/minio/SetObjectRetentionArgs;->bypassGovernanceMode:Z

    if-ne v3, v4, :cond_3

    iget-object v3, p0, Lio/minio/SetObjectRetentionArgs;->config:Lio/minio/messages/Retention;

    iget-object v4, v1, Lio/minio/SetObjectRetentionArgs;->config:Lio/minio/messages/Retention;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 3

    .line 78
    invoke-super {p0}, Lio/minio/ObjectVersionArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/SetObjectRetentionArgs;->config:Lio/minio/messages/Retention;

    iget-boolean v2, p0, Lio/minio/SetObjectRetentionArgs;->bypassGovernanceMode:Z

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method
