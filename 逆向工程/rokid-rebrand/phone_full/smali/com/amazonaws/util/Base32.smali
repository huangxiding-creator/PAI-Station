.class public final enum Lcom/amazonaws/util/Base32;
.super Ljava/lang/Enum;
.source "Base32.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/util/Base32;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/util/Base32;

.field private static final CODEC:Lcom/amazonaws/util/Base32Codec;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 23
    const/4 v0, 0x0

    new-array v0, v0, [Lcom/amazonaws/util/Base32;

    sput-object v0, Lcom/amazonaws/util/Base32;->$VALUES:[Lcom/amazonaws/util/Base32;

    .line 26
    new-instance v0, Lcom/amazonaws/util/Base32Codec;

    invoke-direct {v0}, Lcom/amazonaws/util/Base32Codec;-><init>()V

    sput-object v0, Lcom/amazonaws/util/Base32;->CODEC:Lcom/amazonaws/util/Base32Codec;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 24
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static decode(Ljava/lang/String;)[B
    .locals 3
    .param p0, "b32"    # Ljava/lang/String;

    .line 57
    if-nez p0, :cond_0

    .line 58
    const/4 v0, 0x0

    return-object v0

    .line 60
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 61
    const/4 v0, 0x0

    new-array v0, v0, [B

    return-object v0

    .line 63
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v0, v0, [B

    .line 64
    .local v0, "buf":[B
    invoke-static {p0, v0}, Lcom/amazonaws/util/CodecUtils;->sanitize(Ljava/lang/String;[B)I

    move-result v1

    .line 65
    .local v1, "len":I
    sget-object v2, Lcom/amazonaws/util/Base32;->CODEC:Lcom/amazonaws/util/Base32Codec;

    invoke-virtual {v2, v0, v1}, Lcom/amazonaws/util/Base32Codec;->decode([BI)[B

    move-result-object v2

    return-object v2
.end method

.method public static decode([B)[B
    .locals 2
    .param p0, "b32"    # [B

    .line 74
    if-eqz p0, :cond_1

    array-length v0, p0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/amazonaws/util/Base32;->CODEC:Lcom/amazonaws/util/Base32Codec;

    array-length v1, p0

    invoke-virtual {v0, p0, v1}, Lcom/amazonaws/util/Base32Codec;->decode([BI)[B

    move-result-object v0

    goto :goto_1

    :cond_1
    :goto_0
    move-object v0, p0

    :goto_1
    return-object v0
.end method

.method public static encode([B)[B
    .locals 1
    .param p0, "bytes"    # [B

    .line 46
    if-eqz p0, :cond_1

    array-length v0, p0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/amazonaws/util/Base32;->CODEC:Lcom/amazonaws/util/Base32Codec;

    invoke-virtual {v0, p0}, Lcom/amazonaws/util/Base32Codec;->encode([B)[B

    move-result-object v0

    goto :goto_1

    :cond_1
    :goto_0
    move-object v0, p0

    :goto_1
    return-object v0
.end method

.method public static varargs encodeAsString([B)Ljava/lang/String;
    .locals 1
    .param p0, "bytes"    # [B

    .line 33
    if-nez p0, :cond_0

    .line 34
    const/4 v0, 0x0

    return-object v0

    .line 36
    :cond_0
    array-length v0, p0

    if-nez v0, :cond_1

    const-string v0, ""

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/amazonaws/util/Base32;->CODEC:Lcom/amazonaws/util/Base32Codec;

    invoke-virtual {v0, p0}, Lcom/amazonaws/util/Base32Codec;->encode([B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/util/CodecUtils;->toStringDirect([B)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/util/Base32;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 23
    const-class v0, Lcom/amazonaws/util/Base32;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/util/Base32;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/util/Base32;
    .locals 1

    .line 23
    sget-object v0, Lcom/amazonaws/util/Base32;->$VALUES:[Lcom/amazonaws/util/Base32;

    invoke-virtual {v0}, [Lcom/amazonaws/util/Base32;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/util/Base32;

    return-object v0
.end method
