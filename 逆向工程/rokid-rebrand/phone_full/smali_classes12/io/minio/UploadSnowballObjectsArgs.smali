.class public Lio/minio/UploadSnowballObjectsArgs;
.super Lio/minio/ObjectWriteArgs;
.source "UploadSnowballObjectsArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/UploadSnowballObjectsArgs$Builder;
    }
.end annotation


# static fields
.field private static final random:Ljava/util/Random;


# instance fields
.field private compression:Z

.field private objects:Ljava/lang/Iterable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Iterable<",
            "Lio/minio/SnowballObject;",
            ">;"
        }
    .end annotation
.end field

.field private stagingFilename:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 28
    new-instance v0, Ljava/util/Random;

    new-instance v1, Ljava/security/SecureRandom;

    invoke-direct {v1}, Ljava/security/SecureRandom;-><init>()V

    invoke-virtual {v1}, Ljava/security/SecureRandom;->nextLong()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Ljava/util/Random;-><init>(J)V

    sput-object v0, Lio/minio/UploadSnowballObjectsArgs;->random:Ljava/util/Random;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs;-><init>()V

    return-void
.end method

.method static synthetic access$000()Ljava/util/Random;
    .locals 1

    .line 27
    sget-object v0, Lio/minio/UploadSnowballObjectsArgs;->random:Ljava/util/Random;

    return-object v0
.end method

.method static synthetic access$100(Lio/minio/UploadSnowballObjectsArgs;)Ljava/lang/Iterable;
    .locals 1
    .param p0, "x0"    # Lio/minio/UploadSnowballObjectsArgs;

    .line 27
    iget-object v0, p0, Lio/minio/UploadSnowballObjectsArgs;->objects:Ljava/lang/Iterable;

    return-object v0
.end method

.method static synthetic access$102(Lio/minio/UploadSnowballObjectsArgs;Ljava/lang/Iterable;)Ljava/lang/Iterable;
    .locals 0
    .param p0, "x0"    # Lio/minio/UploadSnowballObjectsArgs;
    .param p1, "x1"    # Ljava/lang/Iterable;

    .line 27
    iput-object p1, p0, Lio/minio/UploadSnowballObjectsArgs;->objects:Ljava/lang/Iterable;

    return-object p1
.end method

.method static synthetic access$202(Lio/minio/UploadSnowballObjectsArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/UploadSnowballObjectsArgs;
    .param p1, "x1"    # Z

    .line 27
    iput-boolean p1, p0, Lio/minio/UploadSnowballObjectsArgs;->compression:Z

    return p1
.end method

.method static synthetic access$302(Lio/minio/UploadSnowballObjectsArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/UploadSnowballObjectsArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 27
    iput-object p1, p0, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename:Ljava/lang/String;

    return-object p1
.end method

.method public static builder()Lio/minio/UploadSnowballObjectsArgs$Builder;
    .locals 1

    .line 47
    new-instance v0, Lio/minio/UploadSnowballObjectsArgs$Builder;

    invoke-direct {v0}, Lio/minio/UploadSnowballObjectsArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public compression()Z
    .locals 1

    .line 43
    iget-boolean v0, p0, Lio/minio/UploadSnowballObjectsArgs;->compression:Z

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 86
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 87
    :cond_0
    instance-of v1, p1, Lio/minio/UploadSnowballObjectsArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 88
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectWriteArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 89
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/UploadSnowballObjectsArgs;

    .line 90
    .local v1, "that":Lio/minio/UploadSnowballObjectsArgs;
    iget-object v3, p0, Lio/minio/UploadSnowballObjectsArgs;->objects:Ljava/lang/Iterable;

    iget-object v4, v1, Lio/minio/UploadSnowballObjectsArgs;->objects:Ljava/lang/Iterable;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename:Ljava/lang/String;

    .line 91
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-boolean v3, p0, Lio/minio/UploadSnowballObjectsArgs;->compression:Z

    iget-boolean v4, v1, Lio/minio/UploadSnowballObjectsArgs;->compression:Z

    if-ne v3, v4, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    .line 90
    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 4

    .line 97
    invoke-super {p0}, Lio/minio/ObjectWriteArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/UploadSnowballObjectsArgs;->objects:Ljava/lang/Iterable;

    iget-object v2, p0, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename:Ljava/lang/String;

    iget-boolean v3, p0, Lio/minio/UploadSnowballObjectsArgs;->compression:Z

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    filled-new-array {v0, v1, v2, v3}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public objects()Ljava/lang/Iterable;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Iterable<",
            "Lio/minio/SnowballObject;",
            ">;"
        }
    .end annotation

    .line 35
    iget-object v0, p0, Lio/minio/UploadSnowballObjectsArgs;->objects:Ljava/lang/Iterable;

    return-object v0
.end method

.method public stagingFilename()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lio/minio/UploadSnowballObjectsArgs;->stagingFilename:Ljava/lang/String;

    return-object v0
.end method
