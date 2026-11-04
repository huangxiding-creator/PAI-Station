.class public Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;
.super Ljava/lang/Object;
.source "SegmentOptions.java"


# static fields
.field private static final DEFLATE_HINT:I = 0x20

.field private static final HAVE_ALL_CODE_FLAGS:I = 0x4

.field private static final HAVE_CLASS_FLAGS_HI:I = 0x200

.field private static final HAVE_CODE_FLAGS_HI:I = 0x400

.field private static final HAVE_CP_NUMBERS:I = 0x2

.field private static final HAVE_FIELD_FLAGS_HI:I = 0x400

.field private static final HAVE_FILE_HEADERS:I = 0x10

.field private static final HAVE_FILE_MODTIME:I = 0x40

.field private static final HAVE_FILE_OPTIONS:I = 0x80

.field private static final HAVE_FILE_SIZE_HI:I = 0x100

.field private static final HAVE_METHOD_FLAGS_HI:I = 0x800

.field private static final HAVE_SPECIAL_FORMATS:I = 0x1

.field private static final UNUSED:I = -0x1ff8


# instance fields
.field private final options:I


# direct methods
.method public constructor <init>(I)V
    .locals 2
    .param p1, "options"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    and-int/lit16 v0, p1, -0x1ff8

    if-nez v0, :cond_0

    .line 72
    iput p1, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    .line 73
    return-void

    .line 70
    :cond_0
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    const-string v1, "Some unused flags are non-zero"

    invoke-direct {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public hasAllCodeFlags()Z
    .locals 1

    .line 76
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit8 v0, v0, 0x4

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasArchiveFileCounts()Z
    .locals 1

    .line 80
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit8 v0, v0, 0x10

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasCPNumberCounts()Z
    .locals 1

    .line 92
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasClassFlagsHi()Z
    .locals 1

    .line 84
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit16 v0, v0, 0x200

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasCodeFlagsHi()Z
    .locals 1

    .line 88
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit16 v0, v0, 0x400

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasFieldFlagsHi()Z
    .locals 1

    .line 96
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit16 v0, v0, 0x400

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasFileModtime()Z
    .locals 1

    .line 100
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit8 v0, v0, 0x40

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasFileOptions()Z
    .locals 1

    .line 104
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasFileSizeHi()Z
    .locals 1

    .line 108
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit16 v0, v0, 0x100

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasMethodFlagsHi()Z
    .locals 1

    .line 112
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit16 v0, v0, 0x800

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasSpecialFormats()Z
    .locals 2

    .line 116
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    const/4 v1, 0x1

    and-int/2addr v0, v1

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public shouldDeflate()Z
    .locals 1

    .line 120
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->options:I

    and-int/lit8 v0, v0, 0x20

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
