.class public final Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;
.super Ljava/lang/Object;
.source "OtaRepository.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOtaRepository.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OtaRepository.kt\ncom/rokid/security/phone/sdk/server/ota/repository/OtaRepository\n+ 2 _Arrays.kt\nkotlin/collections/ArraysKt___ArraysKt\n*L\n1#1,105:1\n13004#2,3:106\n*S KotlinDebug\n*F\n+ 1 OtaRepository.kt\ncom/rokid/security/phone/sdk/server/ota/repository/OtaRepository\n*L\n54#1:106,3\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J.\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0011\u001a\u00020\u00102\u0006\u0010\u0012\u001a\u00020\u00102\u0006\u0010\u0013\u001a\u00020\u00102\u0006\u0010\u0014\u001a\u00020\u00102\u0006\u0010\u0015\u001a\u00020\u0010J\u0014\u0010\u0016\u001a\u0008\u0012\u0004\u0012\u00020\u00180\u00172\u0006\u0010\u0019\u001a\u00020\u001aJ\n\u0010\u001b\u001a\u00020\u0010*\u00020\u0010R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000e\u00a8\u0006\u001c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;",
        "",
        "()V",
        "mGson",
        "Lcom/google/gson/Gson;",
        "getMGson",
        "()Lcom/google/gson/Gson;",
        "setMGson",
        "(Lcom/google/gson/Gson;)V",
        "mOtaHeaderInfo",
        "Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;",
        "getMOtaHeaderInfo",
        "()Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;",
        "setMOtaHeaderInfo",
        "(Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;)V",
        "generateSign",
        "",
        "version",
        "deviceTypeId",
        "deviceId",
        "time",
        "secret",
        "otaCheck",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/sdk/base/common/ota/OTAResponse;",
        "info",
        "Lcom/rokid/security/sdk/base/common/ota/SystemInfo;",
        "md5",
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
.field private mGson:Lcom/google/gson/Gson;

.field private mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    new-instance v0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    .line 23
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mGson:Lcom/google/gson/Gson;

    .line 19
    return-void
.end method


# virtual methods
.method public final generateSign(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "version"    # Ljava/lang/String;
    .param p2, "deviceTypeId"    # Ljava/lang/String;
    .param p3, "deviceId"    # Ljava/lang/String;
    .param p4, "time"    # Ljava/lang/String;
    .param p5, "secret"    # Ljava/lang/String;

    const-string/jumbo v0, "version"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "deviceTypeId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "deviceId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "time"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "secret"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 68
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "device_id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&device_type_id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&secret="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&time="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&version="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 69
    .local v0, "signBuff":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "signBuff:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "OtaRepository"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 70
    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->md5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public final getMGson()Lcom/google/gson/Gson;
    .locals 1

    .line 23
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mGson:Lcom/google/gson/Gson;

    return-object v0
.end method

.method public final getMOtaHeaderInfo()Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    return-object v0
.end method

.method public final md5(Ljava/lang/String;)Ljava/lang/String;
    .locals 14
    .param p1, "$this$md5"    # Ljava/lang/String;

    const-string v0, "<this>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    const-string v0, "MD5"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 51
    .local v0, "digest":Ljava/security/MessageDigest;
    sget-object v1, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    const-string/jumbo v2, "this as java.lang.String).getBytes(charset)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v1

    .line 54
    .local v1, "hashBytes":[B
    const-string v2, "hashBytes"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .local v2, "initial$iv":Ljava/lang/Object;
    move-object v3, v1

    .local v3, "$this$fold$iv":[B
    const/4 v4, 0x0

    .line 106
    .local v4, "$i$f$fold":I
    move-object v5, v2

    .line 107
    .local v5, "accumulator$iv":Ljava/lang/Object;
    array-length v6, v3

    const/4 v7, 0x0

    :goto_0
    if-ge v7, v6, :cond_0

    aget-byte v8, v3, v7

    .local v8, "element$iv":B
    move-object v9, v5

    .local v9, "sb":Ljava/lang/StringBuilder;
    move v10, v8

    .local v10, "b":B
    const/4 v11, 0x0

    .line 55
    .local v11, "$i$a$-fold-OtaRepository$md5$1":I
    sget-object v12, Lkotlin/jvm/internal/StringCompanionObject;->INSTANCE:Lkotlin/jvm/internal/StringCompanionObject;

    invoke-static {v10}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v12

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    const/4 v13, 0x1

    invoke-static {v12, v13}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v12

    const-string v13, "%02x"

    invoke-static {v13, v12}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v12

    const-string v13, "format(format, *args)"

    invoke-static {v12, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string/jumbo v13, "sb.append(String.format(\"%02x\", b))"

    invoke-static {v12, v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 107
    .end local v9    # "sb":Ljava/lang/StringBuilder;
    .end local v10    # "b":B
    .end local v11    # "$i$a$-fold-OtaRepository$md5$1":I
    move-object v5, v12

    .end local v8    # "element$iv":B
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 108
    :cond_0
    nop

    .line 56
    .end local v2    # "initial$iv":Ljava/lang/Object;
    .end local v3    # "$this$fold$iv":[B
    .end local v4    # "$i$f$fold":I
    .end local v5    # "accumulator$iv":Ljava/lang/Object;
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 54
    const-string v3, "hashBytes.fold(StringBui\u2026 b))\n        }.toString()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v2
.end method

.method public final otaCheck(Lcom/rokid/security/sdk/base/common/ota/SystemInfo;)Lkotlinx/coroutines/flow/Flow;
    .locals 8
    .param p1, "info"    # Lcom/rokid/security/sdk/base/common/ota/SystemInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/base/common/ota/SystemInfo;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/sdk/base/common/ota/OTAResponse;",
            ">;"
        }
    .end annotation

    const-string v0, "info"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->getVersion()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->setVersion(Ljava/lang/String;)V

    .line 32
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->getDevice_id()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_1

    .line 33
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->getDevice_id()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->setDevice_id(Ljava/lang/String;)V

    .line 35
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/ota/SystemInfo;->getDeviceTypeId()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->setDevice_type_id(Ljava/lang/String;)V

    .line 38
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->getVersion()Ljava/lang/String;

    move-result-object v3

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->getDevice_type_id()Ljava/lang/String;

    move-result-object v4

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->getDevice_id()Ljava/lang/String;

    move-result-object v5

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->getTime()Ljava/lang/String;

    move-result-object v6

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->getSecret()Ljava/lang/String;

    move-result-object v7

    move-object v2, p0

    invoke-virtual/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->generateSign(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->setSign(Ljava/lang/String;)V

    .line 40
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mOtaHeaderInfo.sign:"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->getSign()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "OtaRepository"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 41
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;->toAuthorizationHeader()Ljava/lang/String;

    move-result-object v0

    .line 42
    .local v0, "token":Ljava/lang/String;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->getApi()Lcom/rokid/security/phone/sdk/server/net/ApiService;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getOtaCheckUrl()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2, v0, p1}, Lcom/rokid/security/phone/sdk/server/net/ApiService;->otaCheck(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/ota/SystemInfo;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v1

    return-object v1
.end method

.method public final setMGson(Lcom/google/gson/Gson;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/google/gson/Gson;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 23
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mGson:Lcom/google/gson/Gson;

    return-void
.end method

.method public final setMOtaHeaderInfo(Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/ota/repository/OtaRepository;->mOtaHeaderInfo:Lcom/rokid/security/phone/sdk/server/ota/repository/OtaHeaderInfo;

    return-void
.end method
