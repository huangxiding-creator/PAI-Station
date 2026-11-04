.class public final Lio/minio/DownloadObjectArgs$Builder;
.super Lio/minio/ObjectReadArgs$Builder;
.source "DownloadObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/DownloadObjectArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectReadArgs$Builder<",
        "Lio/minio/DownloadObjectArgs$Builder;",
        "Lio/minio/DownloadObjectArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Lio/minio/ObjectReadArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$filename$0(Ljava/lang/String;Lio/minio/DownloadObjectArgs;)V
    .locals 0
    .param p0, "filename"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/DownloadObjectArgs;

    .line 48
    invoke-static {p1, p0}, Lio/minio/DownloadObjectArgs;->access$102(Lio/minio/DownloadObjectArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$overwrite$1(ZLio/minio/DownloadObjectArgs;)V
    .locals 0
    .param p0, "flag"    # Z
    .param p1, "args"    # Lio/minio/DownloadObjectArgs;

    .line 53
    invoke-static {p1, p0}, Lio/minio/DownloadObjectArgs;->access$002(Lio/minio/DownloadObjectArgs;Z)Z

    return-void
.end method

.method private validateFilename(Ljava/lang/String;)V
    .locals 1
    .param p1, "filename"    # Ljava/lang/String;

    .line 43
    const-string v0, "filename"

    invoke-virtual {p0, p1, v0}, Lio/minio/DownloadObjectArgs$Builder;->validateNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    return-void
.end method


# virtual methods
.method public filename(Ljava/lang/String;)Lio/minio/DownloadObjectArgs$Builder;
    .locals 2
    .param p1, "filename"    # Ljava/lang/String;

    .line 47
    invoke-direct {p0, p1}, Lio/minio/DownloadObjectArgs$Builder;->validateFilename(Ljava/lang/String;)V

    .line 48
    iget-object v0, p0, Lio/minio/DownloadObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/DownloadObjectArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/DownloadObjectArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 49
    return-object p0
.end method

.method public overwrite(Z)Lio/minio/DownloadObjectArgs$Builder;
    .locals 2
    .param p1, "flag"    # Z

    .line 53
    iget-object v0, p0, Lio/minio/DownloadObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/DownloadObjectArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/DownloadObjectArgs$Builder$$ExternalSyntheticLambda1;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 54
    return-object p0
.end method
