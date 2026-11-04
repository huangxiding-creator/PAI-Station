.class Lcom/amazonaws/util/Base16Codec;
.super Ljava/lang/Object;
.source "Base16Codec.java"

# interfaces
.implements Lcom/amazonaws/util/Codec;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/util/Base16Codec$LazyHolder;
    }
.end annotation


# static fields
.field private static final BITS_4:I = 0x4

.field private static final MASK_4BITS:I = 0xf

.field private static final OFFSET_OF_A:I = 0x37

.field private static final OFFSET_OF_a:I = 0x57

.field private static final OFFSET_VALUE:I = 0xa


# instance fields
.field private final alpahbets:[B


# direct methods
.method constructor <init>()V
    .locals 1

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 52
    const-string v0, "0123456789ABCDEF"

    invoke-static {v0}, Lcom/amazonaws/util/CodecUtils;->toBytesDirect(Ljava/lang/String;)[B

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/util/Base16Codec;->alpahbets:[B

    return-void
.end method


# virtual methods
.method public decode([BI)[B
    .locals 5
    .param p1, "src"    # [B
    .param p2, "length"    # I

    .line 69
    rem-int/lit8 v0, p2, 0x2

    if-nez v0, :cond_1

    .line 74
    div-int/lit8 v0, p2, 0x2

    new-array v0, v0, [B

    .line 76
    .local v0, "dest":[B
    const/4 v1, 0x0

    .local v1, "i":I
    const/4 v2, 0x0

    .local v2, "j":I
    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_0

    .line 77
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "i":I
    .local v3, "i":I
    aget-byte v1, p1, v1

    .line 79
    invoke-virtual {p0, v1}, Lcom/amazonaws/util/Base16Codec;->pos(B)I

    move-result v1

    shl-int/lit8 v1, v1, 0x4

    add-int/lit8 v4, v3, 0x1

    .end local v3    # "i":I
    .local v4, "i":I
    aget-byte v3, p1, v3

    invoke-virtual {p0, v3}, Lcom/amazonaws/util/Base16Codec;->pos(B)I

    move-result v3

    or-int/2addr v1, v3

    int-to-byte v1, v1

    aput-byte v1, v0, v2

    .line 76
    add-int/lit8 v2, v2, 0x1

    move v1, v4

    goto :goto_0

    .line 83
    .end local v2    # "j":I
    .end local v4    # "i":I
    :cond_0
    return-object v0

    .line 70
    .end local v0    # "dest":[B
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Input is expected to be encoded in multiple of 2 bytes but found: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public encode([B)[B
    .locals 7
    .param p1, "src"    # [B

    .line 57
    array-length v0, p1

    mul-int/lit8 v0, v0, 0x2

    new-array v0, v0, [B

    .line 60
    .local v0, "dest":[B
    const/4 v1, 0x0

    .local v1, "i":I
    const/4 v2, 0x0

    .local v2, "j":I
    :goto_0
    array-length v3, p1

    if-ge v1, v3, :cond_0

    .line 61
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "j":I
    .local v3, "j":I
    iget-object v4, p0, Lcom/amazonaws/util/Base16Codec;->alpahbets:[B

    aget-byte v5, p1, v1

    move v6, v5

    .local v6, "p":B
    ushr-int/lit8 v5, v5, 0x4

    and-int/lit8 v5, v5, 0xf

    aget-byte v4, v4, v5

    aput-byte v4, v0, v2

    .line 62
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "j":I
    .restart local v2    # "j":I
    iget-object v4, p0, Lcom/amazonaws/util/Base16Codec;->alpahbets:[B

    and-int/lit8 v5, v6, 0xf

    aget-byte v4, v4, v5

    aput-byte v4, v0, v3

    .line 60
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 64
    .end local v1    # "i":I
    .end local v2    # "j":I
    .end local v6    # "p":B
    :cond_0
    return-object v0
.end method

.method protected pos(B)I
    .locals 4
    .param p1, "in"    # B

    .line 87
    invoke-static {}, Lcom/amazonaws/util/Base16Codec$LazyHolder;->access$000()[B

    move-result-object v0

    aget-byte v0, v0, p1

    .line 89
    .local v0, "pos":I
    const/4 v1, -0x1

    if-le v0, v1, :cond_0

    .line 90
    return v0

    .line 92
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid base 16 character: \'"

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
