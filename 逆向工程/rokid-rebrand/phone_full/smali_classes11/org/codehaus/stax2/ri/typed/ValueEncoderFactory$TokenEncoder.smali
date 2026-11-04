.class final Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;
.super Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "TokenEncoder"
.end annotation


# instance fields
.field _value:Ljava/lang/String;


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 165
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;-><init>()V

    return-void
.end method


# virtual methods
.method public encodeMore([BII)I
    .locals 5
    .param p1, "buffer"    # [B
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 188
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;->_value:Ljava/lang/String;

    .line 189
    .local v0, "str":Ljava/lang/String;
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;->_value:Ljava/lang/String;

    .line 190
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    .line 191
    .local v1, "len":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v1, :cond_0

    .line 192
    add-int/lit8 v3, p2, 0x1

    .end local p2    # "ptr":I
    .local v3, "ptr":I
    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    int-to-byte v4, v4

    aput-byte v4, p1, p2

    .line 191
    add-int/lit8 v2, v2, 0x1

    move p2, v3

    goto :goto_0

    .line 194
    .end local v2    # "i":I
    .end local v3    # "ptr":I
    .restart local p2    # "ptr":I
    :cond_0
    return p2
.end method

.method public encodeMore([CII)I
    .locals 3
    .param p1, "buffer"    # [C
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 177
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;->_value:Ljava/lang/String;

    .line 178
    .local v0, "str":Ljava/lang/String;
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;->_value:Ljava/lang/String;

    .line 179
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    .line 180
    .local v1, "len":I
    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1, p1, p2}, Ljava/lang/String;->getChars(II[CI)V

    .line 181
    add-int/2addr p2, v1

    .line 182
    return p2
.end method

.method public isCompleted()Z
    .locals 1

    .line 172
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;->_value:Ljava/lang/String;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method protected reset(Ljava/lang/String;)V
    .locals 0
    .param p1, "value"    # Ljava/lang/String;

    .line 168
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;->_value:Ljava/lang/String;

    .line 169
    return-void
.end method
