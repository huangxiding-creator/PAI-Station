.class public Lio/minio/GetPresignedObjectUrlArgs;
.super Lio/minio/ObjectVersionArgs;
.source "GetPresignedObjectUrlArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/GetPresignedObjectUrlArgs$Builder;
    }
.end annotation


# static fields
.field public static final DEFAULT_EXPIRY_TIME:I


# instance fields
.field private expiry:I

.field private method:Lio/minio/http/Method;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 29
    sget-object v0, Ljava/util/concurrent/TimeUnit;->DAYS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v1, 0x7

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toSeconds(J)J

    move-result-wide v0

    long-to-int v0, v0

    sput v0, Lio/minio/GetPresignedObjectUrlArgs;->DEFAULT_EXPIRY_TIME:I

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 27
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs;-><init>()V

    .line 32
    sget v0, Lio/minio/GetPresignedObjectUrlArgs;->DEFAULT_EXPIRY_TIME:I

    iput v0, p0, Lio/minio/GetPresignedObjectUrlArgs;->expiry:I

    return-void
.end method

.method static synthetic access$000(Lio/minio/GetPresignedObjectUrlArgs;)Lio/minio/http/Method;
    .locals 1
    .param p0, "x0"    # Lio/minio/GetPresignedObjectUrlArgs;

    .line 27
    iget-object v0, p0, Lio/minio/GetPresignedObjectUrlArgs;->method:Lio/minio/http/Method;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/GetPresignedObjectUrlArgs;Lio/minio/http/Method;)Lio/minio/http/Method;
    .locals 0
    .param p0, "x0"    # Lio/minio/GetPresignedObjectUrlArgs;
    .param p1, "x1"    # Lio/minio/http/Method;

    .line 27
    iput-object p1, p0, Lio/minio/GetPresignedObjectUrlArgs;->method:Lio/minio/http/Method;

    return-object p1
.end method

.method static synthetic access$102(Lio/minio/GetPresignedObjectUrlArgs;I)I
    .locals 0
    .param p0, "x0"    # Lio/minio/GetPresignedObjectUrlArgs;
    .param p1, "x1"    # I

    .line 27
    iput p1, p0, Lio/minio/GetPresignedObjectUrlArgs;->expiry:I

    return p1
.end method

.method public static builder()Lio/minio/GetPresignedObjectUrlArgs$Builder;
    .locals 1

    .line 43
    new-instance v0, Lio/minio/GetPresignedObjectUrlArgs$Builder;

    invoke-direct {v0}, Lio/minio/GetPresignedObjectUrlArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 89
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 90
    :cond_0
    instance-of v1, p1, Lio/minio/GetPresignedObjectUrlArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 91
    :cond_1
    invoke-super {p0, p1}, Lio/minio/ObjectVersionArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 92
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/GetPresignedObjectUrlArgs;

    .line 93
    .local v1, "that":Lio/minio/GetPresignedObjectUrlArgs;
    iget v3, p0, Lio/minio/GetPresignedObjectUrlArgs;->expiry:I

    iget v4, v1, Lio/minio/GetPresignedObjectUrlArgs;->expiry:I

    if-ne v3, v4, :cond_3

    iget-object v3, p0, Lio/minio/GetPresignedObjectUrlArgs;->method:Lio/minio/http/Method;

    iget-object v4, v1, Lio/minio/GetPresignedObjectUrlArgs;->method:Lio/minio/http/Method;

    if-ne v3, v4, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    :goto_0
    return v0
.end method

.method public expiry()I
    .locals 1

    .line 39
    iget v0, p0, Lio/minio/GetPresignedObjectUrlArgs;->expiry:I

    return v0
.end method

.method public hashCode()I
    .locals 3

    .line 98
    invoke-super {p0}, Lio/minio/ObjectVersionArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/GetPresignedObjectUrlArgs;->method:Lio/minio/http/Method;

    iget v2, p0, Lio/minio/GetPresignedObjectUrlArgs;->expiry:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public method()Lio/minio/http/Method;
    .locals 1

    .line 35
    iget-object v0, p0, Lio/minio/GetPresignedObjectUrlArgs;->method:Lio/minio/http/Method;

    return-object v0
.end method
