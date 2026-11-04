.class final Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;
.super Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "StringEncoder"
.end annotation


# instance fields
.field _offset:I

.field _value:Ljava/lang/String;


# direct methods
.method protected constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "value"    # Ljava/lang/String;

    .line 216
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;-><init>()V

    .line 217
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    .line 218
    return-void
.end method


# virtual methods
.method public encodeMore([BII)I
    .locals 7
    .param p1, "buffer"    # [B
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 241
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_offset:I

    sub-int/2addr v0, v1

    .line 242
    .local v0, "left":I
    sub-int v1, p3, p2

    .line 243
    .local v1, "free":I
    if-lt v1, v0, :cond_1

    .line 244
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    .line 245
    .local v2, "str":Ljava/lang/String;
    const/4 v3, 0x0

    iput-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    .line 246
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    .local v3, "last":I
    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_offset:I

    .local v4, "offset":I
    :goto_0
    if-ge v4, v3, :cond_0

    .line 247
    add-int/lit8 v5, p2, 0x1

    .end local p2    # "ptr":I
    .local v5, "ptr":I
    invoke-virtual {v2, v4}, Ljava/lang/String;->charAt(I)C

    move-result v6

    int-to-byte v6, v6

    aput-byte v6, p1, p2

    .line 246
    add-int/lit8 v4, v4, 0x1

    move p2, v5

    goto :goto_0

    .line 249
    .end local v3    # "last":I
    .end local v4    # "offset":I
    .end local v5    # "ptr":I
    .restart local p2    # "ptr":I
    :cond_0
    return p2

    .line 251
    .end local v2    # "str":Ljava/lang/String;
    :cond_1
    :goto_1
    if-ge p2, p3, :cond_2

    .line 252
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_offset:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_offset:I

    invoke-virtual {v2, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    int-to-byte v2, v2

    aput-byte v2, p1, p2

    .line 251
    add-int/lit8 p2, p2, 0x1

    goto :goto_1

    .line 254
    :cond_2
    return p2
.end method

.method public encodeMore([CII)I
    .locals 4
    .param p1, "buffer"    # [C
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 226
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_offset:I

    sub-int/2addr v0, v1

    .line 227
    .local v0, "left":I
    sub-int v1, p3, p2

    .line 228
    .local v1, "free":I
    if-lt v1, v0, :cond_0

    .line 229
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_offset:I

    invoke-virtual {v2, v3, v0, p1, p2}, Ljava/lang/String;->getChars(II[CI)V

    .line 230
    const/4 v2, 0x0

    iput-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    .line 231
    add-int v2, p2, v0

    return v2

    .line 233
    :cond_0
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_offset:I

    invoke-virtual {v2, v3, v1, p1, p2}, Ljava/lang/String;->getChars(II[CI)V

    .line 234
    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_offset:I

    add-int/2addr v2, v1

    iput v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_offset:I

    .line 235
    return p3
.end method

.method public isCompleted()Z
    .locals 1

    .line 221
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;->_value:Ljava/lang/String;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
