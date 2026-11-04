.class public final Lio/minio/GetPresignedObjectUrlArgs$Builder;
.super Lio/minio/ObjectVersionArgs$Builder;
.source "GetPresignedObjectUrlArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/GetPresignedObjectUrlArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectVersionArgs$Builder<",
        "Lio/minio/GetPresignedObjectUrlArgs$Builder;",
        "Lio/minio/GetPresignedObjectUrlArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 47
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$expiry$1(ILio/minio/GetPresignedObjectUrlArgs;)V
    .locals 0
    .param p0, "expiry"    # I
    .param p1, "args"    # Lio/minio/GetPresignedObjectUrlArgs;

    .line 72
    invoke-static {p1, p0}, Lio/minio/GetPresignedObjectUrlArgs;->access$102(Lio/minio/GetPresignedObjectUrlArgs;I)I

    return-void
.end method

.method static synthetic lambda$method$0(Lio/minio/http/Method;Lio/minio/GetPresignedObjectUrlArgs;)V
    .locals 0
    .param p0, "method"    # Lio/minio/http/Method;
    .param p1, "args"    # Lio/minio/GetPresignedObjectUrlArgs;

    .line 65
    invoke-static {p1, p0}, Lio/minio/GetPresignedObjectUrlArgs;->access$002(Lio/minio/GetPresignedObjectUrlArgs;Lio/minio/http/Method;)Lio/minio/http/Method;

    return-void
.end method

.method private validateExpiry(I)V
    .locals 5
    .param p1, "expiry"    # I

    .line 54
    const/4 v0, 0x1

    if-lt p1, v0, :cond_0

    sget v0, Lio/minio/GetPresignedObjectUrlArgs;->DEFAULT_EXPIRY_TIME:I

    if-gt p1, v0, :cond_0

    .line 60
    return-void

    .line 55
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "expiry must be minimum 1 second to maximum "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    sget v3, Lio/minio/GetPresignedObjectUrlArgs;->DEFAULT_EXPIRY_TIME:I

    int-to-long v3, v3

    .line 57
    invoke-virtual {v2, v3, v4}, Ljava/util/concurrent/TimeUnit;->toDays(J)J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " days"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private validateMethod(Lio/minio/http/Method;)V
    .locals 1
    .param p1, "method"    # Lio/minio/http/Method;

    .line 50
    const-string v0, "method"

    invoke-virtual {p0, p1, v0}, Lio/minio/GetPresignedObjectUrlArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    return-void
.end method


# virtual methods
.method public expiry(I)Lio/minio/GetPresignedObjectUrlArgs$Builder;
    .locals 2
    .param p1, "expiry"    # I

    .line 71
    invoke-direct {p0, p1}, Lio/minio/GetPresignedObjectUrlArgs$Builder;->validateExpiry(I)V

    .line 72
    iget-object v0, p0, Lio/minio/GetPresignedObjectUrlArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/GetPresignedObjectUrlArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/GetPresignedObjectUrlArgs$Builder$$ExternalSyntheticLambda0;-><init>(I)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 73
    return-object p0
.end method

.method public expiry(ILjava/util/concurrent/TimeUnit;)Lio/minio/GetPresignedObjectUrlArgs$Builder;
    .locals 2
    .param p1, "duration"    # I
    .param p2, "unit"    # Ljava/util/concurrent/TimeUnit;

    .line 77
    int-to-long v0, p1

    invoke-virtual {p2, v0, v1}, Ljava/util/concurrent/TimeUnit;->toSeconds(J)J

    move-result-wide v0

    long-to-int v0, v0

    invoke-virtual {p0, v0}, Lio/minio/GetPresignedObjectUrlArgs$Builder;->expiry(I)Lio/minio/GetPresignedObjectUrlArgs$Builder;

    move-result-object v0

    return-object v0
.end method

.method public method(Lio/minio/http/Method;)Lio/minio/GetPresignedObjectUrlArgs$Builder;
    .locals 2
    .param p1, "method"    # Lio/minio/http/Method;

    .line 64
    invoke-direct {p0, p1}, Lio/minio/GetPresignedObjectUrlArgs$Builder;->validateMethod(Lio/minio/http/Method;)V

    .line 65
    iget-object v0, p0, Lio/minio/GetPresignedObjectUrlArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/GetPresignedObjectUrlArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/GetPresignedObjectUrlArgs$Builder$$ExternalSyntheticLambda1;-><init>(Lio/minio/http/Method;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 66
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 47
    check-cast p1, Lio/minio/GetPresignedObjectUrlArgs;

    invoke-virtual {p0, p1}, Lio/minio/GetPresignedObjectUrlArgs$Builder;->validate(Lio/minio/GetPresignedObjectUrlArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 47
    check-cast p1, Lio/minio/GetPresignedObjectUrlArgs;

    invoke-virtual {p0, p1}, Lio/minio/GetPresignedObjectUrlArgs$Builder;->validate(Lio/minio/GetPresignedObjectUrlArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/GetPresignedObjectUrlArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/GetPresignedObjectUrlArgs;

    .line 82
    invoke-super {p0, p1}, Lio/minio/ObjectVersionArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 83
    invoke-static {p1}, Lio/minio/GetPresignedObjectUrlArgs;->access$000(Lio/minio/GetPresignedObjectUrlArgs;)Lio/minio/http/Method;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/GetPresignedObjectUrlArgs$Builder;->validateMethod(Lio/minio/http/Method;)V

    .line 84
    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 47
    check-cast p1, Lio/minio/GetPresignedObjectUrlArgs;

    invoke-virtual {p0, p1}, Lio/minio/GetPresignedObjectUrlArgs$Builder;->validate(Lio/minio/GetPresignedObjectUrlArgs;)V

    return-void
.end method
