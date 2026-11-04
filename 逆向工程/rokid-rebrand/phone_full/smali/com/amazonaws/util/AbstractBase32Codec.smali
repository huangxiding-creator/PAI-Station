.class abstract Lcom/amazonaws/util/AbstractBase32Codec;
.super Ljava/lang/Object;
.source "AbstractBase32Codec.java"

# interfaces
.implements Lcom/amazonaws/util/Codec;


# static fields
.field private static final BITS_3:I = 0x3

.field private static final BITS_4:I = 0x4

.field private static final BITS_5:I = 0x5

.field private static final BIT_MULTIPLIER:I = 0x8

.field private static final MASK_2BITS:I = 0x3

.field private static final MASK_3BITS:I = 0x7

.field private static final MASK_4BITS:I = 0xf

.field private static final MASK_5BITS:I = 0x1f

.field private static final PAD:B = 0x3dt


# instance fields
.field private final alpahbets:[B


# direct methods
.method protected constructor <init>([B)V
    .locals 0
    .param p1, "alphabets"    # [B

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    iput-object p1, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    .line 44
    return-void
.end method

.method private final decode1to4bytes(I[BI[BI)V
    .locals 9
    .param p1, "n"    # I
    .param p2, "src"    # [B
    .param p3, "s"    # I
    .param p4, "dest"    # [B
    .param p5, "d"    # I

    .line 198
    const/4 v0, 0x0

    .line 200
    .local v0, "p":I
    add-int/lit8 v1, p5, 0x1

    .end local p5    # "d":I
    .local v1, "d":I
    add-int/lit8 v2, p3, 0x1

    .end local p3    # "s":I
    .local v2, "s":I
    aget-byte p3, p2, p3

    .line 202
    invoke-virtual {p0, p3}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result p3

    const/4 v3, 0x3

    shl-int/2addr p3, v3

    add-int/lit8 v4, v2, 0x1

    .end local v2    # "s":I
    .local v4, "s":I
    aget-byte v2, p2, v2

    .line 203
    invoke-virtual {p0, v2}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v2

    move v0, v2

    const/4 v5, 0x2

    ushr-int/2addr v2, v5

    const/4 v6, 0x7

    and-int/2addr v2, v6

    or-int/2addr p3, v2

    int-to-byte p3, p3

    aput-byte p3, p4, p5

    .line 205
    const/4 p3, 0x1

    if-ne p1, p3, :cond_0

    .line 206
    invoke-static {v0, v3}, Lcom/amazonaws/util/CodecUtils;->sanityCheckLastPos(II)V

    .line 207
    return-void

    .line 210
    :cond_0
    add-int/lit8 p5, v1, 0x1

    .end local v1    # "d":I
    .restart local p5    # "d":I
    and-int/lit8 v2, v0, 0x3

    shl-int/lit8 v2, v2, 0x6

    add-int/lit8 v7, v4, 0x1

    .end local v4    # "s":I
    .local v7, "s":I
    aget-byte v4, p2, v4

    .line 213
    invoke-virtual {p0, v4}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v4

    shl-int/2addr v4, p3

    or-int/2addr v2, v4

    add-int/lit8 v4, v7, 0x1

    .end local v7    # "s":I
    .restart local v4    # "s":I
    aget-byte v7, p2, v7

    .line 214
    invoke-virtual {p0, v7}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v7

    move v0, v7

    ushr-int/lit8 v7, v7, 0x4

    and-int/2addr v7, p3

    or-int/2addr v2, v7

    int-to-byte v2, v2

    aput-byte v2, p4, v1

    .line 216
    const/16 v1, 0xf

    if-ne p1, v5, :cond_1

    .line 217
    invoke-static {v0, v1}, Lcom/amazonaws/util/CodecUtils;->sanityCheckLastPos(II)V

    .line 218
    return-void

    .line 221
    :cond_1
    add-int/lit8 v2, p5, 0x1

    .end local p5    # "d":I
    .local v2, "d":I
    and-int/lit8 v7, v0, 0xf

    shl-int/lit8 v7, v7, 0x4

    add-int/lit8 v8, v4, 0x1

    .end local v4    # "s":I
    .local v8, "s":I
    aget-byte v4, p2, v4

    .line 224
    invoke-virtual {p0, v4}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v4

    move v0, v4

    ushr-int/2addr v4, p3

    and-int/2addr v1, v4

    or-int/2addr v1, v7

    int-to-byte v1, v1

    aput-byte v1, p4, p5

    .line 226
    if-ne p1, v3, :cond_2

    .line 227
    invoke-static {v0, p3}, Lcom/amazonaws/util/CodecUtils;->sanityCheckLastPos(II)V

    .line 228
    return-void

    .line 231
    :cond_2
    and-int/lit8 p3, v0, 0x1

    shl-int/2addr p3, v6

    add-int/lit8 p5, v8, 0x1

    .end local v8    # "s":I
    .local p5, "s":I
    aget-byte v1, p2, v8

    .line 234
    invoke-virtual {p0, v1}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v1

    shl-int/2addr v1, v5

    or-int/2addr p3, v1

    aget-byte v1, p2, p5

    .line 235
    invoke-virtual {p0, v1}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v1

    move v0, v1

    ushr-int/2addr v1, v3

    and-int/2addr v1, v3

    or-int/2addr p3, v1

    int-to-byte p3, p3

    aput-byte p3, p4, v2

    .line 237
    invoke-static {v0, v6}, Lcom/amazonaws/util/CodecUtils;->sanityCheckLastPos(II)V

    .line 238
    return-void
.end method

.method private final decode5bytes([BI[BI)V
    .locals 4
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 161
    const/4 v0, 0x0

    .line 163
    .local v0, "p":I
    add-int/lit8 v1, p4, 0x1

    .end local p4    # "d":I
    .local v1, "d":I
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "s":I
    .local v2, "s":I
    aget-byte p2, p1, p2

    .line 165
    invoke-virtual {p0, p2}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result p2

    shl-int/lit8 p2, p2, 0x3

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "s":I
    .local v3, "s":I
    aget-byte v2, p1, v2

    .line 166
    invoke-virtual {p0, v2}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v2

    move v0, v2

    ushr-int/lit8 v2, v2, 0x2

    and-int/lit8 v2, v2, 0x7

    or-int/2addr p2, v2

    int-to-byte p2, p2

    aput-byte p2, p3, p4

    .line 168
    add-int/lit8 p2, v1, 0x1

    .end local v1    # "d":I
    .local p2, "d":I
    and-int/lit8 p4, v0, 0x3

    shl-int/lit8 p4, p4, 0x6

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "s":I
    .restart local v2    # "s":I
    aget-byte v3, p1, v3

    .line 171
    invoke-virtual {p0, v3}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v3

    shl-int/lit8 v3, v3, 0x1

    or-int/2addr p4, v3

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "s":I
    .restart local v3    # "s":I
    aget-byte v2, p1, v2

    .line 172
    invoke-virtual {p0, v2}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v2

    move v0, v2

    ushr-int/lit8 v2, v2, 0x4

    and-int/lit8 v2, v2, 0x1

    or-int/2addr p4, v2

    int-to-byte p4, p4

    aput-byte p4, p3, v1

    .line 174
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    and-int/lit8 v1, v0, 0xf

    shl-int/lit8 v1, v1, 0x4

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "s":I
    .restart local v2    # "s":I
    aget-byte v3, p1, v3

    .line 177
    invoke-virtual {p0, v3}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v3

    move v0, v3

    ushr-int/lit8 v3, v3, 0x1

    and-int/lit8 v3, v3, 0xf

    or-int/2addr v1, v3

    int-to-byte v1, v1

    aput-byte v1, p3, p2

    .line 179
    add-int/lit8 p2, p4, 0x1

    .end local p4    # "d":I
    .restart local p2    # "d":I
    and-int/lit8 v1, v0, 0x1

    shl-int/lit8 v1, v1, 0x7

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "s":I
    .restart local v3    # "s":I
    aget-byte v2, p1, v2

    .line 182
    invoke-virtual {p0, v2}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v2

    shl-int/lit8 v2, v2, 0x2

    or-int/2addr v1, v2

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "s":I
    .restart local v2    # "s":I
    aget-byte v3, p1, v3

    .line 183
    invoke-virtual {p0, v3}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v3

    move v0, v3

    ushr-int/lit8 v3, v3, 0x3

    and-int/lit8 v3, v3, 0x3

    or-int/2addr v1, v3

    int-to-byte v1, v1

    aput-byte v1, p3, p4

    .line 185
    and-int/lit8 p4, v0, 0x7

    shl-int/lit8 p4, p4, 0x5

    aget-byte v1, p1, v2

    .line 188
    invoke-virtual {p0, v1}, Lcom/amazonaws/util/AbstractBase32Codec;->pos(B)I

    move-result v1

    or-int/2addr p4, v1

    int-to-byte p4, p4

    aput-byte p4, p3, p2

    .line 190
    return-void
.end method

.method private final encode1byte([BI[BI)V
    .locals 4
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 152
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .local v0, "d":I
    iget-object v1, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    aget-byte v2, p1, p2

    move v3, v2

    .local v3, "p":B
    ushr-int/lit8 v2, v2, 0x3

    and-int/lit8 v2, v2, 0x1f

    aget-byte v1, v1, v2

    aput-byte v1, p3, p4

    .line 153
    add-int/lit8 p4, v0, 0x1

    .end local v0    # "d":I
    .restart local p4    # "d":I
    iget-object v1, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v2, v3, 0x7

    shl-int/lit8 v2, v2, 0x2

    aget-byte v1, v1, v2

    aput-byte v1, p3, v0

    .line 155
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/4 v1, 0x6

    if-ge v0, v1, :cond_0

    .line 156
    add-int/lit8 v1, p4, 0x1

    .end local p4    # "d":I
    .local v1, "d":I
    const/16 v2, 0x3d

    aput-byte v2, p3, p4

    .line 155
    add-int/lit8 v0, v0, 0x1

    move p4, v1

    goto :goto_0

    .line 157
    .end local v0    # "i":I
    .end local v1    # "d":I
    .restart local p4    # "d":I
    :cond_0
    return-void
.end method

.method private final encode2bytes([BI[BI)V
    .locals 5
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 138
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .local v0, "d":I
    iget-object v1, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    add-int/lit8 v2, p2, 0x1

    .end local p2    # "s":I
    .local v2, "s":I
    aget-byte p2, p1, p2

    move v3, p2

    .local v3, "p":B
    ushr-int/lit8 p2, p2, 0x3

    and-int/lit8 p2, p2, 0x1f

    aget-byte p2, v1, p2

    aput-byte p2, p3, p4

    .line 139
    add-int/lit8 p2, v0, 0x1

    .end local v0    # "d":I
    .local p2, "d":I
    iget-object p4, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x7

    shl-int/lit8 v1, v1, 0x2

    aget-byte v4, p1, v2

    move v3, v4

    ushr-int/lit8 v4, v4, 0x6

    and-int/lit8 v4, v4, 0x3

    or-int/2addr v1, v4

    aget-byte p4, p4, v1

    aput-byte p4, p3, v0

    .line 141
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    ushr-int/lit8 v1, v3, 0x1

    and-int/lit8 v1, v1, 0x1f

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 142
    add-int/lit8 p2, p4, 0x1

    .end local p4    # "d":I
    .restart local p2    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x1

    const/4 v4, 0x4

    shl-int/2addr v1, v4

    aget-byte v0, v0, v1

    aput-byte v0, p3, p4

    .line 144
    const/4 p4, 0x0

    .local p4, "i":I
    :goto_0
    if-ge p4, v4, :cond_0

    .line 145
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "d":I
    .restart local v0    # "d":I
    const/16 v1, 0x3d

    aput-byte v1, p3, p2

    .line 144
    add-int/lit8 p4, p4, 0x1

    move p2, v0

    goto :goto_0

    .line 146
    .end local v0    # "d":I
    .end local p4    # "i":I
    .restart local p2    # "d":I
    :cond_0
    return-void
.end method

.method private final encode3bytes([BI[BI)V
    .locals 6
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 122
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .local v0, "d":I
    iget-object v1, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    add-int/lit8 v2, p2, 0x1

    .end local p2    # "s":I
    .local v2, "s":I
    aget-byte p2, p1, p2

    move v3, p2

    .local v3, "p":B
    const/4 v4, 0x3

    ushr-int/2addr p2, v4

    and-int/lit8 p2, p2, 0x1f

    aget-byte p2, v1, p2

    aput-byte p2, p3, p4

    .line 123
    add-int/lit8 p2, v0, 0x1

    .end local v0    # "d":I
    .local p2, "d":I
    iget-object p4, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x7

    shl-int/lit8 v1, v1, 0x2

    add-int/lit8 v5, v2, 0x1

    .end local v2    # "s":I
    .local v5, "s":I
    aget-byte v2, p1, v2

    move v3, v2

    ushr-int/lit8 v2, v2, 0x6

    and-int/2addr v2, v4

    or-int/2addr v1, v2

    aget-byte p4, p4, v1

    aput-byte p4, p3, v0

    .line 125
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    ushr-int/lit8 v1, v3, 0x1

    and-int/lit8 v1, v1, 0x1f

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 126
    add-int/lit8 p2, p4, 0x1

    .end local p4    # "d":I
    .restart local p2    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x1

    shl-int/lit8 v1, v1, 0x4

    aget-byte v2, p1, v5

    move v3, v2

    ushr-int/lit8 v2, v2, 0x4

    and-int/lit8 v2, v2, 0xf

    or-int/2addr v1, v2

    aget-byte v0, v0, v1

    aput-byte v0, p3, p4

    .line 128
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0xf

    shl-int/lit8 v1, v1, 0x1

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 130
    const/4 p2, 0x0

    .local p2, "i":I
    :goto_0
    if-ge p2, v4, :cond_0

    .line 131
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .restart local v0    # "d":I
    const/16 v1, 0x3d

    aput-byte v1, p3, p4

    .line 130
    add-int/lit8 p2, p2, 0x1

    move p4, v0

    goto :goto_0

    .line 132
    .end local v0    # "d":I
    .end local p2    # "i":I
    .restart local p4    # "d":I
    :cond_0
    return-void
.end method

.method private final encode4bytes([BI[BI)V
    .locals 5
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 105
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .local v0, "d":I
    iget-object v1, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    add-int/lit8 v2, p2, 0x1

    .end local p2    # "s":I
    .local v2, "s":I
    aget-byte p2, p1, p2

    move v3, p2

    .local v3, "p":B
    ushr-int/lit8 p2, p2, 0x3

    and-int/lit8 p2, p2, 0x1f

    aget-byte p2, v1, p2

    aput-byte p2, p3, p4

    .line 106
    add-int/lit8 p2, v0, 0x1

    .end local v0    # "d":I
    .local p2, "d":I
    iget-object p4, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x7

    shl-int/lit8 v1, v1, 0x2

    add-int/lit8 v4, v2, 0x1

    .end local v2    # "s":I
    .local v4, "s":I
    aget-byte v2, p1, v2

    move v3, v2

    ushr-int/lit8 v2, v2, 0x6

    and-int/lit8 v2, v2, 0x3

    or-int/2addr v1, v2

    aget-byte p4, p4, v1

    aput-byte p4, p3, v0

    .line 108
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    ushr-int/lit8 v1, v3, 0x1

    and-int/lit8 v1, v1, 0x1f

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 109
    add-int/lit8 p2, p4, 0x1

    .end local p4    # "d":I
    .restart local p2    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x1

    shl-int/lit8 v1, v1, 0x4

    add-int/lit8 v2, v4, 0x1

    .end local v4    # "s":I
    .restart local v2    # "s":I
    aget-byte v4, p1, v4

    move v3, v4

    ushr-int/lit8 v4, v4, 0x4

    and-int/lit8 v4, v4, 0xf

    or-int/2addr v1, v4

    aget-byte v0, v0, v1

    aput-byte v0, p3, p4

    .line 111
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0xf

    shl-int/lit8 v1, v1, 0x1

    aget-byte v4, p1, v2

    move v3, v4

    ushr-int/lit8 v4, v4, 0x7

    and-int/lit8 v4, v4, 0x1

    or-int/2addr v1, v4

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 113
    add-int/lit8 p2, p4, 0x1

    .end local p4    # "d":I
    .restart local p2    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    ushr-int/lit8 v1, v3, 0x2

    and-int/lit8 v1, v1, 0x1f

    aget-byte v0, v0, v1

    aput-byte v0, p3, p4

    .line 114
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x3

    shl-int/lit8 v1, v1, 0x3

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 115
    const/16 p2, 0x3d

    aput-byte p2, p3, p4

    .line 116
    return-void
.end method

.method private final encode5bytes([BI[BI)V
    .locals 5
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 87
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .local v0, "d":I
    iget-object v1, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    add-int/lit8 v2, p2, 0x1

    .end local p2    # "s":I
    .local v2, "s":I
    aget-byte p2, p1, p2

    move v3, p2

    .local v3, "p":B
    ushr-int/lit8 p2, p2, 0x3

    and-int/lit8 p2, p2, 0x1f

    aget-byte p2, v1, p2

    aput-byte p2, p3, p4

    .line 88
    add-int/lit8 p2, v0, 0x1

    .end local v0    # "d":I
    .local p2, "d":I
    iget-object p4, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x7

    shl-int/lit8 v1, v1, 0x2

    add-int/lit8 v4, v2, 0x1

    .end local v2    # "s":I
    .local v4, "s":I
    aget-byte v2, p1, v2

    move v3, v2

    ushr-int/lit8 v2, v2, 0x6

    and-int/lit8 v2, v2, 0x3

    or-int/2addr v1, v2

    aget-byte p4, p4, v1

    aput-byte p4, p3, v0

    .line 90
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    ushr-int/lit8 v1, v3, 0x1

    and-int/lit8 v1, v1, 0x1f

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 91
    add-int/lit8 p2, p4, 0x1

    .end local p4    # "d":I
    .restart local p2    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x1

    shl-int/lit8 v1, v1, 0x4

    add-int/lit8 v2, v4, 0x1

    .end local v4    # "s":I
    .restart local v2    # "s":I
    aget-byte v4, p1, v4

    move v3, v4

    ushr-int/lit8 v4, v4, 0x4

    and-int/lit8 v4, v4, 0xf

    or-int/2addr v1, v4

    aget-byte v0, v0, v1

    aput-byte v0, p3, p4

    .line 93
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0xf

    shl-int/lit8 v1, v1, 0x1

    add-int/lit8 v4, v2, 0x1

    .end local v2    # "s":I
    .restart local v4    # "s":I
    aget-byte v2, p1, v2

    move v3, v2

    ushr-int/lit8 v2, v2, 0x7

    and-int/lit8 v2, v2, 0x1

    or-int/2addr v1, v2

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 95
    add-int/lit8 p2, p4, 0x1

    .end local p4    # "d":I
    .restart local p2    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    ushr-int/lit8 v1, v3, 0x2

    and-int/lit8 v1, v1, 0x1f

    aget-byte v0, v0, v1

    aput-byte v0, p3, p4

    .line 96
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x3

    shl-int/lit8 v1, v1, 0x3

    aget-byte v2, p1, v4

    move v3, v2

    ushr-int/lit8 v2, v2, 0x5

    and-int/lit8 v2, v2, 0x7

    or-int/2addr v1, v2

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 98
    iget-object p2, p0, Lcom/amazonaws/util/AbstractBase32Codec;->alpahbets:[B

    and-int/lit8 v0, v3, 0x1f

    aget-byte p2, p2, v0

    aput-byte p2, p3, p4

    .line 99
    return-void
.end method


# virtual methods
.method public final decode([BI)[B
    .locals 12
    .param p1, "src"    # [B
    .param p2, "length"    # I

    .line 243
    rem-int/lit8 v0, p2, 0x8

    if-nez v0, :cond_4

    .line 247
    const/4 v0, 0x0

    .line 248
    .local v0, "pads":I
    add-int/lit8 v1, p2, -0x1

    .line 251
    .local v1, "last":I
    :goto_0
    const/4 v2, 0x6

    if-ge v0, v2, :cond_1

    const/4 v2, -0x1

    if-le v1, v2, :cond_1

    .line 252
    aget-byte v2, p1, v1

    const/16 v3, 0x3d

    if-eq v2, v3, :cond_0

    .line 253
    goto :goto_1

    .line 251
    :cond_0
    add-int/lit8 v1, v1, -0x1

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 258
    :cond_1
    :goto_1
    packed-switch v0, :pswitch_data_0

    .line 276
    :pswitch_0
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Invalid number of paddings "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 273
    :pswitch_1
    const/4 v2, 0x1

    .line 274
    .local v2, "fq":I
    goto :goto_2

    .line 270
    .end local v2    # "fq":I
    :pswitch_2
    const/4 v2, 0x2

    .line 271
    .restart local v2    # "fq":I
    goto :goto_2

    .line 267
    .end local v2    # "fq":I
    :pswitch_3
    const/4 v2, 0x3

    .line 268
    .restart local v2    # "fq":I
    goto :goto_2

    .line 264
    .end local v2    # "fq":I
    :pswitch_4
    const/4 v2, 0x4

    .line 265
    .restart local v2    # "fq":I
    goto :goto_2

    .line 260
    .end local v2    # "fq":I
    :pswitch_5
    const/4 v2, 0x5

    .line 261
    .restart local v2    # "fq":I
    nop

    .line 278
    :goto_2
    div-int/lit8 v3, p2, 0x8

    const/4 v4, 0x5

    mul-int/2addr v3, v4

    rsub-int/lit8 v5, v2, 0x5

    sub-int/2addr v3, v5

    new-array v9, v3, [B

    .line 279
    .local v9, "dest":[B
    const/4 v3, 0x0

    .local v3, "s":I
    const/4 v5, 0x0

    move v10, v3

    move v11, v5

    .line 282
    .end local v3    # "s":I
    .local v10, "s":I
    .local v11, "d":I
    :goto_3
    array-length v3, v9

    rem-int/lit8 v5, v2, 0x5

    sub-int/2addr v3, v5

    if-ge v11, v3, :cond_2

    .line 283
    invoke-direct {p0, p1, v10, v9, v11}, Lcom/amazonaws/util/AbstractBase32Codec;->decode5bytes([BI[BI)V

    .line 282
    add-int/lit8 v10, v10, 0x8

    add-int/lit8 v11, v11, 0x5

    goto :goto_3

    .line 285
    :cond_2
    if-ge v2, v4, :cond_3

    .line 286
    move-object v3, p0

    move v4, v2

    move-object v5, p1

    move v6, v10

    move-object v7, v9

    move v8, v11

    invoke-direct/range {v3 .. v8}, Lcom/amazonaws/util/AbstractBase32Codec;->decode1to4bytes(I[BI[BI)V

    .line 287
    :cond_3
    return-object v9

    .line 244
    .end local v0    # "pads":I
    .end local v1    # "last":I
    .end local v2    # "fq":I
    .end local v9    # "dest":[B
    .end local v10    # "s":I
    .end local v11    # "d":I
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Input is expected to be encoded in multiple of 8 bytes but found: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public final encode([B)[B
    .locals 6
    .param p1, "src"    # [B

    .line 48
    array-length v0, p1

    div-int/lit8 v0, v0, 0x5

    .line 49
    .local v0, "num5bytes":I
    array-length v1, p1

    rem-int/lit8 v1, v1, 0x5

    .line 51
    .local v1, "remainder":I
    if-nez v1, :cond_1

    .line 52
    mul-int/lit8 v2, v0, 0x8

    new-array v2, v2, [B

    .line 54
    .local v2, "dest":[B
    const/4 v3, 0x0

    .local v3, "s":I
    const/4 v4, 0x0

    .local v4, "d":I
    :goto_0
    array-length v5, p1

    if-ge v3, v5, :cond_0

    .line 55
    invoke-direct {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/AbstractBase32Codec;->encode5bytes([BI[BI)V

    .line 54
    add-int/lit8 v3, v3, 0x5

    add-int/lit8 v4, v4, 0x8

    goto :goto_0

    .line 56
    .end local v3    # "s":I
    .end local v4    # "d":I
    :cond_0
    return-object v2

    .line 59
    .end local v2    # "dest":[B
    :cond_1
    add-int/lit8 v2, v0, 0x1

    mul-int/lit8 v2, v2, 0x8

    new-array v2, v2, [B

    .line 60
    .restart local v2    # "dest":[B
    const/4 v3, 0x0

    .restart local v3    # "s":I
    const/4 v4, 0x0

    .line 62
    .restart local v4    # "d":I
    :goto_1
    array-length v5, p1

    sub-int/2addr v5, v1

    if-ge v3, v5, :cond_2

    .line 63
    invoke-direct {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/AbstractBase32Codec;->encode5bytes([BI[BI)V

    .line 62
    add-int/lit8 v3, v3, 0x5

    add-int/lit8 v4, v4, 0x8

    goto :goto_1

    .line 65
    :cond_2
    packed-switch v1, :pswitch_data_0

    goto :goto_2

    .line 76
    :pswitch_0
    invoke-direct {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/AbstractBase32Codec;->encode4bytes([BI[BI)V

    .line 77
    goto :goto_2

    .line 73
    :pswitch_1
    invoke-direct {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/AbstractBase32Codec;->encode3bytes([BI[BI)V

    .line 74
    goto :goto_2

    .line 70
    :pswitch_2
    invoke-direct {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/AbstractBase32Codec;->encode2bytes([BI[BI)V

    .line 71
    goto :goto_2

    .line 67
    :pswitch_3
    invoke-direct {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/AbstractBase32Codec;->encode1byte([BI[BI)V

    .line 68
    nop

    .line 81
    :goto_2
    return-object v2

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected abstract pos(B)I
.end method
