.class public Lio/minio/ListenBucketNotificationArgs;
.super Lio/minio/BucketArgs;
.source "ListenBucketNotificationArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ListenBucketNotificationArgs$Builder;
    }
.end annotation


# instance fields
.field private events:[Ljava/lang/String;

.field private prefix:Ljava/lang/String;

.field private suffix:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 26
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    .line 29
    const/4 v0, 0x0

    iput-object v0, p0, Lio/minio/ListenBucketNotificationArgs;->events:[Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lio/minio/ListenBucketNotificationArgs;)[Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lio/minio/ListenBucketNotificationArgs;

    .line 26
    iget-object v0, p0, Lio/minio/ListenBucketNotificationArgs;->events:[Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/ListenBucketNotificationArgs;[Ljava/lang/String;)[Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/ListenBucketNotificationArgs;
    .param p1, "x1"    # [Ljava/lang/String;

    .line 26
    iput-object p1, p0, Lio/minio/ListenBucketNotificationArgs;->events:[Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$102(Lio/minio/ListenBucketNotificationArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/ListenBucketNotificationArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 26
    iput-object p1, p0, Lio/minio/ListenBucketNotificationArgs;->suffix:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$202(Lio/minio/ListenBucketNotificationArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/ListenBucketNotificationArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 26
    iput-object p1, p0, Lio/minio/ListenBucketNotificationArgs;->prefix:Ljava/lang/String;

    return-object p1
.end method

.method public static builder()Lio/minio/ListenBucketNotificationArgs$Builder;
    .locals 1

    .line 44
    new-instance v0, Lio/minio/ListenBucketNotificationArgs$Builder;

    invoke-direct {v0}, Lio/minio/ListenBucketNotificationArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 81
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 82
    :cond_0
    instance-of v1, p1, Lio/minio/ListenBucketNotificationArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 83
    :cond_1
    invoke-super {p0, p1}, Lio/minio/BucketArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 84
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/ListenBucketNotificationArgs;

    .line 85
    .local v1, "that":Lio/minio/ListenBucketNotificationArgs;
    iget-object v3, p0, Lio/minio/ListenBucketNotificationArgs;->prefix:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ListenBucketNotificationArgs;->prefix:Ljava/lang/String;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ListenBucketNotificationArgs;->suffix:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ListenBucketNotificationArgs;->suffix:Ljava/lang/String;

    .line 86
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ListenBucketNotificationArgs;->events:[Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ListenBucketNotificationArgs;->events:[Ljava/lang/String;

    .line 87
    invoke-static {v3, v4}, Ljava/util/Arrays;->equals([Ljava/lang/Object;[Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    .line 85
    :goto_0
    return v0
.end method

.method public events()[Ljava/lang/String;
    .locals 2

    .line 40
    iget-object v0, p0, Lio/minio/ListenBucketNotificationArgs;->events:[Ljava/lang/String;

    iget-object v1, p0, Lio/minio/ListenBucketNotificationArgs;->events:[Ljava/lang/String;

    array-length v1, v1

    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 92
    invoke-super {p0}, Lio/minio/BucketArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/ListenBucketNotificationArgs;->prefix:Ljava/lang/String;

    iget-object v2, p0, Lio/minio/ListenBucketNotificationArgs;->suffix:Ljava/lang/String;

    iget-object v3, p0, Lio/minio/ListenBucketNotificationArgs;->events:[Ljava/lang/String;

    filled-new-array {v0, v1, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public prefix()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lio/minio/ListenBucketNotificationArgs;->prefix:Ljava/lang/String;

    return-object v0
.end method

.method public suffix()Ljava/lang/String;
    .locals 1

    .line 36
    iget-object v0, p0, Lio/minio/ListenBucketNotificationArgs;->suffix:Ljava/lang/String;

    return-object v0
.end method
