.class public Lio/minio/ListObjectsArgs;
.super Lio/minio/BucketArgs;
.source "ListObjectsArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ListObjectsArgs$Builder;
    }
.end annotation


# instance fields
.field private continuationToken:Ljava/lang/String;

.field private delimiter:Ljava/lang/String;

.field private fetchOwner:Z

.field private includeUserMetadata:Z

.field private includeVersions:Z

.field private keyMarker:Ljava/lang/String;

.field private maxKeys:I

.field private prefix:Ljava/lang/String;

.field private recursive:Z

.field private useApiVersion1:Z

.field private useUrlEncodingType:Z

.field private versionIdMarker:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 22
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    .line 23
    const-string v0, ""

    iput-object v0, p0, Lio/minio/ListObjectsArgs;->delimiter:Ljava/lang/String;

    .line 24
    const/4 v1, 0x1

    iput-boolean v1, p0, Lio/minio/ListObjectsArgs;->useUrlEncodingType:Z

    .line 26
    const/16 v1, 0x3e8

    iput v1, p0, Lio/minio/ListObjectsArgs;->maxKeys:I

    .line 27
    iput-object v0, p0, Lio/minio/ListObjectsArgs;->prefix:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lio/minio/ListObjectsArgs;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;

    .line 22
    iget-object v0, p0, Lio/minio/ListObjectsArgs;->versionIdMarker:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 22
    iput-object p1, p0, Lio/minio/ListObjectsArgs;->versionIdMarker:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$1002(Lio/minio/ListObjectsArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/minio/ListObjectsArgs;->useUrlEncodingType:Z

    return p1
.end method

.method static synthetic access$102(Lio/minio/ListObjectsArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/minio/ListObjectsArgs;->includeVersions:Z

    return p1
.end method

.method static synthetic access$1102(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 22
    iput-object p1, p0, Lio/minio/ListObjectsArgs;->delimiter:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$202(Lio/minio/ListObjectsArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/minio/ListObjectsArgs;->useApiVersion1:Z

    return p1
.end method

.method static synthetic access$302(Lio/minio/ListObjectsArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/minio/ListObjectsArgs;->recursive:Z

    return p1
.end method

.method static synthetic access$402(Lio/minio/ListObjectsArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/minio/ListObjectsArgs;->includeUserMetadata:Z

    return p1
.end method

.method static synthetic access$502(Lio/minio/ListObjectsArgs;Z)Z
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Z

    .line 22
    iput-boolean p1, p0, Lio/minio/ListObjectsArgs;->fetchOwner:Z

    return p1
.end method

.method static synthetic access$602(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 22
    iput-object p1, p0, Lio/minio/ListObjectsArgs;->continuationToken:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$702(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 22
    iput-object p1, p0, Lio/minio/ListObjectsArgs;->prefix:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$802(Lio/minio/ListObjectsArgs;I)I
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # I

    .line 22
    iput p1, p0, Lio/minio/ListObjectsArgs;->maxKeys:I

    return p1
.end method

.method static synthetic access$902(Lio/minio/ListObjectsArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/ListObjectsArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 22
    iput-object p1, p0, Lio/minio/ListObjectsArgs;->keyMarker:Ljava/lang/String;

    return-object p1
.end method

.method public static builder()Lio/minio/ListObjectsArgs$Builder;
    .locals 1

    .line 97
    new-instance v0, Lio/minio/ListObjectsArgs$Builder;

    invoke-direct {v0}, Lio/minio/ListObjectsArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public continuationToken()Ljava/lang/String;
    .locals 1

    .line 69
    iget-object v0, p0, Lio/minio/ListObjectsArgs;->continuationToken:Ljava/lang/String;

    return-object v0
.end method

.method public delimiter()Ljava/lang/String;
    .locals 1

    .line 37
    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->recursive:Z

    if-eqz v0, :cond_0

    .line 38
    const-string v0, ""

    return-object v0

    .line 41
    :cond_0
    iget-object v0, p0, Lio/minio/ListObjectsArgs;->delimiter:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "/"

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lio/minio/ListObjectsArgs;->delimiter:Ljava/lang/String;

    :goto_0
    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 200
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 201
    :cond_0
    instance-of v1, p1, Lio/minio/ListObjectsArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 202
    :cond_1
    invoke-super {p0, p1}, Lio/minio/BucketArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 203
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/ListObjectsArgs;

    .line 204
    .local v1, "that":Lio/minio/ListObjectsArgs;
    iget-boolean v3, p0, Lio/minio/ListObjectsArgs;->useUrlEncodingType:Z

    iget-boolean v4, v1, Lio/minio/ListObjectsArgs;->useUrlEncodingType:Z

    if-ne v3, v4, :cond_3

    iget v3, p0, Lio/minio/ListObjectsArgs;->maxKeys:I

    iget v4, v1, Lio/minio/ListObjectsArgs;->maxKeys:I

    if-ne v3, v4, :cond_3

    iget-boolean v3, p0, Lio/minio/ListObjectsArgs;->fetchOwner:Z

    iget-boolean v4, v1, Lio/minio/ListObjectsArgs;->fetchOwner:Z

    if-ne v3, v4, :cond_3

    iget-boolean v3, p0, Lio/minio/ListObjectsArgs;->includeUserMetadata:Z

    iget-boolean v4, v1, Lio/minio/ListObjectsArgs;->includeUserMetadata:Z

    if-ne v3, v4, :cond_3

    iget-boolean v3, p0, Lio/minio/ListObjectsArgs;->recursive:Z

    iget-boolean v4, v1, Lio/minio/ListObjectsArgs;->recursive:Z

    if-ne v3, v4, :cond_3

    iget-boolean v3, p0, Lio/minio/ListObjectsArgs;->useApiVersion1:Z

    iget-boolean v4, v1, Lio/minio/ListObjectsArgs;->useApiVersion1:Z

    if-ne v3, v4, :cond_3

    iget-boolean v3, p0, Lio/minio/ListObjectsArgs;->includeVersions:Z

    iget-boolean v4, v1, Lio/minio/ListObjectsArgs;->includeVersions:Z

    if-ne v3, v4, :cond_3

    iget-object v3, p0, Lio/minio/ListObjectsArgs;->delimiter:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ListObjectsArgs;->delimiter:Ljava/lang/String;

    .line 211
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ListObjectsArgs;->keyMarker:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ListObjectsArgs;->keyMarker:Ljava/lang/String;

    .line 212
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ListObjectsArgs;->prefix:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ListObjectsArgs;->prefix:Ljava/lang/String;

    .line 213
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ListObjectsArgs;->continuationToken:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ListObjectsArgs;->continuationToken:Ljava/lang/String;

    .line 214
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/ListObjectsArgs;->versionIdMarker:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/ListObjectsArgs;->versionIdMarker:Ljava/lang/String;

    .line 215
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    .line 204
    :goto_0
    return v0
.end method

.method public fetchOwner()Z
    .locals 1

    .line 73
    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->fetchOwner:Z

    return v0
.end method

.method public hashCode()I
    .locals 14

    .line 220
    nop

    .line 221
    invoke-super {p0}, Lio/minio/BucketArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget-object v2, p0, Lio/minio/ListObjectsArgs;->delimiter:Ljava/lang/String;

    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->useUrlEncodingType:Z

    .line 223
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    iget-object v4, p0, Lio/minio/ListObjectsArgs;->keyMarker:Ljava/lang/String;

    iget v0, p0, Lio/minio/ListObjectsArgs;->maxKeys:I

    .line 225
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    iget-object v6, p0, Lio/minio/ListObjectsArgs;->prefix:Ljava/lang/String;

    iget-object v7, p0, Lio/minio/ListObjectsArgs;->continuationToken:Ljava/lang/String;

    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->fetchOwner:Z

    .line 228
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v8

    iget-object v9, p0, Lio/minio/ListObjectsArgs;->versionIdMarker:Ljava/lang/String;

    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->includeUserMetadata:Z

    .line 230
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v10

    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->recursive:Z

    .line 231
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v11

    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->useApiVersion1:Z

    .line 232
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v12

    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->includeVersions:Z

    .line 233
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v13

    filled-new-array/range {v1 .. v13}, [Ljava/lang/Object;

    move-result-object v0

    .line 220
    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public includeUserMetadata()Z
    .locals 1

    .line 81
    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->includeUserMetadata:Z

    return v0
.end method

.method public includeVersions()Z
    .locals 1

    .line 93
    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->includeVersions:Z

    return v0
.end method

.method public keyMarker()Ljava/lang/String;
    .locals 1

    .line 49
    iget-object v0, p0, Lio/minio/ListObjectsArgs;->keyMarker:Ljava/lang/String;

    return-object v0
.end method

.method public marker()Ljava/lang/String;
    .locals 1

    .line 53
    iget-object v0, p0, Lio/minio/ListObjectsArgs;->keyMarker:Ljava/lang/String;

    return-object v0
.end method

.method public maxKeys()I
    .locals 1

    .line 61
    iget v0, p0, Lio/minio/ListObjectsArgs;->maxKeys:I

    return v0
.end method

.method public prefix()Ljava/lang/String;
    .locals 1

    .line 65
    iget-object v0, p0, Lio/minio/ListObjectsArgs;->prefix:Ljava/lang/String;

    return-object v0
.end method

.method public recursive()Z
    .locals 1

    .line 85
    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->recursive:Z

    return v0
.end method

.method public startAfter()Ljava/lang/String;
    .locals 1

    .line 57
    iget-object v0, p0, Lio/minio/ListObjectsArgs;->keyMarker:Ljava/lang/String;

    return-object v0
.end method

.method public useApiVersion1()Z
    .locals 1

    .line 89
    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->useApiVersion1:Z

    return v0
.end method

.method public useUrlEncodingType()Z
    .locals 1

    .line 45
    iget-boolean v0, p0, Lio/minio/ListObjectsArgs;->useUrlEncodingType:Z

    return v0
.end method

.method public versionIdMarker()Ljava/lang/String;
    .locals 1

    .line 77
    iget-object v0, p0, Lio/minio/ListObjectsArgs;->versionIdMarker:Ljava/lang/String;

    return-object v0
.end method
