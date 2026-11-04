.class public abstract Lio/minio/ObjectVersionArgs;
.super Lio/minio/ObjectArgs;
.source "ObjectVersionArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ObjectVersionArgs$Builder;
    }
.end annotation


# instance fields
.field protected versionId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Lio/minio/ObjectArgs;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 41
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 42
    :cond_0
    instance-of v0, p1, Lio/minio/ObjectVersionArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 43
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 44
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/ObjectVersionArgs;

    .line 45
    .local v0, "that":Lio/minio/ObjectVersionArgs;
    iget-object v1, p0, Lio/minio/ObjectVersionArgs;->versionId:Ljava/lang/String;

    iget-object v2, v0, Lio/minio/ObjectVersionArgs;->versionId:Ljava/lang/String;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 2

    .line 50
    invoke-super {p0}, Lio/minio/ObjectArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/ObjectVersionArgs;->versionId:Ljava/lang/String;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public versionId()Ljava/lang/String;
    .locals 1

    .line 26
    iget-object v0, p0, Lio/minio/ObjectVersionArgs;->versionId:Ljava/lang/String;

    return-object v0
.end method
