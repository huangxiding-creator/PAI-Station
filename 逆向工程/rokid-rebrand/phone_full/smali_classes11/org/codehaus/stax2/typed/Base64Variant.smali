.class public final Lorg/codehaus/stax2/typed/Base64Variant;
.super Ljava/lang/Object;
.source "Base64Variant.java"


# static fields
.field public static final BASE64_VALUE_INVALID:I = -0x1

.field public static final BASE64_VALUE_PADDING:I = -0x2

.field static final PADDING_CHAR_NONE:C


# instance fields
.field private final _asciiToBase64:[I

.field private final _base64ToAsciiB:[B

.field private final _base64ToAsciiC:[C

.field final _maxLineLength:I

.field final _name:Ljava/lang/String;

.field final _paddingChar:C

.field final _usesPadding:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;ZCI)V
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "base64Alphabet"    # Ljava/lang/String;
    .param p3, "usesPadding"    # Z
    .param p4, "paddingChar"    # C
    .param p5, "maxLineLength"    # I

    .line 121
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    const/16 v0, 0x80

    new-array v0, v0, [I

    iput-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_asciiToBase64:[I

    .line 75
    const/16 v0, 0x40

    new-array v1, v0, [C

    iput-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    .line 81
    new-array v1, v0, [B

    iput-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    .line 122
    iput-object p1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_name:Ljava/lang/String;

    .line 123
    iput-boolean p3, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_usesPadding:Z

    .line 124
    iput-char p4, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_paddingChar:C

    .line 125
    iput p5, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_maxLineLength:I

    .line 130
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    .line 131
    .local v1, "alphaLen":I
    if-ne v1, v0, :cond_2

    .line 136
    iget-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    const/4 v2, 0x0

    invoke-virtual {p2, v2, v1, v0, v2}, Ljava/lang/String;->getChars(II[CI)V

    .line 137
    iget-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_asciiToBase64:[I

    const/4 v2, -0x1

    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([II)V

    .line 138
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v1, :cond_0

    .line 139
    iget-object v2, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    aget-char v2, v2, v0

    .line 140
    .local v2, "alpha":C
    iget-object v3, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    int-to-byte v4, v2

    aput-byte v4, v3, v0

    .line 141
    iget-object v3, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_asciiToBase64:[I

    aput v0, v3, v2

    .line 138
    .end local v2    # "alpha":C
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 145
    .end local v0    # "i":I
    :cond_0
    if-eqz p3, :cond_1

    .line 146
    iget-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_asciiToBase64:[I

    const/4 v2, -0x2

    aput v2, v0, p4

    .line 148
    :cond_1
    return-void

    .line 132
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Base64Alphabet length must be exactly 64 (was "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;I)V
    .locals 6
    .param p1, "base"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "maxLineLength"    # I

    .line 157
    iget-boolean v3, p1, Lorg/codehaus/stax2/typed/Base64Variant;->_usesPadding:Z

    iget-char v4, p1, Lorg/codehaus/stax2/typed/Base64Variant;->_paddingChar:C

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v5, p3

    invoke-direct/range {v0 .. v5}, Lorg/codehaus/stax2/typed/Base64Variant;-><init>(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;ZCI)V

    .line 158
    return-void
.end method

.method public constructor <init>(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;ZCI)V
    .locals 6
    .param p1, "base"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "usesPadding"    # Z
    .param p4, "paddingChar"    # C
    .param p5, "maxLineLength"    # I

    .line 166
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    const/16 v0, 0x80

    new-array v0, v0, [I

    iput-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_asciiToBase64:[I

    .line 75
    const/16 v0, 0x40

    new-array v1, v0, [C

    iput-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    .line 81
    new-array v0, v0, [B

    iput-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    .line 167
    iput-object p2, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_name:Ljava/lang/String;

    .line 168
    iget-object v0, p1, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    .line 169
    .local v0, "srcB":[B
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    array-length v2, v0

    const/4 v3, 0x0

    invoke-static {v0, v3, v1, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 170
    iget-object v1, p1, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    .line 171
    .local v1, "srcC":[C
    iget-object v2, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    array-length v4, v1

    invoke-static {v1, v3, v2, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 172
    iget-object v2, p1, Lorg/codehaus/stax2/typed/Base64Variant;->_asciiToBase64:[I

    .line 173
    .local v2, "srcV":[I
    iget-object v4, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_asciiToBase64:[I

    array-length v5, v2

    invoke-static {v2, v3, v4, v3, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 175
    iput-boolean p3, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_usesPadding:Z

    .line 176
    iput-char p4, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_paddingChar:C

    .line 177
    iput p5, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_maxLineLength:I

    .line 178
    return-void
.end method


# virtual methods
.method public decodeBase64Byte(B)I
    .locals 2
    .param p1, "b"    # B

    .line 212
    move v0, p1

    .line 213
    .local v0, "ch":I
    const/16 v1, 0x7f

    if-gt v0, v1, :cond_0

    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_asciiToBase64:[I

    aget v1, v1, v0

    goto :goto_0

    :cond_0
    const/4 v1, -0x1

    :goto_0
    return v1
.end method

.method public decodeBase64Char(C)I
    .locals 2
    .param p1, "c"    # C

    .line 206
    move v0, p1

    .line 207
    .local v0, "ch":I
    const/16 v1, 0x7f

    if-gt v0, v1, :cond_0

    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_asciiToBase64:[I

    aget v1, v1, v0

    goto :goto_0

    :cond_0
    const/4 v1, -0x1

    :goto_0
    return v1
.end method

.method public encodeBase64BitsAsByte(I)B
    .locals 1
    .param p1, "value"    # I

    .line 270
    iget-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    aget-byte v0, v0, p1

    return v0
.end method

.method public encodeBase64BitsAsChar(I)C
    .locals 1
    .param p1, "value"    # I

    .line 227
    iget-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    aget-char v0, v0, p1

    return v0
.end method

.method public encodeBase64Chunk(I[BI)I
    .locals 3
    .param p1, "b24"    # I
    .param p2, "buffer"    # [B
    .param p3, "ptr"    # I

    .line 279
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "ptr":I
    .local v0, "ptr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    shr-int/lit8 v2, p1, 0x12

    and-int/lit8 v2, v2, 0x3f

    aget-byte v1, v1, v2

    aput-byte v1, p2, p3

    .line 280
    add-int/lit8 p3, v0, 0x1

    .end local v0    # "ptr":I
    .restart local p3    # "ptr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    shr-int/lit8 v2, p1, 0xc

    and-int/lit8 v2, v2, 0x3f

    aget-byte v1, v1, v2

    aput-byte v1, p2, v0

    .line 281
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "ptr":I
    .restart local v0    # "ptr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    shr-int/lit8 v2, p1, 0x6

    and-int/lit8 v2, v2, 0x3f

    aget-byte v1, v1, v2

    aput-byte v1, p2, p3

    .line 282
    add-int/lit8 p3, v0, 0x1

    .end local v0    # "ptr":I
    .restart local p3    # "ptr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    and-int/lit8 v2, p1, 0x3f

    aget-byte v1, v1, v2

    aput-byte v1, p2, v0

    .line 283
    return p3
.end method

.method public encodeBase64Chunk(I[CI)I
    .locals 3
    .param p1, "b24"    # I
    .param p2, "buffer"    # [C
    .param p3, "ptr"    # I

    .line 236
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "ptr":I
    .local v0, "ptr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    shr-int/lit8 v2, p1, 0x12

    and-int/lit8 v2, v2, 0x3f

    aget-char v1, v1, v2

    aput-char v1, p2, p3

    .line 237
    add-int/lit8 p3, v0, 0x1

    .end local v0    # "ptr":I
    .restart local p3    # "ptr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    shr-int/lit8 v2, p1, 0xc

    and-int/lit8 v2, v2, 0x3f

    aget-char v1, v1, v2

    aput-char v1, p2, v0

    .line 238
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "ptr":I
    .restart local v0    # "ptr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    shr-int/lit8 v2, p1, 0x6

    and-int/lit8 v2, v2, 0x3f

    aget-char v1, v1, v2

    aput-char v1, p2, p3

    .line 239
    add-int/lit8 p3, v0, 0x1

    .end local v0    # "ptr":I
    .restart local p3    # "ptr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    and-int/lit8 v2, p1, 0x3f

    aget-char v1, v1, v2

    aput-char v1, p2, v0

    .line 240
    return p3
.end method

.method public encodeBase64Partial(II[BI)I
    .locals 4
    .param p1, "bits"    # I
    .param p2, "outputBytes"    # I
    .param p3, "buffer"    # [B
    .param p4, "outPtr"    # I

    .line 296
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "outPtr":I
    .local v0, "outPtr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    shr-int/lit8 v2, p1, 0x12

    and-int/lit8 v2, v2, 0x3f

    aget-byte v1, v1, v2

    aput-byte v1, p3, p4

    .line 297
    add-int/lit8 p4, v0, 0x1

    .end local v0    # "outPtr":I
    .restart local p4    # "outPtr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    shr-int/lit8 v2, p1, 0xc

    and-int/lit8 v2, v2, 0x3f

    aget-byte v1, v1, v2

    aput-byte v1, p3, v0

    .line 298
    iget-boolean v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_usesPadding:Z

    const/4 v1, 0x2

    if-eqz v0, :cond_1

    .line 299
    iget-char v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_paddingChar:C

    int-to-byte v0, v0

    .line 300
    .local v0, "pb":B
    add-int/lit8 v2, p4, 0x1

    .end local p4    # "outPtr":I
    .local v2, "outPtr":I
    if-ne p2, v1, :cond_0

    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    shr-int/lit8 v3, p1, 0x6

    and-int/lit8 v3, v3, 0x3f

    aget-byte v1, v1, v3

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    aput-byte v1, p3, p4

    .line 302
    add-int/lit8 p4, v2, 0x1

    .end local v2    # "outPtr":I
    .restart local p4    # "outPtr":I
    aput-byte v0, p3, v2

    .line 303
    .end local v0    # "pb":B
    goto :goto_1

    .line 304
    :cond_1
    if-ne p2, v1, :cond_2

    .line 305
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "outPtr":I
    .local v0, "outPtr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiB:[B

    shr-int/lit8 v2, p1, 0x6

    and-int/lit8 v2, v2, 0x3f

    aget-byte v1, v1, v2

    aput-byte v1, p3, p4

    move p4, v0

    .line 308
    .end local v0    # "outPtr":I
    .restart local p4    # "outPtr":I
    :cond_2
    :goto_1
    return p4
.end method

.method public encodeBase64Partial(II[CI)I
    .locals 3
    .param p1, "bits"    # I
    .param p2, "outputBytes"    # I
    .param p3, "buffer"    # [C
    .param p4, "outPtr"    # I

    .line 253
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "outPtr":I
    .local v0, "outPtr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    shr-int/lit8 v2, p1, 0x12

    and-int/lit8 v2, v2, 0x3f

    aget-char v1, v1, v2

    aput-char v1, p3, p4

    .line 254
    add-int/lit8 p4, v0, 0x1

    .end local v0    # "outPtr":I
    .restart local p4    # "outPtr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    shr-int/lit8 v2, p1, 0xc

    and-int/lit8 v2, v2, 0x3f

    aget-char v1, v1, v2

    aput-char v1, p3, v0

    .line 255
    iget-boolean v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_usesPadding:Z

    const/4 v1, 0x2

    if-eqz v0, :cond_1

    .line 256
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "outPtr":I
    .restart local v0    # "outPtr":I
    if-ne p2, v1, :cond_0

    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    shr-int/lit8 v2, p1, 0x6

    and-int/lit8 v2, v2, 0x3f

    aget-char v1, v1, v2

    goto :goto_0

    :cond_0
    iget-char v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_paddingChar:C

    :goto_0
    aput-char v1, p3, p4

    .line 258
    add-int/lit8 p4, v0, 0x1

    .end local v0    # "outPtr":I
    .restart local p4    # "outPtr":I
    iget-char v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_paddingChar:C

    aput-char v1, p3, v0

    goto :goto_1

    .line 260
    :cond_1
    if-ne p2, v1, :cond_2

    .line 261
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "outPtr":I
    .restart local v0    # "outPtr":I
    iget-object v1, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_base64ToAsciiC:[C

    shr-int/lit8 v2, p1, 0x6

    and-int/lit8 v2, v2, 0x3f

    aget-char v1, v1, v2

    aput-char v1, p3, p4

    move p4, v0

    .line 264
    .end local v0    # "outPtr":I
    .restart local p4    # "outPtr":I
    :cond_2
    :goto_1
    return p4
.end method

.method public getMaxLineLength()I
    .locals 1

    .line 193
    iget v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_maxLineLength:I

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 186
    iget-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_name:Ljava/lang/String;

    return-object v0
.end method

.method public getPaddingByte()B
    .locals 1

    .line 191
    iget-char v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_paddingChar:C

    int-to-byte v0, v0

    return v0
.end method

.method public getPaddingChar()C
    .locals 1

    .line 190
    iget-char v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_paddingChar:C

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 318
    iget-object v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_name:Ljava/lang/String;

    return-object v0
.end method

.method public usesPadding()Z
    .locals 1

    .line 188
    iget-boolean v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_usesPadding:Z

    return v0
.end method

.method public usesPaddingChar(C)Z
    .locals 1
    .param p1, "c"    # C

    .line 189
    iget-char v0, p0, Lorg/codehaus/stax2/typed/Base64Variant;->_paddingChar:C

    if-ne p1, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
