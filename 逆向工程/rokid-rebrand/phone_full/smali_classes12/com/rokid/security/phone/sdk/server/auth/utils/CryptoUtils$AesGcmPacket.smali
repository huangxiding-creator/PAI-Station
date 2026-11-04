.class public final Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;
.super Ljava/lang/Object;
.source "CryptoUtils.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "AesGcmPacket"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u000b\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0000\u0008\u0086\u0008\u0018\u00002\u00020\u0001B\u001f\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u0006\u00a2\u0006\u0002\u0010\u0007J\t\u0010\r\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u000e\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u000f\u001a\u00020\u0006H\u00c6\u0003J\'\u0010\u0010\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u0006H\u00c6\u0001J\u0013\u0010\u0011\u001a\u00020\u00122\u0008\u0010\u0013\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0014\u001a\u00020\u0006H\u00d6\u0001J\t\u0010\u0015\u001a\u00020\u0016H\u00d6\u0001R\u0011\u0010\u0004\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\tR\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\tR\u0011\u0010\u0005\u001a\u00020\u0006\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\u00a8\u0006\u0017"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;",
        "",
        "iv",
        "",
        "ciphertext",
        "tagLen",
        "",
        "([B[BI)V",
        "getCiphertext",
        "()[B",
        "getIv",
        "getTagLen",
        "()I",
        "component1",
        "component2",
        "component3",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "toString",
        "",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final ciphertext:[B

.field private final iv:[B

.field private final tagLen:I


# direct methods
.method public constructor <init>([B[BI)V
    .locals 1
    .param p1, "iv"    # [B
    .param p2, "ciphertext"    # [B
    .param p3, "tagLen"    # I

    const-string v0, "iv"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "ciphertext"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 173
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->iv:[B

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->ciphertext:[B

    iput p3, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->tagLen:I

    return-void
.end method

.method public synthetic constructor <init>([B[BIILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    .line 173
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_0

    const/16 p3, 0x80

    :cond_0
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;-><init>([B[BI)V

    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;[B[BIILjava/lang/Object;)Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;
    .locals 0

    and-int/lit8 p5, p4, 0x1

    if-eqz p5, :cond_0

    iget-object p1, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->iv:[B

    :cond_0
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_1

    iget-object p2, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->ciphertext:[B

    :cond_1
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_2

    iget p3, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->tagLen:I

    :cond_2
    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->copy([B[BI)Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()[B
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->iv:[B

    return-object v0
.end method

.method public final component2()[B
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->ciphertext:[B

    return-object v0
.end method

.method public final component3()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->tagLen:I

    return v0
.end method

.method public final copy([B[BI)Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;
    .locals 1

    const-string v0, "iv"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "ciphertext"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;

    invoke-direct {v0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;-><init>([B[BI)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->iv:[B

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->iv:[B

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->ciphertext:[B

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->ciphertext:[B

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget v3, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->tagLen:I

    iget v1, v1, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->tagLen:I

    if-eq v3, v1, :cond_4

    return v2

    :cond_4
    return v0
.end method

.method public final getCiphertext()[B
    .locals 1

    .line 173
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->ciphertext:[B

    return-object v0
.end method

.method public final getIv()[B
    .locals 1

    .line 173
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->iv:[B

    return-object v0
.end method

.method public final getTagLen()I
    .locals 1

    .line 173
    iget v0, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->tagLen:I

    return v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->iv:[B

    invoke-static {v0}, Ljava/util/Arrays;->hashCode([B)I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->ciphertext:[B

    invoke-static {v2}, Ljava/util/Arrays;->hashCode([B)I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->tagLen:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v0, v2

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AesGcmPacket(iv="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->iv:[B

    invoke-static {v1}, Ljava/util/Arrays;->toString([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", ciphertext="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->ciphertext:[B

    invoke-static {v1}, Ljava/util/Arrays;->toString([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", tagLen="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/phone/sdk/server/auth/utils/CryptoUtils$AesGcmPacket;->tagLen:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
