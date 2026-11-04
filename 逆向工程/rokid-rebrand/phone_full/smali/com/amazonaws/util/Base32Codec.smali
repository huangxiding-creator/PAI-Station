.class Lcom/amazonaws/util/Base32Codec;
.super Lcom/amazonaws/util/AbstractBase32Codec;
.source "Base32Codec.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/util/Base32Codec$LazyHolder;
    }
.end annotation


# static fields
.field private static final OFFSET:I = 0x1a

.field private static final OFFSET_OF_2:I = 0x18


# direct methods
.method constructor <init>()V
    .locals 1

    .line 53
    invoke-static {}, Lcom/amazonaws/util/Base32Codec;->alphabets()[B

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/amazonaws/util/AbstractBase32Codec;-><init>([B)V

    .line 54
    return-void
.end method

.method private static alphabets()[B
    .locals 1

    .line 49
    const-string v0, "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"

    invoke-static {v0}, Lcom/amazonaws/util/CodecUtils;->toBytesDirect(Ljava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method protected pos(B)I
    .locals 4
    .param p1, "in"    # B

    .line 58
    invoke-static {}, Lcom/amazonaws/util/Base32Codec$LazyHolder;->access$000()[B

    move-result-object v0

    aget-byte v0, v0, p1

    .line 60
    .local v0, "pos":I
    const/4 v1, -0x1

    if-le v0, v1, :cond_0

    .line 61
    return v0

    .line 62
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid base 32 character: \'"

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
