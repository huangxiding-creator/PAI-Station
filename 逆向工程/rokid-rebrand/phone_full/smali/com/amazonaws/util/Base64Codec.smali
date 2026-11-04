.class Lcom/amazonaws/util/Base64Codec;
.super Ljava/lang/Object;
.source "Base64Codec.java"

# interfaces
.implements Lcom/amazonaws/util/Codec;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/util/Base64Codec$LazyHolder;
    }
.end annotation


# static fields
.field private static final BITS_3:I = 0x3

.field private static final BITS_4:I = 0x4

.field private static final BITS_6:I = 0x6

.field private static final MASK_2BITS:I = 0x3

.field private static final MASK_4BITS:I = 0xf

.field private static final MASK_6BITS:I = 0x3f

.field private static final OFFSET_0_VALUE:I = 0x34

.field private static final OFFSET_OF_0:I = -0x4

.field private static final OFFSET_OF_PLUS:I = -0x13

.field private static final OFFSET_OF_SLASH:I = -0x10

.field private static final OFFSET_OF_a:I = 0x47

.field private static final OFFSET_PLUS_VALUE:I = 0x3e

.field private static final OFFSET_SLASH_VALUE:I = 0x3f

.field private static final OFFSET_a_VALUE:I = 0x1a

.field private static final PAD:B = 0x3dt


# instance fields
.field private final alpahbets:[B


# direct methods
.method constructor <init>()V
    .locals 1

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    nop

    .line 76
    const-string v0, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

    invoke-static {v0}, Lcom/amazonaws/util/CodecUtils;->toBytesDirect(Ljava/lang/String;)[B

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    .line 77
    return-void
.end method

.method protected constructor <init>([B)V
    .locals 0
    .param p1, "alphabets"    # [B

    .line 79
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 80
    iput-object p1, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    .line 81
    return-void
.end method


# virtual methods
.method public decode([BI)[B
    .locals 12
    .param p1, "src"    # [B
    .param p2, "length"    # I

    .line 206
    rem-int/lit8 v0, p2, 0x4

    if-nez v0, :cond_4

    .line 210
    const/4 v0, 0x0

    .line 211
    .local v0, "pads":I
    add-int/lit8 v1, p2, -0x1

    .line 214
    .local v1, "last":I
    :goto_0
    const/4 v2, 0x2

    if-ge v0, v2, :cond_1

    const/4 v2, -0x1

    if-le v1, v2, :cond_1

    .line 215
    aget-byte v2, p1, v1

    const/16 v3, 0x3d

    if-eq v2, v3, :cond_0

    .line 216
    goto :goto_1

    .line 214
    :cond_0
    add-int/lit8 v1, v1, -0x1

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 221
    :cond_1
    :goto_1
    packed-switch v0, :pswitch_data_0

    .line 233
    new-instance v2, Ljava/lang/Error;

    const-string v3, "Impossible"

    invoke-direct {v2, v3}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v2

    .line 230
    :pswitch_0
    const/4 v2, 0x1

    .line 231
    .local v2, "fq":I
    goto :goto_2

    .line 227
    .end local v2    # "fq":I
    :pswitch_1
    const/4 v2, 0x2

    .line 228
    .restart local v2    # "fq":I
    goto :goto_2

    .line 223
    .end local v2    # "fq":I
    :pswitch_2
    const/4 v2, 0x3

    .line 224
    .restart local v2    # "fq":I
    nop

    .line 235
    :goto_2
    div-int/lit8 v3, p2, 0x4

    const/4 v4, 0x3

    mul-int/2addr v3, v4

    rsub-int/lit8 v5, v2, 0x3

    sub-int/2addr v3, v5

    new-array v9, v3, [B

    .line 236
    .local v9, "dest":[B
    const/4 v3, 0x0

    .local v3, "s":I
    const/4 v5, 0x0

    move v10, v3

    move v11, v5

    .line 239
    .end local v3    # "s":I
    .local v10, "s":I
    .local v11, "d":I
    :goto_3
    array-length v3, v9

    rem-int/lit8 v5, v2, 0x3

    sub-int/2addr v3, v5

    if-ge v11, v3, :cond_2

    .line 240
    invoke-virtual {p0, p1, v10, v9, v11}, Lcom/amazonaws/util/Base64Codec;->decode4bytes([BI[BI)V

    .line 239
    add-int/lit8 v10, v10, 0x4

    add-int/lit8 v11, v11, 0x3

    goto :goto_3

    .line 243
    :cond_2
    if-ge v2, v4, :cond_3

    .line 244
    move-object v3, p0

    move v4, v2

    move-object v5, p1

    move v6, v10

    move-object v7, v9

    move v8, v11

    invoke-virtual/range {v3 .. v8}, Lcom/amazonaws/util/Base64Codec;->decode1to3bytes(I[BI[BI)V

    .line 246
    :cond_3
    return-object v9

    .line 207
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

    const-string v2, "Input is expected to be encoded in multiple of 4 bytes but found: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method decode1to3bytes(I[BI[BI)V
    .locals 7
    .param p1, "n"    # I
    .param p2, "src"    # [B
    .param p3, "s"    # I
    .param p4, "dest"    # [B
    .param p5, "d"    # I

    .line 174
    const/4 v0, 0x0

    .line 176
    .local v0, "p":I
    add-int/lit8 v1, p5, 0x1

    .end local p5    # "d":I
    .local v1, "d":I
    add-int/lit8 v2, p3, 0x1

    .end local p3    # "s":I
    .local v2, "s":I
    aget-byte p3, p2, p3

    .line 178
    invoke-virtual {p0, p3}, Lcom/amazonaws/util/Base64Codec;->pos(B)I

    move-result p3

    const/4 v3, 0x2

    shl-int/2addr p3, v3

    add-int/lit8 v4, v2, 0x1

    .end local v2    # "s":I
    .local v4, "s":I
    aget-byte v2, p2, v2

    .line 179
    invoke-virtual {p0, v2}, Lcom/amazonaws/util/Base64Codec;->pos(B)I

    move-result v2

    move v0, v2

    ushr-int/lit8 v2, v2, 0x4

    const/4 v5, 0x3

    and-int/2addr v2, v5

    or-int/2addr p3, v2

    int-to-byte p3, p3

    aput-byte p3, p4, p5

    .line 181
    const/16 p3, 0xf

    const/4 p5, 0x1

    if-ne p1, p5, :cond_0

    .line 182
    invoke-static {v0, p3}, Lcom/amazonaws/util/CodecUtils;->sanityCheckLastPos(II)V

    .line 183
    return-void

    .line 186
    :cond_0
    add-int/lit8 p5, v1, 0x1

    .end local v1    # "d":I
    .restart local p5    # "d":I
    and-int/lit8 v2, v0, 0xf

    shl-int/lit8 v2, v2, 0x4

    add-int/lit8 v6, v4, 0x1

    .end local v4    # "s":I
    .local v6, "s":I
    aget-byte v4, p2, v4

    .line 189
    invoke-virtual {p0, v4}, Lcom/amazonaws/util/Base64Codec;->pos(B)I

    move-result v4

    move v0, v4

    ushr-int/2addr v4, v3

    and-int/2addr p3, v4

    or-int/2addr p3, v2

    int-to-byte p3, p3

    aput-byte p3, p4, v1

    .line 191
    if-ne p1, v3, :cond_1

    .line 192
    invoke-static {v0, v5}, Lcom/amazonaws/util/CodecUtils;->sanityCheckLastPos(II)V

    .line 193
    return-void

    .line 196
    :cond_1
    and-int/lit8 p3, v0, 0x3

    shl-int/lit8 p3, p3, 0x6

    aget-byte v1, p2, v6

    .line 199
    invoke-virtual {p0, v1}, Lcom/amazonaws/util/Base64Codec;->pos(B)I

    move-result v1

    or-int/2addr p3, v1

    int-to-byte p3, p3

    aput-byte p3, p4, p5

    .line 201
    return-void
.end method

.method decode4bytes([BI[BI)V
    .locals 4
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 149
    const/4 v0, 0x0

    .line 151
    .local v0, "p":I
    add-int/lit8 v1, p4, 0x1

    .end local p4    # "d":I
    .local v1, "d":I
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "s":I
    .local v2, "s":I
    aget-byte p2, p1, p2

    .line 153
    invoke-virtual {p0, p2}, Lcom/amazonaws/util/Base64Codec;->pos(B)I

    move-result p2

    shl-int/lit8 p2, p2, 0x2

    add-int/lit8 v3, v2, 0x1

    .end local v2    # "s":I
    .local v3, "s":I
    aget-byte v2, p1, v2

    .line 154
    invoke-virtual {p0, v2}, Lcom/amazonaws/util/Base64Codec;->pos(B)I

    move-result v2

    move v0, v2

    ushr-int/lit8 v2, v2, 0x4

    and-int/lit8 v2, v2, 0x3

    or-int/2addr p2, v2

    int-to-byte p2, p2

    aput-byte p2, p3, p4

    .line 156
    add-int/lit8 p2, v1, 0x1

    .end local v1    # "d":I
    .local p2, "d":I
    and-int/lit8 p4, v0, 0xf

    shl-int/lit8 p4, p4, 0x4

    add-int/lit8 v2, v3, 0x1

    .end local v3    # "s":I
    .restart local v2    # "s":I
    aget-byte v3, p1, v3

    .line 159
    invoke-virtual {p0, v3}, Lcom/amazonaws/util/Base64Codec;->pos(B)I

    move-result v3

    move v0, v3

    ushr-int/lit8 v3, v3, 0x2

    and-int/lit8 v3, v3, 0xf

    or-int/2addr p4, v3

    int-to-byte p4, p4

    aput-byte p4, p3, v1

    .line 161
    and-int/lit8 p4, v0, 0x3

    shl-int/lit8 p4, p4, 0x6

    aget-byte v1, p1, v2

    .line 164
    invoke-virtual {p0, v1}, Lcom/amazonaws/util/Base64Codec;->pos(B)I

    move-result v1

    or-int/2addr p4, v1

    int-to-byte p4, p4

    aput-byte p4, p3, p2

    .line 166
    return-void
.end method

.method public encode([B)[B
    .locals 6
    .param p1, "src"    # [B

    .line 85
    array-length v0, p1

    div-int/lit8 v0, v0, 0x3

    .line 86
    .local v0, "num3bytes":I
    array-length v1, p1

    rem-int/lit8 v1, v1, 0x3

    .line 88
    .local v1, "remainder":I
    if-nez v1, :cond_1

    .line 89
    mul-int/lit8 v2, v0, 0x4

    new-array v2, v2, [B

    .line 91
    .local v2, "dest":[B
    const/4 v3, 0x0

    .local v3, "s":I
    const/4 v4, 0x0

    .local v4, "d":I
    :goto_0
    array-length v5, p1

    if-ge v3, v5, :cond_0

    .line 92
    invoke-virtual {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/Base64Codec;->encode3bytes([BI[BI)V

    .line 91
    add-int/lit8 v3, v3, 0x3

    add-int/lit8 v4, v4, 0x4

    goto :goto_0

    .line 93
    .end local v3    # "s":I
    .end local v4    # "d":I
    :cond_0
    return-object v2

    .line 96
    .end local v2    # "dest":[B
    :cond_1
    add-int/lit8 v2, v0, 0x1

    mul-int/lit8 v2, v2, 0x4

    new-array v2, v2, [B

    .line 97
    .restart local v2    # "dest":[B
    const/4 v3, 0x0

    .restart local v3    # "s":I
    const/4 v4, 0x0

    .line 99
    .restart local v4    # "d":I
    :goto_1
    array-length v5, p1

    sub-int/2addr v5, v1

    if-ge v3, v5, :cond_2

    .line 100
    invoke-virtual {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/Base64Codec;->encode3bytes([BI[BI)V

    .line 99
    add-int/lit8 v3, v3, 0x3

    add-int/lit8 v4, v4, 0x4

    goto :goto_1

    .line 102
    :cond_2
    packed-switch v1, :pswitch_data_0

    goto :goto_2

    .line 107
    :pswitch_0
    invoke-virtual {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/Base64Codec;->encode2bytes([BI[BI)V

    .line 108
    goto :goto_2

    .line 104
    :pswitch_1
    invoke-virtual {p0, p1, v3, v2, v4}, Lcom/amazonaws/util/Base64Codec;->encode1byte([BI[BI)V

    .line 105
    nop

    .line 112
    :goto_2
    return-object v2

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method encode1byte([BI[BI)V
    .locals 4
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 141
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .local v0, "d":I
    iget-object v1, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    aget-byte v2, p1, p2

    move v3, v2

    .local v3, "p":B
    ushr-int/lit8 v2, v2, 0x2

    and-int/lit8 v2, v2, 0x3f

    aget-byte v1, v1, v2

    aput-byte v1, p3, p4

    .line 142
    add-int/lit8 p4, v0, 0x1

    .end local v0    # "d":I
    .restart local p4    # "d":I
    iget-object v1, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    and-int/lit8 v2, v3, 0x3

    shl-int/lit8 v2, v2, 0x4

    aget-byte v1, v1, v2

    aput-byte v1, p3, v0

    .line 143
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .restart local v0    # "d":I
    const/16 v1, 0x3d

    aput-byte v1, p3, p4

    .line 144
    aput-byte v1, p3, v0

    .line 145
    return-void
.end method

.method encode2bytes([BI[BI)V
    .locals 5
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 130
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .local v0, "d":I
    iget-object v1, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    add-int/lit8 v2, p2, 0x1

    .end local p2    # "s":I
    .local v2, "s":I
    aget-byte p2, p1, p2

    move v3, p2

    .local v3, "p":B
    ushr-int/lit8 p2, p2, 0x2

    and-int/lit8 p2, p2, 0x3f

    aget-byte p2, v1, p2

    aput-byte p2, p3, p4

    .line 131
    add-int/lit8 p2, v0, 0x1

    .end local v0    # "d":I
    .local p2, "d":I
    iget-object p4, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x3

    shl-int/lit8 v1, v1, 0x4

    aget-byte v4, p1, v2

    move v3, v4

    ushr-int/lit8 v4, v4, 0x4

    and-int/lit8 v4, v4, 0xf

    or-int/2addr v1, v4

    aget-byte p4, p4, v1

    aput-byte p4, p3, v0

    .line 133
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0xf

    shl-int/lit8 v1, v1, 0x2

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 134
    const/16 p2, 0x3d

    aput-byte p2, p3, p4

    .line 135
    return-void
.end method

.method encode3bytes([BI[BI)V
    .locals 5
    .param p1, "src"    # [B
    .param p2, "s"    # I
    .param p3, "dest"    # [B
    .param p4, "d"    # I

    .line 118
    add-int/lit8 v0, p4, 0x1

    .end local p4    # "d":I
    .local v0, "d":I
    iget-object v1, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    add-int/lit8 v2, p2, 0x1

    .end local p2    # "s":I
    .local v2, "s":I
    aget-byte p2, p1, p2

    move v3, p2

    .local v3, "p":B
    ushr-int/lit8 p2, p2, 0x2

    and-int/lit8 p2, p2, 0x3f

    aget-byte p2, v1, p2

    aput-byte p2, p3, p4

    .line 119
    add-int/lit8 p2, v0, 0x1

    .end local v0    # "d":I
    .local p2, "d":I
    iget-object p4, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0x3

    shl-int/lit8 v1, v1, 0x4

    add-int/lit8 v4, v2, 0x1

    .end local v2    # "s":I
    .local v4, "s":I
    aget-byte v2, p1, v2

    move v3, v2

    ushr-int/lit8 v2, v2, 0x4

    and-int/lit8 v2, v2, 0xf

    or-int/2addr v1, v2

    aget-byte p4, p4, v1

    aput-byte p4, p3, v0

    .line 121
    add-int/lit8 p4, p2, 0x1

    .end local p2    # "d":I
    .restart local p4    # "d":I
    iget-object v0, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    and-int/lit8 v1, v3, 0xf

    shl-int/lit8 v1, v1, 0x2

    aget-byte v2, p1, v4

    move v3, v2

    ushr-int/lit8 v2, v2, 0x6

    and-int/lit8 v2, v2, 0x3

    or-int/2addr v1, v2

    aget-byte v0, v0, v1

    aput-byte v0, p3, p2

    .line 123
    iget-object p2, p0, Lcom/amazonaws/util/Base64Codec;->alpahbets:[B

    and-int/lit8 v0, v3, 0x3f

    aget-byte p2, p2, v0

    aput-byte p2, p3, p4

    .line 124
    return-void
.end method

.method protected pos(B)I
    .locals 4
    .param p1, "in"    # B

    .line 250
    invoke-static {}, Lcom/amazonaws/util/Base64Codec$LazyHolder;->access$000()[B

    move-result-object v0

    aget-byte v0, v0, p1

    .line 252
    .local v0, "pos":I
    const/4 v1, -0x1

    if-le v0, v1, :cond_0

    .line 253
    return v0

    .line 254
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid base 64 character: \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    int-to-char v3, p1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method
