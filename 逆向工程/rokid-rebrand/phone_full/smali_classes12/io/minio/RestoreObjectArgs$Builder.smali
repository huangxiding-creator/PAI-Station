.class public final Lio/minio/RestoreObjectArgs$Builder;
.super Lio/minio/ObjectVersionArgs$Builder;
.source "RestoreObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/RestoreObjectArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectVersionArgs$Builder<",
        "Lio/minio/RestoreObjectArgs$Builder;",
        "Lio/minio/RestoreObjectArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$request$0(Lio/minio/messages/RestoreRequest;Lio/minio/RestoreObjectArgs;)V
    .locals 0
    .param p0, "request"    # Lio/minio/messages/RestoreRequest;
    .param p1, "args"    # Lio/minio/RestoreObjectArgs;

    .line 42
    invoke-static {p1, p0}, Lio/minio/RestoreObjectArgs;->access$002(Lio/minio/RestoreObjectArgs;Lio/minio/messages/RestoreRequest;)Lio/minio/messages/RestoreRequest;

    return-void
.end method

.method private validateRequest(Lio/minio/messages/RestoreRequest;)V
    .locals 1
    .param p1, "request"    # Lio/minio/messages/RestoreRequest;

    .line 37
    const-string v0, "request"

    invoke-virtual {p0, p1, v0}, Lio/minio/RestoreObjectArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    return-void
.end method


# virtual methods
.method public request(Lio/minio/messages/RestoreRequest;)Lio/minio/RestoreObjectArgs$Builder;
    .locals 2
    .param p1, "request"    # Lio/minio/messages/RestoreRequest;

    .line 41
    invoke-direct {p0, p1}, Lio/minio/RestoreObjectArgs$Builder;->validateRequest(Lio/minio/messages/RestoreRequest;)V

    .line 42
    iget-object v0, p0, Lio/minio/RestoreObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/RestoreObjectArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/RestoreObjectArgs$Builder$$ExternalSyntheticLambda0;-><init>(Lio/minio/messages/RestoreRequest;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 43
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 35
    check-cast p1, Lio/minio/RestoreObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/RestoreObjectArgs$Builder;->validate(Lio/minio/RestoreObjectArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 35
    check-cast p1, Lio/minio/RestoreObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/RestoreObjectArgs$Builder;->validate(Lio/minio/RestoreObjectArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 35
    check-cast p1, Lio/minio/RestoreObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/RestoreObjectArgs$Builder;->validate(Lio/minio/RestoreObjectArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/RestoreObjectArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/RestoreObjectArgs;

    .line 48
    invoke-super {p0, p1}, Lio/minio/ObjectVersionArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 49
    invoke-virtual {p1}, Lio/minio/RestoreObjectArgs;->request()Lio/minio/messages/RestoreRequest;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/RestoreObjectArgs$Builder;->validateRequest(Lio/minio/messages/RestoreRequest;)V

    .line 50
    return-void
.end method
