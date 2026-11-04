.class public Lio/minio/SetBucketPolicyArgs;
.super Lio/minio/BucketArgs;
.source "SetBucketPolicyArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/SetBucketPolicyArgs$Builder;
    }
.end annotation


# instance fields
.field private config:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lio/minio/SetBucketPolicyArgs;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lio/minio/SetBucketPolicyArgs;

    .line 25
    iget-object v0, p0, Lio/minio/SetBucketPolicyArgs;->config:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/SetBucketPolicyArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/SetBucketPolicyArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 25
    iput-object p1, p0, Lio/minio/SetBucketPolicyArgs;->config:Ljava/lang/String;

    return-object p1
.end method

.method public static builder()Lio/minio/SetBucketPolicyArgs$Builder;
    .locals 1

    .line 33
    new-instance v0, Lio/minio/SetBucketPolicyArgs$Builder;

    invoke-direct {v0}, Lio/minio/SetBucketPolicyArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public config()Ljava/lang/String;
    .locals 1

    .line 29
    iget-object v0, p0, Lio/minio/SetBucketPolicyArgs;->config:Ljava/lang/String;

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 57
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 58
    :cond_0
    instance-of v0, p1, Lio/minio/SetBucketPolicyArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 59
    :cond_1
    invoke-super {p0, p1}, Lio/minio/BucketArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 60
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/SetBucketPolicyArgs;

    .line 61
    .local v0, "that":Lio/minio/SetBucketPolicyArgs;
    iget-object v1, p0, Lio/minio/SetBucketPolicyArgs;->config:Ljava/lang/String;

    iget-object v2, v0, Lio/minio/SetBucketPolicyArgs;->config:Ljava/lang/String;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 2

    .line 66
    invoke-super {p0}, Lio/minio/BucketArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/SetBucketPolicyArgs;->config:Ljava/lang/String;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method
