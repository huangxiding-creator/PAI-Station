.class public abstract Lio/minio/ObjectConditionalReadArgs$Builder;
.super Lio/minio/ObjectReadArgs$Builder;
.source "ObjectConditionalReadArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/ObjectConditionalReadArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<B:",
        "Lio/minio/ObjectConditionalReadArgs$Builder<",
        "TB;TA;>;A:",
        "Lio/minio/ObjectConditionalReadArgs;",
        ">",
        "Lio/minio/ObjectReadArgs$Builder<",
        "TB;TA;>;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 124
    .local p0, "this":Lio/minio/ObjectConditionalReadArgs$Builder;, "Lio/minio/ObjectConditionalReadArgs$Builder<TB;TA;>;"
    invoke-direct {p0}, Lio/minio/ObjectReadArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$length$1(Ljava/lang/Long;Lio/minio/ObjectConditionalReadArgs;)V
    .locals 0
    .param p0, "length"    # Ljava/lang/Long;
    .param p1, "args"    # Lio/minio/ObjectConditionalReadArgs;

    .line 146
    iput-object p0, p1, Lio/minio/ObjectConditionalReadArgs;->length:Ljava/lang/Long;

    return-void
.end method

.method static synthetic lambda$matchETag$2(Ljava/lang/String;Lio/minio/ObjectConditionalReadArgs;)V
    .locals 0
    .param p0, "etag"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ObjectConditionalReadArgs;

    .line 152
    iput-object p0, p1, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$modifiedSince$4(Ljava/time/ZonedDateTime;Lio/minio/ObjectConditionalReadArgs;)V
    .locals 0
    .param p0, "modifiedTime"    # Ljava/time/ZonedDateTime;
    .param p1, "args"    # Lio/minio/ObjectConditionalReadArgs;

    .line 163
    iput-object p0, p1, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    return-void
.end method

.method static synthetic lambda$notMatchETag$3(Ljava/lang/String;Lio/minio/ObjectConditionalReadArgs;)V
    .locals 0
    .param p0, "etag"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ObjectConditionalReadArgs;

    .line 158
    iput-object p0, p1, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$offset$0(Ljava/lang/Long;Lio/minio/ObjectConditionalReadArgs;)V
    .locals 0
    .param p0, "offset"    # Ljava/lang/Long;
    .param p1, "args"    # Lio/minio/ObjectConditionalReadArgs;

    .line 140
    iput-object p0, p1, Lio/minio/ObjectConditionalReadArgs;->offset:Ljava/lang/Long;

    return-void
.end method

.method static synthetic lambda$unmodifiedSince$5(Ljava/time/ZonedDateTime;Lio/minio/ObjectConditionalReadArgs;)V
    .locals 0
    .param p0, "unmodifiedTime"    # Ljava/time/ZonedDateTime;
    .param p1, "args"    # Lio/minio/ObjectConditionalReadArgs;

    .line 168
    iput-object p0, p1, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    return-void
.end method

.method private validateLength(Ljava/lang/Long;)V
    .locals 4
    .param p1, "length"    # Ljava/lang/Long;

    .line 127
    .local p0, "this":Lio/minio/ObjectConditionalReadArgs$Builder;, "Lio/minio/ObjectConditionalReadArgs$Builder<TB;TA;>;"
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    goto :goto_0

    .line 128
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "length should be greater than zero"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 130
    :cond_1
    :goto_0
    return-void
.end method

.method private validateOffset(Ljava/lang/Long;)V
    .locals 4
    .param p1, "offset"    # Ljava/lang/Long;

    .line 133
    .local p0, "this":Lio/minio/ObjectConditionalReadArgs$Builder;, "Lio/minio/ObjectConditionalReadArgs$Builder<TB;TA;>;"
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-ltz v0, :cond_0

    goto :goto_0

    .line 134
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "offset should be zero or greater"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 136
    :cond_1
    :goto_0
    return-void
.end method


# virtual methods
.method public length(Ljava/lang/Long;)Lio/minio/ObjectConditionalReadArgs$Builder;
    .locals 2
    .param p1, "length"    # Ljava/lang/Long;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Long;",
            ")TB;"
        }
    .end annotation

    .line 145
    .local p0, "this":Lio/minio/ObjectConditionalReadArgs$Builder;, "Lio/minio/ObjectConditionalReadArgs$Builder<TB;TA;>;"
    invoke-direct {p0, p1}, Lio/minio/ObjectConditionalReadArgs$Builder;->validateLength(Ljava/lang/Long;)V

    .line 146
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda2;

    invoke-direct {v1, p1}, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda2;-><init>(Ljava/lang/Long;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 147
    return-object p0
.end method

.method public matchETag(Ljava/lang/String;)Lio/minio/ObjectConditionalReadArgs$Builder;
    .locals 2
    .param p1, "etag"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")TB;"
        }
    .end annotation

    .line 151
    .local p0, "this":Lio/minio/ObjectConditionalReadArgs$Builder;, "Lio/minio/ObjectConditionalReadArgs$Builder<TB;TA;>;"
    const-string v0, "etag"

    invoke-virtual {p0, p1, v0}, Lio/minio/ObjectConditionalReadArgs$Builder;->validateNullOrNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 152
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda3;

    invoke-direct {v1, p1}, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda3;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 153
    return-object p0
.end method

.method public modifiedSince(Ljava/time/ZonedDateTime;)Lio/minio/ObjectConditionalReadArgs$Builder;
    .locals 2
    .param p1, "modifiedTime"    # Ljava/time/ZonedDateTime;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/time/ZonedDateTime;",
            ")TB;"
        }
    .end annotation

    .line 163
    .local p0, "this":Lio/minio/ObjectConditionalReadArgs$Builder;, "Lio/minio/ObjectConditionalReadArgs$Builder<TB;TA;>;"
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda5;

    invoke-direct {v1, p1}, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda5;-><init>(Ljava/time/ZonedDateTime;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 164
    return-object p0
.end method

.method public notMatchETag(Ljava/lang/String;)Lio/minio/ObjectConditionalReadArgs$Builder;
    .locals 2
    .param p1, "etag"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")TB;"
        }
    .end annotation

    .line 157
    .local p0, "this":Lio/minio/ObjectConditionalReadArgs$Builder;, "Lio/minio/ObjectConditionalReadArgs$Builder<TB;TA;>;"
    const-string v0, "etag"

    invoke-virtual {p0, p1, v0}, Lio/minio/ObjectConditionalReadArgs$Builder;->validateNullOrNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 158
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 159
    return-object p0
.end method

.method public offset(Ljava/lang/Long;)Lio/minio/ObjectConditionalReadArgs$Builder;
    .locals 2
    .param p1, "offset"    # Ljava/lang/Long;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Long;",
            ")TB;"
        }
    .end annotation

    .line 139
    .local p0, "this":Lio/minio/ObjectConditionalReadArgs$Builder;, "Lio/minio/ObjectConditionalReadArgs$Builder<TB;TA;>;"
    invoke-direct {p0, p1}, Lio/minio/ObjectConditionalReadArgs$Builder;->validateOffset(Ljava/lang/Long;)V

    .line 140
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda4;

    invoke-direct {v1, p1}, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda4;-><init>(Ljava/lang/Long;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 141
    return-object p0
.end method

.method public unmodifiedSince(Ljava/time/ZonedDateTime;)Lio/minio/ObjectConditionalReadArgs$Builder;
    .locals 2
    .param p1, "unmodifiedTime"    # Ljava/time/ZonedDateTime;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/time/ZonedDateTime;",
            ")TB;"
        }
    .end annotation

    .line 168
    .local p0, "this":Lio/minio/ObjectConditionalReadArgs$Builder;, "Lio/minio/ObjectConditionalReadArgs$Builder<TB;TA;>;"
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda1;-><init>(Ljava/time/ZonedDateTime;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 169
    return-object p0
.end method
