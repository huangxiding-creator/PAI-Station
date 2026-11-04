.class public final Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;
.super Ljava/lang/Object;
.source "GenerateSignedToken.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0001\nB\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J \u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00042\u0006\u0010\u0008\u001a\u00020\tH\u0007\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;",
        "",
        "()V",
        "generateSignedToken",
        "",
        "tokenDTO",
        "Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;",
        "secretKey",
        "duration",
        "Ljava/time/Duration;",
        "AppTokenDTO",
        "base-utils_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final generateSignedToken(Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;Ljava/lang/String;Ljava/time/Duration;)Ljava/lang/String;
    .locals 7
    .param p1, "tokenDTO"    # Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;
    .param p2, "secretKey"    # Ljava/lang/String;
    .param p3, "duration"    # Ljava/time/Duration;

    const-string/jumbo v0, "tokenDTO"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "secretKey"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "duration"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    invoke-static {}, Lcom/auth0/jwt/JWT;->create()Lcom/auth0/jwt/JWTCreator$Builder;

    move-result-object v0

    .line 28
    const/4 v1, 0x2

    new-array v1, v1, [Lkotlin/Pair;

    const-string v2, "alg"

    const-string v3, "HS256"

    invoke-static {v2, v3}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string/jumbo v2, "typ"

    const-string v4, "JWT"

    invoke-static {v2, v4}, Lkotlin/TuplesKt;->to(Ljava/lang/Object;Ljava/lang/Object;)Lkotlin/Pair;

    move-result-object v2

    const/4 v4, 0x1

    aput-object v2, v1, v4

    invoke-static {v1}, Lkotlin/collections/MapsKt;->mapOf([Lkotlin/Pair;)Ljava/util/Map;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/auth0/jwt/JWTCreator$Builder;->withHeader(Ljava/util/Map;)Lcom/auth0/jwt/JWTCreator$Builder;

    move-result-object v0

    .line 27
    nop

    .line 31
    .local v0, "builder":Lcom/auth0/jwt/JWTCreator$Builder;
    move-object v1, v0

    .local v1, "$this$generateSignedToken_u24lambda_u240":Lcom/auth0/jwt/JWTCreator$Builder;
    const/4 v2, 0x0

    .line 32
    .local v2, "$i$a$-apply-GenerateSignedToken$generateSignedToken$1":I
    const-string/jumbo v5, "uid"

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;->getUid()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Lcom/auth0/jwt/JWTCreator$Builder;->withClaim(Ljava/lang/String;Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;

    .line 33
    const-string v5, "deviceType"

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;->getDeviceType()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Lcom/auth0/jwt/JWTCreator$Builder;->withClaim(Ljava/lang/String;Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;

    .line 34
    const-string v5, "deviceId"

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;->getDeviceId()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Lcom/auth0/jwt/JWTCreator$Builder;->withClaim(Ljava/lang/String;Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;

    .line 35
    const-string v5, "appId"

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;->getAppId()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v5, v6}, Lcom/auth0/jwt/JWTCreator$Builder;->withClaim(Ljava/lang/String;Ljava/lang/String;)Lcom/auth0/jwt/JWTCreator$Builder;

    .line 36
    nop

    .line 31
    .end local v1    # "$this$generateSignedToken_u24lambda_u240":Lcom/auth0/jwt/JWTCreator$Builder;
    .end local v2    # "$i$a$-apply-GenerateSignedToken$generateSignedToken$1":I
    nop

    .line 37
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "generateSignedToken deviceType="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/GenerateSignedToken$AppTokenDTO;->getDeviceType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " secretPresent="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    move-object v2, p2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-lez v2, :cond_0

    move v2, v4

    goto :goto_0

    :cond_0
    move v2, v3

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 38
    move-object v1, p2

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_1

    move v3, v4

    :cond_1
    if-eqz v3, :cond_2

    .line 39
    const-string v1, ""

    return-object v1

    .line 42
    :cond_2
    nop

    .line 43
    invoke-static {}, Ljava/time/Instant;->now()Ljava/time/Instant;

    move-result-object v1

    move-object v2, p3

    check-cast v2, Ljava/time/temporal/TemporalAmount;

    invoke-virtual {v1, v2}, Ljava/time/Instant;->plus(Ljava/time/temporal/TemporalAmount;)Ljava/time/Instant;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Date;->from(Ljava/time/Instant;)Ljava/util/Date;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/auth0/jwt/JWTCreator$Builder;->withExpiresAt(Ljava/util/Date;)Lcom/auth0/jwt/JWTCreator$Builder;

    move-result-object v1

    .line 44
    invoke-static {p2}, Lcom/auth0/jwt/algorithms/Algorithm;->HMAC256(Ljava/lang/String;)Lcom/auth0/jwt/algorithms/Algorithm;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/auth0/jwt/JWTCreator$Builder;->sign(Lcom/auth0/jwt/algorithms/Algorithm;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "builder\n            .wit\u2026rithm.HMAC256(secretKey))"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    return-object v1
.end method
