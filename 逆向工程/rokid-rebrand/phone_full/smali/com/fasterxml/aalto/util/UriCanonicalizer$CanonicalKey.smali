.class final Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;
.super Ljava/lang/Object;
.source "UriCanonicalizer.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/util/UriCanonicalizer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "CanonicalKey"
.end annotation


# instance fields
.field final mChars:[C

.field final mHash:I

.field final mLength:I


# direct methods
.method public constructor <init>([CI)V
    .locals 1
    .param p1, "buffer"    # [C
    .param p2, "len"    # I

    .line 99
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 100
    iput-object p1, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mChars:[C

    .line 101
    iput p2, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mLength:I

    .line 102
    invoke-static {p1, p2}, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->calcKeyHash([CI)I

    move-result v0

    iput v0, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mHash:I

    .line 103
    return-void
.end method

.method public constructor <init>([CII)V
    .locals 0
    .param p1, "buffer"    # [C
    .param p2, "len"    # I
    .param p3, "hashCode"    # I

    .line 106
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 107
    iput-object p1, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mChars:[C

    .line 108
    iput p2, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mLength:I

    .line 109
    iput p3, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mHash:I

    .line 110
    return-void
.end method

.method public static calcKeyHash([CI)I
    .locals 7
    .param p0, "buffer"    # [C
    .param p1, "len"    # I

    .line 125
    const/16 v0, 0x8

    const/4 v1, 0x0

    if-gt p1, v0, :cond_1

    .line 126
    aget-char v0, p0, v1

    .line 128
    .local v0, "hash":I
    const/4 v1, 0x1

    .local v1, "i":I
    :goto_0
    if-ge v1, p1, :cond_0

    .line 129
    mul-int/lit8 v2, v0, 0x1f

    aget-char v3, p0, v1

    add-int v0, v2, v3

    .line 128
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 131
    .end local v1    # "i":I
    :cond_0
    return v0

    .line 138
    .end local v0    # "hash":I
    :cond_1
    aget-char v0, p0, v1

    xor-int/2addr v0, p1

    .line 147
    .restart local v0    # "hash":I
    const/4 v1, 0x2

    .line 148
    .local v1, "ix":I
    const/4 v2, 0x2

    .line 149
    .local v2, "dist":I
    add-int/lit8 v3, p1, -0x4

    .line 151
    .local v3, "end":I
    :goto_1
    if-ge v1, v3, :cond_2

    .line 152
    mul-int/lit8 v4, v0, 0x1f

    aget-char v5, p0, v1

    add-int v0, v4, v5

    .line 153
    add-int/2addr v1, v2

    .line 154
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 158
    :cond_2
    mul-int/lit8 v4, v0, 0x1f

    aget-char v5, p0, v3

    shl-int/lit8 v5, v5, 0x2

    add-int/lit8 v6, v3, 0x1

    aget-char v6, p0, v6

    add-int/2addr v5, v6

    xor-int v0, v4, v5

    .line 159
    mul-int/lit8 v4, v0, 0x1f

    add-int/lit8 v5, v3, 0x2

    aget-char v5, p0, v5

    shl-int/lit8 v5, v5, 0x2

    add-int/2addr v4, v5

    add-int/lit8 v5, v3, 0x3

    aget-char v5, p0, v5

    xor-int v0, v4, v5

    .line 160
    return v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 9
    .param p1, "o"    # Ljava/lang/Object;

    .line 172
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 173
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    .line 174
    :cond_1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_2

    return v1

    .line 176
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;

    .line 177
    .local v2, "other":Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;
    iget v3, v2, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mLength:I

    iget v4, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mLength:I

    if-eq v3, v4, :cond_3

    return v1

    .line 178
    :cond_3
    iget-object v3, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mChars:[C

    .line 179
    .local v3, "c1":[C
    iget-object v4, v2, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mChars:[C

    .line 180
    .local v4, "c2":[C
    const/4 v5, 0x0

    .local v5, "i":I
    iget v6, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mLength:I

    .local v6, "len":I
    :goto_0
    if-ge v5, v6, :cond_5

    .line 181
    aget-char v7, v3, v5

    aget-char v8, v4, v5

    if-eq v7, v8, :cond_4

    .line 182
    return v1

    .line 180
    :cond_4
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 185
    .end local v5    # "i":I
    .end local v6    # "len":I
    :cond_5
    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 167
    iget v0, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mHash:I

    return v0
.end method

.method public safeClone()Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;
    .locals 4

    .line 114
    iget v0, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mLength:I

    new-array v0, v0, [C

    .line 115
    .local v0, "newBuf":[C
    iget-object v1, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mChars:[C

    const/4 v2, 0x0

    iget v3, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mLength:I

    invoke-static {v1, v2, v0, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 116
    new-instance v1, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;

    iget v2, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mLength:I

    iget v3, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mHash:I

    invoke-direct {v1, v0, v2, v3}, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;-><init>([CII)V

    return-object v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 164
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v1, "{URI, hash: 0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;->mHash:I

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
