.class Lcom/amazonaws/util/Base64Codec$LazyHolder;
.super Ljava/lang/Object;
.source "Base64Codec.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/amazonaws/util/Base64Codec;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "LazyHolder"
.end annotation


# static fields
.field private static final DECODED:[B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 49
    invoke-static {}, Lcom/amazonaws/util/Base64Codec$LazyHolder;->decodeTable()[B

    move-result-object v0

    sput-object v0, Lcom/amazonaws/util/Base64Codec$LazyHolder;->DECODED:[B

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()[B
    .locals 1

    .line 48
    sget-object v0, Lcom/amazonaws/util/Base64Codec$LazyHolder;->DECODED:[B

    return-object v0
.end method

.method private static decodeTable()[B
    .locals 4

    .line 52
    const/16 v0, 0x7b

    new-array v0, v0, [B

    .line 54
    .local v0, "dest":[B
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    const/16 v2, 0x7a

    if-gt v1, v2, :cond_5

    .line 55
    const/16 v3, 0x41

    if-lt v1, v3, :cond_0

    const/16 v3, 0x5a

    if-gt v1, v3, :cond_0

    .line 56
    add-int/lit8 v2, v1, -0x41

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    goto :goto_1

    .line 57
    :cond_0
    const/16 v3, 0x30

    if-lt v1, v3, :cond_1

    const/16 v3, 0x39

    if-gt v1, v3, :cond_1

    .line 58
    add-int/lit8 v2, v1, 0x4

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    goto :goto_1

    .line 59
    :cond_1
    const/16 v3, 0x2b

    if-ne v1, v3, :cond_2

    .line 60
    add-int/lit8 v2, v1, 0x13

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    goto :goto_1

    .line 61
    :cond_2
    const/16 v3, 0x2f

    if-ne v1, v3, :cond_3

    .line 62
    add-int/lit8 v2, v1, 0x10

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    goto :goto_1

    .line 63
    :cond_3
    const/16 v3, 0x61

    if-lt v1, v3, :cond_4

    if-gt v1, v2, :cond_4

    .line 64
    add-int/lit8 v2, v1, -0x47

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    goto :goto_1

    .line 66
    :cond_4
    const/4 v2, -0x1

    aput-byte v2, v0, v1

    .line 54
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 68
    .end local v1    # "i":I
    :cond_5
    return-object v0
.end method
