.class public final Lio/minio/PutObjectArgs$Builder;
.super Lio/minio/PutObjectBaseArgs$Builder;
.source "PutObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/PutObjectArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/PutObjectBaseArgs$Builder<",
        "Lio/minio/PutObjectArgs$Builder;",
        "Lio/minio/PutObjectArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Lio/minio/PutObjectBaseArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$contentType$4(Ljava/lang/String;Lio/minio/PutObjectArgs;)V
    .locals 0
    .param p0, "contentType"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/PutObjectArgs;

    .line 90
    iput-object p0, p1, Lio/minio/PutObjectArgs;->contentType:Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$setStream$0(Ljava/io/BufferedInputStream;Lio/minio/PutObjectArgs;)V
    .locals 0
    .param p0, "stream"    # Ljava/io/BufferedInputStream;
    .param p1, "args"    # Lio/minio/PutObjectArgs;

    .line 81
    invoke-static {p1, p0}, Lio/minio/PutObjectArgs;->access$002(Lio/minio/PutObjectArgs;Ljava/io/BufferedInputStream;)Ljava/io/BufferedInputStream;

    return-void
.end method

.method static synthetic lambda$setStream$1(JLio/minio/PutObjectArgs;)V
    .locals 0
    .param p0, "objectSize"    # J
    .param p2, "args"    # Lio/minio/PutObjectArgs;

    .line 82
    iput-wide p0, p2, Lio/minio/PutObjectArgs;->objectSize:J

    return-void
.end method

.method static synthetic lambda$setStream$2(JLio/minio/PutObjectArgs;)V
    .locals 0
    .param p0, "partSize"    # J
    .param p2, "args"    # Lio/minio/PutObjectArgs;

    .line 83
    iput-wide p0, p2, Lio/minio/PutObjectArgs;->partSize:J

    return-void
.end method

.method static synthetic lambda$setStream$3(ILio/minio/PutObjectArgs;)V
    .locals 0
    .param p0, "partCount"    # I
    .param p1, "args"    # Lio/minio/PutObjectArgs;

    .line 84
    iput p0, p1, Lio/minio/PutObjectArgs;->partCount:I

    return-void
.end method

.method private setStream(Ljava/io/BufferedInputStream;JJI)Lio/minio/PutObjectArgs$Builder;
    .locals 2
    .param p1, "stream"    # Ljava/io/BufferedInputStream;
    .param p2, "objectSize"    # J
    .param p4, "partSize"    # J
    .param p6, "partCount"    # I

    .line 81
    iget-object v0, p0, Lio/minio/PutObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/io/BufferedInputStream;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 82
    iget-object v0, p0, Lio/minio/PutObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p2, p3}, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda1;-><init>(J)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 83
    iget-object v0, p0, Lio/minio/PutObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda2;

    invoke-direct {v1, p4, p5}, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda2;-><init>(J)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 84
    iget-object v0, p0, Lio/minio/PutObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda3;

    invoke-direct {v1, p6}, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda3;-><init>(I)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 85
    return-object p0
.end method


# virtual methods
.method public contentType(Ljava/lang/String;)Lio/minio/PutObjectArgs$Builder;
    .locals 2
    .param p1, "contentType"    # Ljava/lang/String;

    .line 89
    const-string v0, "content type"

    invoke-virtual {p0, p1, v0}, Lio/minio/PutObjectArgs$Builder;->validateNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 90
    iget-object v0, p0, Lio/minio/PutObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda4;

    invoke-direct {v1, p1}, Lio/minio/PutObjectArgs$Builder$$ExternalSyntheticLambda4;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 91
    return-object p0
.end method

.method public stream(Ljava/io/InputStream;JJ)Lio/minio/PutObjectArgs$Builder;
    .locals 17
    .param p1, "stream"    # Ljava/io/InputStream;
    .param p2, "objectSize"    # J
    .param p4, "partSize"    # J

    .line 66
    move-object/from16 v7, p0

    move-object/from16 v8, p1

    const-string/jumbo v0, "stream"

    invoke-virtual {v7, v8, v0}, Lio/minio/PutObjectArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 68
    move-wide/from16 v9, p2

    move-wide/from16 v11, p4

    invoke-virtual {v7, v9, v10, v11, v12}, Lio/minio/PutObjectArgs$Builder;->getPartInfo(JJ)[J

    move-result-object v13

    .line 69
    .local v13, "partinfo":[J
    const/4 v0, 0x0

    aget-wide v14, v13, v0

    .line 70
    .local v14, "pSize":J
    const/4 v0, 0x1

    aget-wide v0, v13, v0

    long-to-int v6, v0

    .line 73
    .local v6, "pCount":I
    instance-of v0, v8, Ljava/io/BufferedInputStream;

    if-eqz v0, :cond_0

    .line 74
    move-object v0, v8

    check-cast v0, Ljava/io/BufferedInputStream;

    move-object v1, v0

    goto :goto_0

    .line 75
    :cond_0
    new-instance v0, Ljava/io/BufferedInputStream;

    invoke-direct {v0, v8}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v1, v0

    :goto_0
    nop

    .line 76
    .local v1, "bis":Ljava/io/BufferedInputStream;
    move-object/from16 v0, p0

    move-wide/from16 v2, p2

    move-wide v4, v14

    move/from16 v16, v6

    .end local v6    # "pCount":I
    .local v16, "pCount":I
    invoke-direct/range {v0 .. v6}, Lio/minio/PutObjectArgs$Builder;->setStream(Ljava/io/BufferedInputStream;JJI)Lio/minio/PutObjectArgs$Builder;

    move-result-object v0

    return-object v0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 46
    check-cast p1, Lio/minio/PutObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/PutObjectArgs$Builder;->validate(Lio/minio/PutObjectArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 46
    check-cast p1, Lio/minio/PutObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/PutObjectArgs$Builder;->validate(Lio/minio/PutObjectArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/ObjectArgs;)V
    .locals 0

    .line 46
    check-cast p1, Lio/minio/PutObjectArgs;

    invoke-virtual {p0, p1}, Lio/minio/PutObjectArgs$Builder;->validate(Lio/minio/PutObjectArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/PutObjectArgs;)V
    .locals 2
    .param p1, "args"    # Lio/minio/PutObjectArgs;

    .line 49
    invoke-super {p0, p1}, Lio/minio/PutObjectBaseArgs$Builder;->validate(Lio/minio/ObjectArgs;)V

    .line 50
    invoke-static {p1}, Lio/minio/PutObjectArgs;->access$000(Lio/minio/PutObjectArgs;)Ljava/io/BufferedInputStream;

    move-result-object v0

    const-string/jumbo v1, "stream"

    invoke-virtual {p0, v0, v1}, Lio/minio/PutObjectArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    return-void
.end method
