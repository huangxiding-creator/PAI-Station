.class public final Lcom/fasterxml/jackson/core/io/NumberInput;
.super Ljava/lang/Object;
.source "NumberInput.java"


# static fields
.field private static final LARGE_INT_SIZE:I = 0x4e2

.field static final L_BILLION:J = 0x3b9aca00L

.field static final MAX_LONG_STR:Ljava/lang/String;

.field static final MIN_LONG_STR_NO_SIGN:Ljava/lang/String;

.field public static final NASTY_SMALL_DOUBLE:Ljava/lang/String; = "2.2250738585072012e-308"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 29
    const-wide/high16 v0, -0x8000000000000000L

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/core/io/NumberInput;->MIN_LONG_STR_NO_SIGN:Ljava/lang/String;

    .line 30
    const-wide v0, 0x7fffffffffffffffL

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/core/io/NumberInput;->MAX_LONG_STR:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static inLongRange(Ljava/lang/String;Z)Z
    .locals 8
    .param p0, "s"    # Ljava/lang/String;
    .param p1, "negative"    # Z

    .line 214
    if-eqz p1, :cond_0

    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberInput;->MIN_LONG_STR_NO_SIGN:Ljava/lang/String;

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberInput;->MAX_LONG_STR:Ljava/lang/String;

    .line 215
    .local v0, "cmp":Ljava/lang/String;
    :goto_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    .line 216
    .local v1, "cmpLen":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    .line 217
    .local v2, "alen":I
    const/4 v3, 0x1

    if-ge v2, v1, :cond_1

    return v3

    .line 218
    :cond_1
    const/4 v4, 0x0

    if-le v2, v1, :cond_2

    return v4

    .line 221
    :cond_2
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_1
    if-ge v5, v1, :cond_5

    .line 222
    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v6

    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v7

    sub-int/2addr v6, v7

    .line 223
    .local v6, "diff":I
    if-eqz v6, :cond_4

    .line 224
    if-gez v6, :cond_3

    goto :goto_2

    :cond_3
    move v3, v4

    :goto_2
    return v3

    .line 221
    .end local v6    # "diff":I
    :cond_4
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 227
    .end local v5    # "i":I
    :cond_5
    return v3
.end method

.method public static inLongRange([CIIZ)Z
    .locals 7
    .param p0, "ch"    # [C
    .param p1, "off"    # I
    .param p2, "len"    # I
    .param p3, "negative"    # Z

    .line 187
    if-eqz p3, :cond_0

    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberInput;->MIN_LONG_STR_NO_SIGN:Ljava/lang/String;

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberInput;->MAX_LONG_STR:Ljava/lang/String;

    .line 188
    .local v0, "cmpStr":Ljava/lang/String;
    :goto_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    .line 189
    .local v1, "cmpLen":I
    const/4 v2, 0x1

    if-ge p2, v1, :cond_1

    return v2

    .line 190
    :cond_1
    const/4 v3, 0x0

    if-le p2, v1, :cond_2

    return v3

    .line 192
    :cond_2
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_1
    if-ge v4, v1, :cond_5

    .line 193
    add-int v5, p1, v4

    aget-char v5, p0, v5

    invoke-virtual {v0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v6

    sub-int/2addr v5, v6

    .line 194
    .local v5, "diff":I
    if-eqz v5, :cond_4

    .line 195
    if-gez v5, :cond_3

    goto :goto_2

    :cond_3
    move v2, v3

    :goto_2
    return v2

    .line 192
    .end local v5    # "diff":I
    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 198
    .end local v4    # "i":I
    :cond_5
    return v2
.end method

.method public static parseAsDouble(Ljava/lang/String;D)D
    .locals 2
    .param p0, "s"    # Ljava/lang/String;
    .param p1, "def"    # D

    .line 316
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseAsDouble(Ljava/lang/String;DZ)D

    move-result-wide v0

    return-wide v0
.end method

.method public static parseAsDouble(Ljava/lang/String;DZ)D
    .locals 3
    .param p0, "s"    # Ljava/lang/String;
    .param p1, "def"    # D
    .param p3, "useFastParser"    # Z

    .line 328
    if-nez p0, :cond_0

    return-wide p1

    .line 329
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 330
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 331
    .local v0, "len":I
    if-nez v0, :cond_1

    .line 332
    return-wide p1

    .line 335
    :cond_1
    :try_start_0
    invoke-static {p0, p3}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseDouble(Ljava/lang/String;Z)D

    move-result-wide v1
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v1

    .line 336
    :catch_0
    move-exception v1

    .line 337
    return-wide p1
.end method

.method public static parseAsInt(Ljava/lang/String;I)I
    .locals 6
    .param p0, "s"    # Ljava/lang/String;
    .param p1, "def"    # I

    .line 232
    if-nez p0, :cond_0

    .line 233
    return p1

    .line 235
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 236
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 237
    .local v0, "len":I
    if-nez v0, :cond_1

    .line 238
    return p1

    .line 241
    :cond_1
    const/4 v1, 0x0

    .line 243
    .local v1, "i":I
    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 244
    .local v2, "sign":C
    const/16 v3, 0x2b

    const/4 v4, 0x1

    if-ne v2, v3, :cond_2

    .line 245
    invoke-virtual {p0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    .line 246
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    goto :goto_0

    .line 247
    :cond_2
    const/16 v3, 0x2d

    if-ne v2, v3, :cond_3

    .line 248
    const/4 v1, 0x1

    .line 250
    :cond_3
    :goto_0
    if-ge v1, v0, :cond_6

    .line 251
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 253
    .local v3, "c":C
    const/16 v5, 0x39

    if-gt v3, v5, :cond_5

    const/16 v5, 0x30

    if-ge v3, v5, :cond_4

    goto :goto_1

    .line 250
    .end local v3    # "c":C
    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 257
    .restart local v3    # "c":C
    :cond_5
    :goto_1
    :try_start_0
    invoke-static {p0, v4}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseDouble(Ljava/lang/String;Z)D

    move-result-wide v4
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    double-to-int v4, v4

    return v4

    .line 258
    :catch_0
    move-exception v4

    .line 259
    .local v4, "e":Ljava/lang/NumberFormatException;
    return p1

    .line 264
    .end local v3    # "c":C
    .end local v4    # "e":Ljava/lang/NumberFormatException;
    :cond_6
    :try_start_1
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    return v3

    .line 265
    :catch_1
    move-exception v3

    .line 266
    return p1
.end method

.method public static parseAsLong(Ljava/lang/String;J)J
    .locals 6
    .param p0, "s"    # Ljava/lang/String;
    .param p1, "def"    # J

    .line 271
    if-nez p0, :cond_0

    .line 272
    return-wide p1

    .line 274
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 275
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 276
    .local v0, "len":I
    if-nez v0, :cond_1

    .line 277
    return-wide p1

    .line 280
    :cond_1
    const/4 v1, 0x0

    .line 282
    .local v1, "i":I
    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 283
    .local v2, "sign":C
    const/16 v3, 0x2b

    const/4 v4, 0x1

    if-ne v2, v3, :cond_2

    .line 284
    invoke-virtual {p0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    .line 285
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    goto :goto_0

    .line 286
    :cond_2
    const/16 v3, 0x2d

    if-ne v2, v3, :cond_3

    .line 287
    const/4 v1, 0x1

    .line 289
    :cond_3
    :goto_0
    if-ge v1, v0, :cond_6

    .line 290
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 292
    .local v3, "c":C
    const/16 v5, 0x39

    if-gt v3, v5, :cond_5

    const/16 v5, 0x30

    if-ge v3, v5, :cond_4

    goto :goto_1

    .line 289
    .end local v3    # "c":C
    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 296
    .restart local v3    # "c":C
    :cond_5
    :goto_1
    :try_start_0
    invoke-static {p0, v4}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseDouble(Ljava/lang/String;Z)D

    move-result-wide v4
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    double-to-long v4, v4

    return-wide v4

    .line 297
    :catch_0
    move-exception v4

    .line 298
    .local v4, "e":Ljava/lang/NumberFormatException;
    return-wide p1

    .line 303
    .end local v3    # "c":C
    .end local v4    # "e":Ljava/lang/NumberFormatException;
    :cond_6
    :try_start_1
    invoke-static {p0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    return-wide v3

    .line 304
    :catch_1
    move-exception v3

    .line 305
    return-wide p1
.end method

.method public static parseBigDecimal(Ljava/lang/String;)Ljava/math/BigDecimal;
    .locals 1
    .param p0, "s"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 384
    invoke-static {p0}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->parse(Ljava/lang/String;)Ljava/math/BigDecimal;

    move-result-object v0

    return-object v0
.end method

.method public static parseBigDecimal([C)Ljava/math/BigDecimal;
    .locals 1
    .param p0, "ch"    # [C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 392
    invoke-static {p0}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->parse([C)Ljava/math/BigDecimal;

    move-result-object v0

    return-object v0
.end method

.method public static parseBigDecimal([CII)Ljava/math/BigDecimal;
    .locals 1
    .param p0, "ch"    # [C
    .param p1, "off"    # I
    .param p2, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 388
    invoke-static {p0, p1, p2}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->parse([CII)Ljava/math/BigDecimal;

    move-result-object v0

    return-object v0
.end method

.method public static parseBigInteger(Ljava/lang/String;)Ljava/math/BigInteger;
    .locals 2
    .param p0, "s"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 402
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x4e2

    if-le v0, v1, :cond_0

    .line 403
    invoke-static {p0}, Lcom/fasterxml/jackson/core/io/BigDecimalParser;->parse(Ljava/lang/String;)Ljava/math/BigDecimal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/math/BigDecimal;->toBigInteger()Ljava/math/BigInteger;

    move-result-object v0

    return-object v0

    .line 405
    :cond_0
    new-instance v0, Ljava/math/BigInteger;

    invoke-direct {v0, p0}, Ljava/math/BigInteger;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method public static parseDouble(Ljava/lang/String;)D
    .locals 2
    .param p0, "s"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 347
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseDouble(Ljava/lang/String;Z)D

    move-result-wide v0

    return-wide v0
.end method

.method public static parseDouble(Ljava/lang/String;Z)D
    .locals 2
    .param p0, "s"    # Ljava/lang/String;
    .param p1, "useFastParser"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 358
    if-eqz p1, :cond_0

    invoke-static {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;->parseDouble(Ljava/lang/CharSequence;)D

    move-result-wide v0

    goto :goto_0

    :cond_0
    invoke-static {p0}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v0

    :goto_0
    return-wide v0
.end method

.method public static parseFloat(Ljava/lang/String;)F
    .locals 1
    .param p0, "s"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 369
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseFloat(Ljava/lang/String;Z)F

    move-result v0

    return v0
.end method

.method public static parseFloat(Ljava/lang/String;Z)F
    .locals 1
    .param p0, "s"    # Ljava/lang/String;
    .param p1, "useFastParser"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 380
    if-eqz p1, :cond_0

    invoke-static {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;->parseFloat(Ljava/lang/CharSequence;)F

    move-result v0

    goto :goto_0

    :cond_0
    invoke-static {p0}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v0

    :goto_0
    return v0
.end method

.method public static parseInt(Ljava/lang/String;)I
    .locals 9
    .param p0, "s"    # Ljava/lang/String;

    .line 95
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 96
    .local v1, "c":C
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    .line 97
    .local v2, "len":I
    const/16 v3, 0x2d

    const/4 v4, 0x1

    if-ne v1, v3, :cond_0

    move v0, v4

    .line 98
    .local v0, "neg":Z
    :cond_0
    const/4 v3, 0x1

    .line 101
    .local v3, "offset":I
    if-eqz v0, :cond_3

    .line 102
    if-eq v2, v4, :cond_2

    const/16 v4, 0xa

    if-le v2, v4, :cond_1

    goto :goto_0

    .line 105
    :cond_1
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "offset":I
    .local v4, "offset":I
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    move v3, v4

    goto :goto_1

    .line 103
    .end local v4    # "offset":I
    .restart local v3    # "offset":I
    :cond_2
    :goto_0
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    return v4

    .line 107
    :cond_3
    const/16 v4, 0x9

    if-le v2, v4, :cond_4

    .line 108
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    return v4

    .line 111
    :cond_4
    :goto_1
    const/16 v4, 0x39

    if-gt v1, v4, :cond_10

    const/16 v5, 0x30

    if-ge v1, v5, :cond_5

    goto :goto_7

    .line 114
    :cond_5
    add-int/lit8 v6, v1, -0x30

    .line 115
    .local v6, "num":I
    if-ge v3, v2, :cond_e

    .line 116
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "offset":I
    .local v7, "offset":I
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 117
    if-gt v1, v4, :cond_d

    if-ge v1, v5, :cond_6

    goto :goto_4

    .line 120
    :cond_6
    mul-int/lit8 v3, v6, 0xa

    add-int/lit8 v8, v1, -0x30

    add-int v6, v3, v8

    .line 121
    if-ge v7, v2, :cond_c

    .line 122
    add-int/lit8 v3, v7, 0x1

    .end local v7    # "offset":I
    .restart local v3    # "offset":I
    invoke-virtual {p0, v7}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 123
    if-gt v1, v4, :cond_b

    if-ge v1, v5, :cond_7

    goto :goto_3

    .line 126
    :cond_7
    mul-int/lit8 v7, v6, 0xa

    add-int/lit8 v8, v1, -0x30

    add-int v6, v7, v8

    .line 128
    if-ge v3, v2, :cond_e

    .line 130
    :cond_8
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "offset":I
    .restart local v7    # "offset":I
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 131
    if-gt v1, v4, :cond_a

    if-ge v1, v5, :cond_9

    goto :goto_2

    .line 134
    :cond_9
    mul-int/lit8 v3, v6, 0xa

    add-int/lit8 v8, v1, -0x30

    add-int v6, v3, v8

    .line 135
    move v3, v7

    if-lt v7, v2, :cond_8

    goto :goto_5

    .line 132
    :cond_a
    :goto_2
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    return v3

    .line 124
    .end local v7    # "offset":I
    .restart local v3    # "offset":I
    :cond_b
    :goto_3
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    return v4

    .line 121
    .end local v3    # "offset":I
    .restart local v7    # "offset":I
    :cond_c
    move v3, v7

    goto :goto_5

    .line 118
    :cond_d
    :goto_4
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    return v3

    .line 139
    .end local v7    # "offset":I
    .restart local v3    # "offset":I
    :cond_e
    :goto_5
    if-eqz v0, :cond_f

    neg-int v4, v6

    goto :goto_6

    :cond_f
    move v4, v6

    :goto_6
    return v4

    .line 112
    .end local v6    # "num":I
    :cond_10
    :goto_7
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    return v4
.end method

.method public static parseInt([CII)I
    .locals 3
    .param p0, "ch"    # [C
    .param p1, "off"    # I
    .param p2, "len"    # I

    .line 48
    if-lez p2, :cond_0

    aget-char v0, p0, p1

    const/16 v1, 0x2b

    if-ne v0, v1, :cond_0

    .line 49
    add-int/lit8 p1, p1, 0x1

    .line 50
    add-int/lit8 p2, p2, -0x1

    .line 53
    :cond_0
    add-int v0, p1, p2

    add-int/lit8 v0, v0, -0x1

    aget-char v0, p0, v0

    add-int/lit8 v0, v0, -0x30

    .line 55
    .local v0, "num":I
    packed-switch p2, :pswitch_data_0

    goto :goto_0

    .line 57
    :pswitch_0
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .local v1, "off":I
    aget-char p1, p0, p1

    add-int/lit8 p1, p1, -0x30

    const v2, 0x5f5e100

    mul-int/2addr p1, v2

    add-int/2addr v0, p1

    move p1, v1

    .line 59
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :pswitch_1
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    aget-char p1, p0, p1

    add-int/lit8 p1, p1, -0x30

    const v2, 0x989680

    mul-int/2addr p1, v2

    add-int/2addr v0, p1

    move p1, v1

    .line 61
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :pswitch_2
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    aget-char p1, p0, p1

    add-int/lit8 p1, p1, -0x30

    const v2, 0xf4240

    mul-int/2addr p1, v2

    add-int/2addr v0, p1

    move p1, v1

    .line 63
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :pswitch_3
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    aget-char p1, p0, p1

    add-int/lit8 p1, p1, -0x30

    const v2, 0x186a0

    mul-int/2addr p1, v2

    add-int/2addr v0, p1

    move p1, v1

    .line 65
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :pswitch_4
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    aget-char p1, p0, p1

    add-int/lit8 p1, p1, -0x30

    mul-int/lit16 p1, p1, 0x2710

    add-int/2addr v0, p1

    move p1, v1

    .line 67
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :pswitch_5
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    aget-char p1, p0, p1

    add-int/lit8 p1, p1, -0x30

    mul-int/lit16 p1, p1, 0x3e8

    add-int/2addr v0, p1

    move p1, v1

    .line 69
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :pswitch_6
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    aget-char p1, p0, p1

    add-int/lit8 p1, p1, -0x30

    mul-int/lit8 p1, p1, 0x64

    add-int/2addr v0, p1

    move p1, v1

    .line 71
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :pswitch_7
    aget-char v1, p0, p1

    add-int/lit8 v1, v1, -0x30

    mul-int/lit8 v1, v1, 0xa

    add-int/2addr v0, v1

    .line 73
    :goto_0
    return v0

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static parseLong(Ljava/lang/String;)J
    .locals 3
    .param p0, "s"    # Ljava/lang/String;

    .line 161
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 162
    .local v0, "length":I
    const/16 v1, 0x9

    if-gt v0, v1, :cond_0

    .line 163
    invoke-static {p0}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseInt(Ljava/lang/String;)I

    move-result v1

    int-to-long v1, v1

    return-wide v1

    .line 166
    :cond_0
    invoke-static {p0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    return-wide v1
.end method

.method public static parseLong([CII)J
    .locals 5
    .param p0, "ch"    # [C
    .param p1, "off"    # I
    .param p2, "len"    # I

    .line 145
    add-int/lit8 v0, p2, -0x9

    .line 146
    .local v0, "len1":I
    invoke-static {p0, p1, v0}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseInt([CII)I

    move-result v1

    int-to-long v1, v1

    const-wide/32 v3, 0x3b9aca00

    mul-long/2addr v1, v3

    .line 147
    .local v1, "val":J
    add-int v3, p1, v0

    const/16 v4, 0x9

    invoke-static {p0, v3, v4}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseInt([CII)I

    move-result v3

    int-to-long v3, v3

    add-long/2addr v3, v1

    return-wide v3
.end method
