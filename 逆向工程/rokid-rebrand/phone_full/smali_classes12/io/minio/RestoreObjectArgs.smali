.class public Lio/minio/RestoreObjectArgs;
.super Lio/minio/ObjectVersionArgs;
.source "RestoreObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/RestoreObjectArgs$Builder;
    }
.end annotation


# instance fields
.field private request:Lio/minio/messages/RestoreRequest;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lio/minio/RestoreObjectArgs;Lio/minio/messages/RestoreRequest;)Lio/minio/messages/RestoreRequest;
    .locals 0
    .param p0, "x0"    # Lio/minio/RestoreObjectArgs;
    .param p1, "x1"    # Lio/minio/messages/RestoreRequest;

    .line 23
    iput-object p1, p0, Lio/minio/RestoreObjectArgs;->request:Lio/minio/messages/RestoreRequest;

    return-object p1
.end method

.method public static builder()Lio/minio/RestoreObjectArgs$Builder;
    .locals 1

    .line 31
    new-instance v0, Lio/minio/RestoreObjectArgs$Builder;

    invoke-direct {v0}, Lio/minio/RestoreObjectArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 55
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 56
    :cond_0
    instance-of v0, p1, Lio/minio/RestoreObjectArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 57
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectVersionArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 58
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/RestoreObjectArgs;

    .line 59
    .local v0, "that":Lio/minio/RestoreObjectArgs;
    iget-object v1, p0, Lio/minio/RestoreObjectArgs;->request:Lio/minio/messages/RestoreRequest;

    iget-object v2, v0, Lio/minio/RestoreObjectArgs;->request:Lio/minio/messages/RestoreRequest;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 2

    .line 64
    invoke-super {p0}, Lio/minio/ObjectVersionArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/RestoreObjectArgs;->request:Lio/minio/messages/RestoreRequest;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public request()Lio/minio/messages/RestoreRequest;
    .locals 1

    .line 27
    iget-object v0, p0, Lio/minio/RestoreObjectArgs;->request:Lio/minio/messages/RestoreRequest;

    return-object v0
.end method
