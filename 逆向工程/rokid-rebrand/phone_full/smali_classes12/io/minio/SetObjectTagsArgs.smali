.class public Lio/minio/SetObjectTagsArgs;
.super Lio/minio/ObjectVersionArgs;
.source "SetObjectTagsArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/SetObjectTagsArgs$Builder;
    }
.end annotation


# instance fields
.field private tags:Lio/minio/messages/Tags;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lio/minio/SetObjectTagsArgs;)Lio/minio/messages/Tags;
    .locals 1
    .param p0, "x0"    # Lio/minio/SetObjectTagsArgs;

    .line 26
    iget-object v0, p0, Lio/minio/SetObjectTagsArgs;->tags:Lio/minio/messages/Tags;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/SetObjectTagsArgs;Lio/minio/messages/Tags;)Lio/minio/messages/Tags;
    .locals 0
    .param p0, "x0"    # Lio/minio/SetObjectTagsArgs;
    .param p1, "x1"    # Lio/minio/messages/Tags;

    .line 26
    iput-object p1, p0, Lio/minio/SetObjectTagsArgs;->tags:Lio/minio/messages/Tags;

    return-object p1
.end method

.method public static builder()Lio/minio/SetObjectTagsArgs$Builder;
    .locals 1

    .line 34
    new-instance v0, Lio/minio/SetObjectTagsArgs$Builder;

    invoke-direct {v0}, Lio/minio/SetObjectTagsArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 63
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 64
    :cond_0
    instance-of v0, p1, Lio/minio/SetObjectTagsArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 65
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectVersionArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 66
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/SetObjectTagsArgs;

    .line 67
    .local v0, "that":Lio/minio/SetObjectTagsArgs;
    iget-object v1, p0, Lio/minio/SetObjectTagsArgs;->tags:Lio/minio/messages/Tags;

    iget-object v2, v0, Lio/minio/SetObjectTagsArgs;->tags:Lio/minio/messages/Tags;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 2

    .line 72
    invoke-super {p0}, Lio/minio/ObjectVersionArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/SetObjectTagsArgs;->tags:Lio/minio/messages/Tags;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public tags()Lio/minio/messages/Tags;
    .locals 1

    .line 30
    iget-object v0, p0, Lio/minio/SetObjectTagsArgs;->tags:Lio/minio/messages/Tags;

    return-object v0
.end method
