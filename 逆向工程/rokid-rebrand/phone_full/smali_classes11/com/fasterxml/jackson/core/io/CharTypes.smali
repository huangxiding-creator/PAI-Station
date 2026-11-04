.class public final Lcom/fasterxml/jackson/core/io/CharTypes;
.super Ljava/lang/Object;
.source "CharTypes.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/jackson/core/io/CharTypes$AltEscapes;
    }
.end annotation


# static fields
.field protected static final HB:[B

.field protected static final HBlower:[B

.field protected static final HC:[C

.field protected static final HClower:[C

.field protected static final sHexValues:[I

.field protected static final sInputCodes:[I

.field protected static final sInputCodesComment:[I

.field protected static final sInputCodesJsNames:[I

.field protected static final sInputCodesUTF8:[I

.field protected static final sInputCodesUtf8JsNames:[I

.field protected static final sInputCodesWS:[I

.field protected static final sOutputEscapes128:[I


# direct methods
.method static constructor <clinit>()V
    .locals 14

    .line 7
    const-string v0, "0123456789ABCDEF"

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->HC:[C

    .line 8
    const-string v0, "0123456789abcdef"

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->HClower:[C

    .line 12
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->HC:[C

    array-length v0, v0

    .line 13
    .local v0, "len":I
    new-array v1, v0, [B

    sput-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->HB:[B

    .line 14
    new-array v1, v0, [B

    sput-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->HBlower:[B

    .line 15
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 16
    sget-object v2, Lcom/fasterxml/jackson/core/io/CharTypes;->HB:[B

    sget-object v3, Lcom/fasterxml/jackson/core/io/CharTypes;->HC:[C

    aget-char v3, v3, v1

    int-to-byte v3, v3

    aput-byte v3, v2, v1

    .line 17
    sget-object v2, Lcom/fasterxml/jackson/core/io/CharTypes;->HBlower:[B

    sget-object v3, Lcom/fasterxml/jackson/core/io/CharTypes;->HClower:[C

    aget-char v3, v3, v1

    int-to-byte v3, v3

    aput-byte v3, v2, v1

    .line 15
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 31
    .end local v0    # "len":I
    .end local v1    # "i":I
    :cond_0
    const/16 v0, 0x100

    new-array v1, v0, [I

    .line 33
    .local v1, "table":[I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    const/16 v3, 0x20

    const/4 v4, -0x1

    if-ge v2, v3, :cond_1

    .line 34
    aput v4, v1, v2

    .line 33
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 37
    .end local v2    # "i":I
    :cond_1
    const/16 v2, 0x22

    const/4 v5, 0x1

    aput v5, v1, v2

    .line 38
    const/16 v6, 0x5c

    aput v5, v1, v6

    .line 39
    sput-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodes:[I

    .line 48
    .end local v1    # "table":[I
    sget-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodes:[I

    array-length v1, v1

    new-array v1, v1, [I

    .line 49
    .restart local v1    # "table":[I
    sget-object v7, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodes:[I

    array-length v8, v1

    const/4 v9, 0x0

    invoke-static {v7, v9, v1, v9, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 50
    const/16 v7, 0x80

    .local v7, "c":I
    :goto_2
    if-ge v7, v0, :cond_5

    .line 54
    and-int/lit16 v8, v7, 0xe0

    const/16 v10, 0xc0

    if-ne v8, v10, :cond_2

    .line 55
    const/4 v8, 0x2

    .local v8, "code":I
    goto :goto_3

    .line 56
    .end local v8    # "code":I
    :cond_2
    and-int/lit16 v8, v7, 0xf0

    const/16 v10, 0xe0

    if-ne v8, v10, :cond_3

    .line 57
    const/4 v8, 0x3

    .restart local v8    # "code":I
    goto :goto_3

    .line 58
    .end local v8    # "code":I
    :cond_3
    and-int/lit16 v8, v7, 0xf8

    const/16 v10, 0xf0

    if-ne v8, v10, :cond_4

    .line 60
    const/4 v8, 0x4

    .restart local v8    # "code":I
    goto :goto_3

    .line 63
    .end local v8    # "code":I
    :cond_4
    const/4 v8, -0x1

    .line 65
    .restart local v8    # "code":I
    :goto_3
    aput v8, v1, v7

    .line 50
    .end local v8    # "code":I
    add-int/lit8 v7, v7, 0x1

    goto :goto_2

    .line 67
    .end local v7    # "c":I
    :cond_5
    sput-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesUTF8:[I

    .line 78
    .end local v1    # "table":[I
    new-array v1, v0, [I

    .line 80
    .restart local v1    # "table":[I
    invoke-static {v1, v4}, Ljava/util/Arrays;->fill([II)V

    .line 82
    const/16 v7, 0x21

    .local v7, "i":I
    :goto_4
    if-ge v7, v0, :cond_7

    .line 83
    int-to-char v8, v7

    invoke-static {v8}, Ljava/lang/Character;->isJavaIdentifierPart(C)Z

    move-result v8

    if-eqz v8, :cond_6

    .line 84
    aput v9, v1, v7

    .line 82
    :cond_6
    add-int/lit8 v7, v7, 0x1

    goto :goto_4

    .line 90
    .end local v7    # "i":I
    :cond_7
    const/16 v7, 0x40

    aput v9, v1, v7

    .line 91
    const/16 v7, 0x23

    aput v9, v1, v7

    .line 92
    const/16 v8, 0x2a

    aput v9, v1, v8

    .line 93
    const/16 v10, 0x2d

    aput v9, v1, v10

    .line 94
    const/16 v10, 0x2b

    aput v9, v1, v10

    .line 95
    sput-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesJsNames:[I

    .line 105
    .end local v1    # "table":[I
    new-array v1, v0, [I

    .line 107
    .restart local v1    # "table":[I
    sget-object v10, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesJsNames:[I

    array-length v11, v1

    invoke-static {v10, v9, v1, v9, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 108
    const/16 v10, 0x80

    invoke-static {v1, v10, v10, v9}, Ljava/util/Arrays;->fill([IIII)V

    .line 109
    sput-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesUtf8JsNames:[I

    .line 118
    .end local v1    # "table":[I
    new-array v1, v0, [I

    .line 120
    .local v1, "buf":[I
    sget-object v11, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesUTF8:[I

    invoke-static {v11, v10, v1, v10, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 123
    invoke-static {v1, v9, v3, v4}, Ljava/util/Arrays;->fill([IIII)V

    .line 124
    const/16 v11, 0x9

    aput v9, v1, v11

    .line 125
    const/16 v12, 0xa

    aput v12, v1, v12

    .line 126
    const/16 v13, 0xd

    aput v13, v1, v13

    .line 127
    aput v8, v1, v8

    .line 128
    sput-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesComment:[I

    .line 139
    .end local v1    # "buf":[I
    new-array v1, v0, [I

    .line 140
    .restart local v1    # "buf":[I
    sget-object v8, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesUTF8:[I

    invoke-static {v8, v10, v1, v10, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 145
    invoke-static {v1, v9, v3, v4}, Ljava/util/Arrays;->fill([IIII)V

    .line 146
    aput v5, v1, v3

    .line 147
    aput v5, v1, v11

    .line 148
    aput v12, v1, v12

    .line 149
    aput v13, v1, v13

    .line 150
    const/16 v5, 0x2f

    aput v5, v1, v5

    .line 151
    aput v7, v1, v7

    .line 152
    sput-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesWS:[I

    .line 161
    .end local v1    # "buf":[I
    new-array v1, v10, [I

    .line 163
    .local v1, "table":[I
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_5
    if-ge v5, v3, :cond_8

    .line 165
    aput v4, v1, v5

    .line 163
    add-int/lit8 v5, v5, 0x1

    goto :goto_5

    .line 168
    .end local v5    # "i":I
    :cond_8
    aput v2, v1, v2

    .line 169
    aput v6, v1, v6

    .line 171
    const/16 v2, 0x8

    const/16 v3, 0x62

    aput v3, v1, v2

    .line 172
    const/16 v2, 0x74

    aput v2, v1, v11

    .line 173
    const/16 v2, 0xc

    const/16 v3, 0x66

    aput v3, v1, v2

    .line 174
    const/16 v2, 0x6e

    aput v2, v1, v12

    .line 175
    const/16 v2, 0x72

    aput v2, v1, v13

    .line 176
    sput-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sOutputEscapes128:[I

    .line 186
    .end local v1    # "table":[I
    new-array v0, v0, [I

    sput-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sHexValues:[I

    .line 188
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sHexValues:[I

    invoke-static {v0, v4}, Ljava/util/Arrays;->fill([II)V

    .line 189
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_6
    if-ge v0, v12, :cond_9

    .line 190
    sget-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sHexValues:[I

    add-int/lit8 v2, v0, 0x30

    aput v0, v1, v2

    .line 189
    add-int/lit8 v0, v0, 0x1

    goto :goto_6

    .line 192
    .end local v0    # "i":I
    :cond_9
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_7
    const/4 v1, 0x6

    if-ge v0, v1, :cond_a

    .line 193
    sget-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sHexValues:[I

    add-int/lit8 v2, v0, 0x61

    add-int/lit8 v3, v0, 0xa

    aput v3, v1, v2

    .line 194
    sget-object v1, Lcom/fasterxml/jackson/core/io/CharTypes;->sHexValues:[I

    add-int/lit8 v2, v0, 0x41

    add-int/lit8 v3, v0, 0xa

    aput v3, v1, v2

    .line 192
    add-int/lit8 v0, v0, 0x1

    goto :goto_7

    .line 196
    .end local v0    # "i":I
    :cond_a
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static appendQuoted(Ljava/lang/StringBuilder;Ljava/lang/String;)V
    .locals 9
    .param p0, "sb"    # Ljava/lang/StringBuilder;
    .param p1, "content"    # Ljava/lang/String;

    .line 260
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sOutputEscapes128:[I

    .line 261
    .local v0, "escCodes":[I
    array-length v1, v0

    .line 262
    .local v1, "escLen":I
    const/4 v2, 0x0

    .local v2, "i":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    .local v3, "len":I
    :goto_0
    if-ge v2, v3, :cond_3

    .line 263
    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 264
    .local v4, "c":C
    if-ge v4, v1, :cond_2

    aget v5, v0, v4

    if-nez v5, :cond_0

    goto :goto_1

    .line 268
    :cond_0
    const/16 v5, 0x5c

    invoke-virtual {p0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 269
    aget v5, v0, v4

    .line 270
    .local v5, "escCode":I
    if-gez v5, :cond_1

    .line 279
    const/16 v6, 0x75

    invoke-virtual {p0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 280
    const/16 v6, 0x30

    invoke-virtual {p0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 281
    invoke-virtual {p0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 282
    move v6, v4

    .line 283
    .local v6, "value":I
    sget-object v7, Lcom/fasterxml/jackson/core/io/CharTypes;->HC:[C

    shr-int/lit8 v8, v6, 0x4

    aget-char v7, v7, v8

    invoke-virtual {p0, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 284
    sget-object v7, Lcom/fasterxml/jackson/core/io/CharTypes;->HC:[C

    and-int/lit8 v8, v6, 0xf

    aget-char v7, v7, v8

    invoke-virtual {p0, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 285
    .end local v6    # "value":I
    goto :goto_2

    .line 286
    :cond_1
    int-to-char v6, v5

    invoke-virtual {p0, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 265
    .end local v5    # "escCode":I
    :cond_2
    :goto_1
    invoke-virtual {p0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 266
    nop

    .line 262
    .end local v4    # "c":C
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 289
    .end local v2    # "i":I
    .end local v3    # "len":I
    :cond_3
    return-void
.end method

.method public static charToHex(I)I
    .locals 2
    .param p0, "ch"    # I

    .line 240
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sHexValues:[I

    and-int/lit16 v1, p0, 0xff

    aget v0, v0, v1

    return v0
.end method

.method public static copyHexBytes()[B
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 308
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/fasterxml/jackson/core/io/CharTypes;->copyHexBytes(Z)[B

    move-result-object v0

    return-object v0
.end method

.method public static copyHexBytes(Z)[B
    .locals 1
    .param p0, "uppercase"    # Z

    .line 312
    if-eqz p0, :cond_0

    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->HB:[B

    invoke-virtual {v0}, [B->clone()Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->HBlower:[B

    invoke-virtual {v0}, [B->clone()Ljava/lang/Object;

    move-result-object v0

    :goto_0
    check-cast v0, [B

    return-object v0
.end method

.method public static copyHexChars()[C
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 296
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/fasterxml/jackson/core/io/CharTypes;->copyHexChars(Z)[C

    move-result-object v0

    return-object v0
.end method

.method public static copyHexChars(Z)[C
    .locals 1
    .param p0, "uppercase"    # Z

    .line 300
    if-eqz p0, :cond_0

    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->HC:[C

    invoke-virtual {v0}, [C->clone()Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->HClower:[C

    invoke-virtual {v0}, [C->clone()Ljava/lang/Object;

    move-result-object v0

    :goto_0
    check-cast v0, [C

    return-object v0
.end method

.method public static get7BitOutputEscapes()[I
    .locals 1

    .line 216
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sOutputEscapes128:[I

    return-object v0
.end method

.method public static get7BitOutputEscapes(I)[I
    .locals 1
    .param p0, "quoteChar"    # I

    .line 230
    const/16 v0, 0x22

    if-ne p0, v0, :cond_0

    .line 231
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sOutputEscapes128:[I

    return-object v0

    .line 233
    :cond_0
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes$AltEscapes;->instance:Lcom/fasterxml/jackson/core/io/CharTypes$AltEscapes;

    invoke-virtual {v0, p0}, Lcom/fasterxml/jackson/core/io/CharTypes$AltEscapes;->escapesFor(I)[I

    move-result-object v0

    return-object v0
.end method

.method public static getInputCodeComment()[I
    .locals 1

    .line 204
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesComment:[I

    return-object v0
.end method

.method public static getInputCodeLatin1()[I
    .locals 1

    .line 198
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodes:[I

    return-object v0
.end method

.method public static getInputCodeLatin1JsNames()[I
    .locals 1

    .line 201
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesJsNames:[I

    return-object v0
.end method

.method public static getInputCodeUtf8()[I
    .locals 1

    .line 199
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesUTF8:[I

    return-object v0
.end method

.method public static getInputCodeUtf8JsNames()[I
    .locals 1

    .line 202
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesUtf8JsNames:[I

    return-object v0
.end method

.method public static getInputCodeWS()[I
    .locals 1

    .line 205
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->sInputCodesWS:[I

    return-object v0
.end method

.method public static hexToChar(I)C
    .locals 1
    .param p0, "ch"    # I

    .line 246
    sget-object v0, Lcom/fasterxml/jackson/core/io/CharTypes;->HC:[C

    aget-char v0, v0, p0

    return v0
.end method
