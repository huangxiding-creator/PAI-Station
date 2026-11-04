.class public final Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;
.super Ljava/lang/Object;
.source "AudioResamplerSync.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00002\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0007\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\n\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\tJ\u0014\u0010\u000b\u001a\u00020\u000c*\u00020\t2\u0006\u0010\r\u001a\u00020\u0004H\u0002J\u001c\u0010\u000e\u001a\u00020\u000f*\u00020\t2\u0006\u0010\r\u001a\u00020\u00042\u0006\u0010\u0010\u001a\u00020\u000cH\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;",
        "",
        "()V",
        "INPUT_RATE",
        "",
        "OUTPUT_RATE",
        "RATIO",
        "",
        "resample48To16",
        "",
        "input48k",
        "getShort",
        "",
        "index",
        "putShort",
        "",
        "value",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field private static final INPUT_RATE:I = 0xbb80

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;

.field private static final OUTPUT_RATE:I = 0x3e80

.field private static final RATIO:F = 0.33333334f


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final getShort([BI)S
    .locals 2
    .param p1, "$this$getShort"    # [B
    .param p2, "index"    # I

    .line 67
    aget-byte v0, p1, p2

    and-int/lit16 v0, v0, 0xff

    .line 68
    add-int/lit8 v1, p2, 0x1

    aget-byte v1, p1, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    .line 67
    or-int/2addr v0, v1

    .line 68
    int-to-short v0, v0

    .line 67
    return v0
.end method

.method private final putShort([BIS)V
    .locals 2
    .param p1, "$this$putShort"    # [B
    .param p2, "index"    # I
    .param p3, "value"    # S

    .line 75
    and-int/lit16 v0, p3, 0xff

    int-to-byte v0, v0

    aput-byte v0, p1, p2

    .line 76
    add-int/lit8 v0, p2, 0x1

    shr-int/lit8 v1, p3, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-byte v1, v1

    aput-byte v1, p1, v0

    .line 77
    return-void
.end method


# virtual methods
.method public final resample48To16([B)[B
    .locals 13
    .param p1, "input48k"    # [B

    const-string v0, "input48k"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    array-length v0, p1

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez v0, :cond_0

    move v0, v2

    goto :goto_0

    :cond_0
    move v0, v1

    :goto_0
    if-nez v0, :cond_5

    array-length v0, p1

    rem-int/lit8 v0, v0, 0x2

    if-eqz v0, :cond_1

    goto :goto_3

    .line 24
    :cond_1
    array-length v0, p1

    div-int/lit8 v0, v0, 0x2

    .line 25
    .local v0, "inputSampleCount":I
    int-to-float v3, v0

    const v4, 0x3eaaaaab

    mul-float/2addr v3, v4

    float-to-int v3, v3

    .line 26
    .local v3, "outputSampleCount":I
    if-gtz v3, :cond_2

    new-array v1, v1, [B

    .line 27
    return-object v1

    .line 31
    :cond_2
    mul-int/lit8 v1, v3, 0x2

    new-array v1, v1, [B

    .line 34
    .local v1, "output16k":[B
    const/4 v5, 0x0

    .local v5, "outIdx":I
    :goto_1
    if-ge v5, v3, :cond_4

    .line 36
    int-to-float v6, v5

    div-float/2addr v6, v4

    .line 37
    .local v6, "inPos":F
    float-to-int v7, v6

    .line 38
    .local v7, "baseIdx":I
    int-to-float v8, v7

    sub-float v8, v6, v8

    .line 41
    .local v8, "fraction":F
    add-int/lit8 v9, v0, -0x1

    if-lt v7, v9, :cond_3

    .line 43
    add-int/lit8 v9, v0, -0x1

    mul-int/lit8 v9, v9, 0x2

    invoke-direct {p0, p1, v9}, Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;->getShort([BI)S

    move-result v9

    .line 44
    .local v9, "lastSample":S
    mul-int/lit8 v10, v5, 0x2

    invoke-direct {p0, v1, v10, v9}, Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;->putShort([BIS)V

    .line 45
    goto :goto_2

    .line 49
    .end local v9    # "lastSample":S
    :cond_3
    mul-int/lit8 v9, v7, 0x2

    invoke-direct {p0, p1, v9}, Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;->getShort([BI)S

    move-result v9

    .line 50
    .local v9, "sampleBase":S
    add-int/lit8 v10, v7, 0x1

    mul-int/lit8 v10, v10, 0x2

    invoke-direct {p0, p1, v10}, Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;->getShort([BI)S

    move-result v10

    .line 54
    .local v10, "sampleNext":S
    int-to-float v11, v9

    int-to-float v12, v2

    sub-float/2addr v12, v8

    mul-float/2addr v11, v12

    int-to-float v12, v10

    mul-float/2addr v12, v8

    add-float/2addr v11, v12

    float-to-int v11, v11

    int-to-short v11, v11

    .line 57
    .local v11, "outputSample":S
    mul-int/lit8 v12, v5, 0x2

    invoke-direct {p0, v1, v12, v11}, Lcom/rokid/security/phone/sdk/server/utils/AudioResamplerSync;->putShort([BIS)V

    .line 34
    .end local v6    # "inPos":F
    .end local v7    # "baseIdx":I
    .end local v8    # "fraction":F
    .end local v9    # "sampleBase":S
    .end local v10    # "sampleNext":S
    .end local v11    # "outputSample":S
    :goto_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 60
    .end local v5    # "outIdx":I
    :cond_4
    return-object v1

    .line 19
    .end local v0    # "inputSampleCount":I
    .end local v1    # "output16k":[B
    .end local v3    # "outputSampleCount":I
    :cond_5
    :goto_3
    new-array v0, v1, [B

    .line 20
    return-object v0
.end method
