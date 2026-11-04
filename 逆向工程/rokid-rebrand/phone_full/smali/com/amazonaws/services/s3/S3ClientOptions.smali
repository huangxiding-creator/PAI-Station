.class public Lcom/amazonaws/services/s3/S3ClientOptions;
.super Ljava/lang/Object;
.source "S3ClientOptions.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/services/s3/S3ClientOptions$Builder;
    }
.end annotation


# static fields
.field public static final DEFAULT_ACCELERATE_MODE_ENABLED:Z = false

.field public static final DEFAULT_CHUNKED_ENCODING_DISABLED:Z = false

.field public static final DEFAULT_DUALSTACK_ENABLED:Z = false

.field public static final DEFAULT_PATH_STYLE_ACCESS:Z = false

.field public static final DEFAULT_PAYLOAD_SIGNING_ENABLED:Z = false

.field public static final DEFAULT_SKIP_CONTENT_MD5_CHECK:Z = false


# instance fields
.field private final accelerateModeEnabled:Z

.field private final chunkedEncodingDisabled:Z

.field private final dualstackEnabled:Z

.field private pathStyleAccess:Z

.field private final payloadSigningEnabled:Z

.field private skipContentMd5Check:Z


# direct methods
.method public constructor <init>()V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 214
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 215
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->skipContentMd5Check:Z

    .line 216
    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->pathStyleAccess:Z

    .line 217
    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->chunkedEncodingDisabled:Z

    .line 218
    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->accelerateModeEnabled:Z

    .line 219
    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->payloadSigningEnabled:Z

    .line 220
    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->dualstackEnabled:Z

    .line 221
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/services/s3/S3ClientOptions;)V
    .locals 1
    .param p1, "other"    # Lcom/amazonaws/services/s3/S3ClientOptions;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 229
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 230
    iget-boolean v0, p1, Lcom/amazonaws/services/s3/S3ClientOptions;->skipContentMd5Check:Z

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->skipContentMd5Check:Z

    .line 231
    iget-boolean v0, p1, Lcom/amazonaws/services/s3/S3ClientOptions;->pathStyleAccess:Z

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->pathStyleAccess:Z

    .line 232
    iget-boolean v0, p1, Lcom/amazonaws/services/s3/S3ClientOptions;->chunkedEncodingDisabled:Z

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->chunkedEncodingDisabled:Z

    .line 233
    iget-boolean v0, p1, Lcom/amazonaws/services/s3/S3ClientOptions;->accelerateModeEnabled:Z

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->accelerateModeEnabled:Z

    .line 234
    iget-boolean v0, p1, Lcom/amazonaws/services/s3/S3ClientOptions;->payloadSigningEnabled:Z

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->payloadSigningEnabled:Z

    .line 235
    iget-boolean v0, p1, Lcom/amazonaws/services/s3/S3ClientOptions;->dualstackEnabled:Z

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->dualstackEnabled:Z

    .line 236
    return-void
.end method

.method private constructor <init>(ZZZZZZ)V
    .locals 0
    .param p1, "skipContentMd5Check"    # Z
    .param p2, "pathStyleAccess"    # Z
    .param p3, "chunkedEncodingDisabled"    # Z
    .param p4, "accelerateModeEnabled"    # Z
    .param p5, "payloadSigningEnabled"    # Z
    .param p6, "dualstackEnabled"    # Z

    .line 243
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 244
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->skipContentMd5Check:Z

    .line 245
    iput-boolean p2, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->pathStyleAccess:Z

    .line 246
    iput-boolean p3, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->chunkedEncodingDisabled:Z

    .line 247
    iput-boolean p4, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->accelerateModeEnabled:Z

    .line 248
    iput-boolean p5, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->payloadSigningEnabled:Z

    .line 249
    iput-boolean p6, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->dualstackEnabled:Z

    .line 250
    return-void
.end method

.method synthetic constructor <init>(ZZZZZZLcom/amazonaws/services/s3/S3ClientOptions$1;)V
    .locals 0
    .param p1, "x0"    # Z
    .param p2, "x1"    # Z
    .param p3, "x2"    # Z
    .param p4, "x3"    # Z
    .param p5, "x4"    # Z
    .param p6, "x5"    # Z
    .param p7, "x6"    # Lcom/amazonaws/services/s3/S3ClientOptions$1;

    .line 20
    invoke-direct/range {p0 .. p6}, Lcom/amazonaws/services/s3/S3ClientOptions;-><init>(ZZZZZZ)V

    return-void
.end method

.method public static builder()Lcom/amazonaws/services/s3/S3ClientOptions$Builder;
    .locals 2

    .line 48
    new-instance v0, Lcom/amazonaws/services/s3/S3ClientOptions$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/amazonaws/services/s3/S3ClientOptions$Builder;-><init>(Lcom/amazonaws/services/s3/S3ClientOptions$1;)V

    return-object v0
.end method


# virtual methods
.method public isAccelerateModeEnabled()Z
    .locals 1

    .line 328
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->accelerateModeEnabled:Z

    return v0
.end method

.method public isChunkedEncodingDisabled()Z
    .locals 1

    .line 310
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->chunkedEncodingDisabled:Z

    return v0
.end method

.method public isContentMd5CheckSkipped()Z
    .locals 1

    .line 266
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->skipContentMd5Check:Z

    return v0
.end method

.method public isDualstackEnabled()Z
    .locals 1

    .line 404
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->dualstackEnabled:Z

    return v0
.end method

.method public isPathStyleAccess()Z
    .locals 1

    .line 288
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->pathStyleAccess:Z

    return v0
.end method

.method public isPayloadSigningEnabled()Z
    .locals 1

    .line 352
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->payloadSigningEnabled:Z

    return v0
.end method

.method public setPathStyleAccess(Z)V
    .locals 0
    .param p1, "pathStyleAccess"    # Z
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 392
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->pathStyleAccess:Z

    .line 393
    return-void
.end method

.method public skipContentMd5Check(Z)V
    .locals 0
    .param p1, "skipContentMd5Check"    # Z

    .line 369
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/S3ClientOptions;->skipContentMd5Check:Z

    .line 370
    return-void
.end method

.method public withPathStyleAccess(Z)Lcom/amazonaws/services/s3/S3ClientOptions;
    .locals 0
    .param p1, "pathStyleAccess"    # Z
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 431
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/S3ClientOptions;->setPathStyleAccess(Z)V

    .line 432
    return-object p0
.end method
