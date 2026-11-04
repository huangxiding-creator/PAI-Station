.class public abstract Lio/minio/PutObjectBaseArgs$Builder;
.super Lio/minio/ObjectWriteArgs$Builder;
.source "PutObjectBaseArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/PutObjectBaseArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<B:",
        "Lio/minio/PutObjectBaseArgs$Builder<",
        "TB;TA;>;A:",
        "Lio/minio/PutObjectBaseArgs;",
        ">",
        "Lio/minio/ObjectWriteArgs$Builder<",
        "TB;TA;>;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 61
    .local p0, "this":Lio/minio/PutObjectBaseArgs$Builder;, "Lio/minio/PutObjectBaseArgs$Builder<TB;TA;>;"
    invoke-direct {p0}, Lio/minio/ObjectWriteArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$preloadData$0(ZLio/minio/PutObjectBaseArgs;)V
    .locals 0
    .param p0, "preloadData"    # Z
    .param p1, "args"    # Lio/minio/PutObjectBaseArgs;

    .line 124
    iput-boolean p0, p1, Lio/minio/PutObjectBaseArgs;->preloadData:Z

    return-void
.end method

.method private validateSizes(JJ)V
    .locals 6
    .param p1, "objectSize"    # J
    .param p3, "partSize"    # J

    .line 64
    .local p0, "this":Lio/minio/PutObjectBaseArgs$Builder;, "Lio/minio/PutObjectBaseArgs$Builder<TB;TA;>;"
    const-wide/16 v0, 0x0

    cmp-long v2, p3, v0

    if-lez v2, :cond_2

    .line 65
    const-wide/32 v2, 0x500000

    cmp-long v2, p3, v2

    const-string v3, "part size "

    if-ltz v2, :cond_1

    .line 70
    const-wide v4, 0x140000000L

    cmp-long v2, p3, v4

    if-gtz v2, :cond_0

    goto :goto_0

    .line 71
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3, p4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is not supported; maximum allowed 5GiB"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 66
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3, p4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is not supported; minimum allowed 5MiB"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 76
    :cond_2
    :goto_0
    cmp-long v2, p1, v0

    if-ltz v2, :cond_4

    .line 77
    const-wide v0, 0x50000000000L

    cmp-long v0, p1, v0

    if-gtz v0, :cond_3

    goto :goto_1

    .line 78
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "object size "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is not supported; maximum allowed 5TiB"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 81
    :cond_4
    cmp-long v0, p3, v0

    if-lez v0, :cond_5

    .line 85
    :goto_1
    return-void

    .line 82
    :cond_5
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string/jumbo v1, "valid part size must be provided when object size is unknown"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method protected getPartInfo(JJ)[J
    .locals 14
    .param p1, "objectSize"    # J
    .param p3, "partSize"    # J

    .line 88
    .local p0, "this":Lio/minio/PutObjectBaseArgs$Builder;, "Lio/minio/PutObjectBaseArgs$Builder<TB;TA;>;"
    move-wide v0, p1

    invoke-direct/range {p0 .. p4}, Lio/minio/PutObjectBaseArgs$Builder;->validateSizes(JJ)V

    .line 90
    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    const/4 v5, 0x1

    const/4 v6, 0x0

    const/4 v7, 0x2

    if-gez v4, :cond_0

    new-array v2, v7, [J

    aput-wide p3, v2, v6

    const-wide/16 v3, -0x1

    aput-wide v3, v2, v5

    return-object v2

    .line 92
    :cond_0
    cmp-long v4, p3, v2

    if-gtz v4, :cond_1

    .line 94
    long-to-double v8, v0

    const-wide v10, 0x40c3880000000000L    # 10000.0

    div-double/2addr v8, v10

    invoke-static {v8, v9}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v8

    .line 95
    .local v8, "dPartSize":D
    const-wide/high16 v10, 0x4154000000000000L    # 5242880.0

    div-double v12, v8, v10

    invoke-static {v12, v13}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v12

    mul-double/2addr v12, v10

    .line 96
    .end local v8    # "dPartSize":D
    .local v12, "dPartSize":D
    double-to-long v8, v12

    .end local p3    # "partSize":J
    .local v8, "partSize":J
    goto :goto_0

    .line 92
    .end local v8    # "partSize":J
    .end local v12    # "dPartSize":D
    .restart local p3    # "partSize":J
    :cond_1
    move-wide/from16 v8, p3

    .line 99
    .end local p3    # "partSize":J
    .restart local v8    # "partSize":J
    :goto_0
    cmp-long v4, v8, v0

    if-lez v4, :cond_2

    move-wide v8, p1

    .line 100
    :cond_2
    cmp-long v2, v8, v2

    if-lez v2, :cond_3

    long-to-double v2, v0

    long-to-double v10, v8

    div-double/2addr v2, v10

    invoke-static {v2, v3}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v2

    double-to-long v2, v2

    goto :goto_1

    :cond_3
    const-wide/16 v2, 0x1

    .line 101
    .local v2, "partCount":J
    :goto_1
    const-wide/16 v10, 0x2710

    cmp-long v4, v2, v10

    if-gtz v4, :cond_4

    .line 112
    new-array v4, v7, [J

    aput-wide v8, v4, v6

    aput-wide v2, v4, v5

    return-object v4

    .line 102
    :cond_4
    new-instance v4, Ljava/lang/IllegalArgumentException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "object size "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " and part size "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " make more than "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const/16 v6, 0x2710

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "parts for upload"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v4
.end method

.method public preloadData(Z)Lio/minio/PutObjectBaseArgs$Builder;
    .locals 2
    .param p1, "preloadData"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z)TB;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 124
    .local p0, "this":Lio/minio/PutObjectBaseArgs$Builder;, "Lio/minio/PutObjectBaseArgs$Builder<TB;TA;>;"
    iget-object v0, p0, Lio/minio/PutObjectBaseArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/PutObjectBaseArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/PutObjectBaseArgs$Builder$$ExternalSyntheticLambda0;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 125
    return-object p0
.end method
