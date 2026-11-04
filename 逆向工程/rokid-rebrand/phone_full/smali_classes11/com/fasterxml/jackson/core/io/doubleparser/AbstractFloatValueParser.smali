.class abstract Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;
.super Ljava/lang/Object;
.source "AbstractFloatValueParser.java"


# static fields
.field static final CHAR_TO_HEX_MAP:[B

.field static final DECIMAL_POINT_CLASS:B = -0x4t

.field static final MAX_EXPONENT_NUMBER:I = 0x400

.field static final MINIMAL_NINETEEN_DIGIT_INTEGER:J = 0xde0b6b3a7640000L

.field static final OTHER_CLASS:B = -0x1t

.field static final PARSE_ERROR:J = -0x1L


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 70
    const/16 v0, 0x80

    new-array v0, v0, [B

    sput-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    .line 73
    const/4 v0, 0x0

    .local v0, "ch":C
    :goto_0
    sget-object v1, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    array-length v1, v1

    if-ge v0, v1, :cond_0

    .line 74
    sget-object v1, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    const/4 v2, -0x1

    aput-byte v2, v1, v0

    .line 73
    add-int/lit8 v1, v0, 0x1

    int-to-char v0, v1

    goto :goto_0

    .line 76
    .end local v0    # "ch":C
    :cond_0
    const/16 v0, 0x30

    .restart local v0    # "ch":C
    :goto_1
    const/16 v1, 0x39

    if-gt v0, v1, :cond_1

    .line 77
    sget-object v1, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    add-int/lit8 v2, v0, -0x30

    int-to-byte v2, v2

    aput-byte v2, v1, v0

    .line 76
    add-int/lit8 v1, v0, 0x1

    int-to-char v0, v1

    goto :goto_1

    .line 79
    .end local v0    # "ch":C
    :cond_1
    const/16 v0, 0x41

    .restart local v0    # "ch":C
    :goto_2
    const/16 v1, 0x46

    if-gt v0, v1, :cond_2

    .line 80
    sget-object v1, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    add-int/lit8 v2, v0, -0x41

    add-int/lit8 v2, v2, 0xa

    int-to-byte v2, v2

    aput-byte v2, v1, v0

    .line 79
    add-int/lit8 v1, v0, 0x1

    int-to-char v0, v1

    goto :goto_2

    .line 82
    .end local v0    # "ch":C
    :cond_2
    const/16 v0, 0x61

    .restart local v0    # "ch":C
    :goto_3
    const/16 v1, 0x66

    if-gt v0, v1, :cond_3

    .line 83
    sget-object v1, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    add-int/lit8 v2, v0, -0x61

    add-int/lit8 v2, v2, 0xa

    int-to-byte v2, v2

    aput-byte v2, v1, v0

    .line 82
    add-int/lit8 v1, v0, 0x1

    int-to-char v0, v1

    goto :goto_3

    .line 85
    .end local v0    # "ch":C
    :cond_3
    const/16 v0, 0x2e

    .restart local v0    # "ch":C
    :goto_4
    const/16 v1, 0x2e

    if-gt v0, v1, :cond_4

    .line 86
    sget-object v1, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatValueParser;->CHAR_TO_HEX_MAP:[B

    const/4 v2, -0x4

    aput-byte v2, v1, v0

    .line 85
    add-int/lit8 v1, v0, 0x1

    int-to-char v0, v1

    goto :goto_4

    .line 88
    .end local v0    # "ch":C
    :cond_4
    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
