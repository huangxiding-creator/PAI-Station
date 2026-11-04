.class public final Lcom/auth0/jwt/JWTCreator;
.super Ljava/lang/Object;
.source "JWTCreator.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/auth0/jwt/JWTCreator$Builder;
    }
.end annotation


# static fields
.field private static final mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

.field private static final module:Lcom/fasterxml/jackson/databind/module/SimpleModule;


# instance fields
.field private final algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

.field private final headerJson:Ljava/lang/String;

.field private final payloadJson:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 35
    new-instance v0, Lcom/fasterxml/jackson/databind/module/SimpleModule;

    invoke-direct {v0}, Lcom/fasterxml/jackson/databind/module/SimpleModule;-><init>()V

    sput-object v0, Lcom/auth0/jwt/JWTCreator;->module:Lcom/fasterxml/jackson/databind/module/SimpleModule;

    .line 36
    sget-object v0, Lcom/auth0/jwt/JWTCreator;->module:Lcom/fasterxml/jackson/databind/module/SimpleModule;

    const-class v1, Lcom/auth0/jwt/impl/PayloadClaimsHolder;

    new-instance v2, Lcom/auth0/jwt/impl/PayloadSerializer;

    invoke-direct {v2}, Lcom/auth0/jwt/impl/PayloadSerializer;-><init>()V

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/jackson/databind/module/SimpleModule;->addSerializer(Ljava/lang/Class;Lcom/fasterxml/jackson/databind/JsonSerializer;)Lcom/fasterxml/jackson/databind/module/SimpleModule;

    .line 37
    sget-object v0, Lcom/auth0/jwt/JWTCreator;->module:Lcom/fasterxml/jackson/databind/module/SimpleModule;

    const-class v1, Lcom/auth0/jwt/impl/HeaderClaimsHolder;

    new-instance v2, Lcom/auth0/jwt/impl/HeaderSerializer;

    invoke-direct {v2}, Lcom/auth0/jwt/impl/HeaderSerializer;-><init>()V

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/jackson/databind/module/SimpleModule;->addSerializer(Ljava/lang/Class;Lcom/fasterxml/jackson/databind/JsonSerializer;)Lcom/fasterxml/jackson/databind/module/SimpleModule;

    .line 39
    invoke-static {}, Lcom/fasterxml/jackson/databind/json/JsonMapper;->builder()Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    move-result-object v0

    sget-object v1, Lcom/fasterxml/jackson/databind/MapperFeature;->SORT_PROPERTIES_ALPHABETICALLY:Lcom/fasterxml/jackson/databind/MapperFeature;

    .line 40
    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->configure(Lcom/fasterxml/jackson/databind/MapperFeature;Z)Lcom/fasterxml/jackson/databind/cfg/MapperBuilder;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;

    .line 41
    invoke-virtual {v0}, Lcom/fasterxml/jackson/databind/json/JsonMapper$Builder;->build()Lcom/fasterxml/jackson/databind/ObjectMapper;

    move-result-object v0

    check-cast v0, Lcom/fasterxml/jackson/databind/json/JsonMapper;

    sget-object v1, Lcom/auth0/jwt/JWTCreator;->module:Lcom/fasterxml/jackson/databind/module/SimpleModule;

    .line 42
    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/json/JsonMapper;->registerModule(Lcom/fasterxml/jackson/databind/Module;)Lcom/fasterxml/jackson/databind/ObjectMapper;

    move-result-object v0

    sput-object v0, Lcom/auth0/jwt/JWTCreator;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 43
    return-void
.end method

.method private constructor <init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/util/Map;Ljava/util/Map;)V
    .locals 3
    .param p1, "algorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/auth0/jwt/algorithms/Algorithm;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTCreationException;
        }
    .end annotation

    .line 46
    .local p2, "headerClaims":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;"
    .local p3, "payloadClaims":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/Object;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 47
    iput-object p1, p0, Lcom/auth0/jwt/JWTCreator;->algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

    .line 49
    :try_start_0
    sget-object v0, Lcom/auth0/jwt/JWTCreator;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    new-instance v1, Lcom/auth0/jwt/impl/HeaderClaimsHolder;

    invoke-direct {v1, p2}, Lcom/auth0/jwt/impl/HeaderClaimsHolder;-><init>(Ljava/util/Map;)V

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/ObjectMapper;->writeValueAsString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/auth0/jwt/JWTCreator;->headerJson:Ljava/lang/String;

    .line 50
    sget-object v0, Lcom/auth0/jwt/JWTCreator;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    new-instance v1, Lcom/auth0/jwt/impl/PayloadClaimsHolder;

    invoke-direct {v1, p3}, Lcom/auth0/jwt/impl/PayloadClaimsHolder;-><init>(Ljava/util/Map;)V

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/ObjectMapper;->writeValueAsString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/auth0/jwt/JWTCreator;->payloadJson:Ljava/lang/String;
    :try_end_0
    .catch Lcom/fasterxml/jackson/core/JsonProcessingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 53
    nop

    .line 54
    return-void

    .line 51
    :catch_0
    move-exception v0

    .line 52
    .local v0, "e":Lcom/fasterxml/jackson/core/JsonProcessingException;
    new-instance v1, Lcom/auth0/jwt/exceptions/JWTCreationException;

    const-string v2, "Some of the Claims couldn\'t be converted to a valid JSON format."

    invoke-direct {v1, v2, v0}, Lcom/auth0/jwt/exceptions/JWTCreationException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method synthetic constructor <init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/util/Map;Ljava/util/Map;Lcom/auth0/jwt/JWTCreator$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/auth0/jwt/algorithms/Algorithm;
    .param p2, "x1"    # Ljava/util/Map;
    .param p3, "x2"    # Ljava/util/Map;
    .param p4, "x3"    # Lcom/auth0/jwt/JWTCreator$1;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTCreationException;
        }
    .end annotation

    .line 25
    invoke-direct {p0, p1, p2, p3}, Lcom/auth0/jwt/JWTCreator;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/util/Map;Ljava/util/Map;)V

    return-void
.end method

.method static synthetic access$000()Lcom/fasterxml/jackson/databind/ObjectMapper;
    .locals 1

    .line 25
    sget-object v0, Lcom/auth0/jwt/JWTCreator;->mapper:Lcom/fasterxml/jackson/databind/ObjectMapper;

    return-object v0
.end method

.method static synthetic access$200(Lcom/auth0/jwt/JWTCreator;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/auth0/jwt/JWTCreator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureGenerationException;
        }
    .end annotation

    .line 25
    invoke-direct {p0}, Lcom/auth0/jwt/JWTCreator;->sign()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static init()Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1

    .line 63
    new-instance v0, Lcom/auth0/jwt/JWTCreator$Builder;

    invoke-direct {v0}, Lcom/auth0/jwt/JWTCreator$Builder;-><init>()V

    return-object v0
.end method

.method private sign()Ljava/lang/String;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureGenerationException;
        }
    .end annotation

    .line 620
    invoke-static {}, Ljava/util/Base64;->getUrlEncoder()Ljava/util/Base64$Encoder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Base64$Encoder;->withoutPadding()Ljava/util/Base64$Encoder;

    move-result-object v0

    iget-object v1, p0, Lcom/auth0/jwt/JWTCreator;->headerJson:Ljava/lang/String;

    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 621
    invoke-virtual {v1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Base64$Encoder;->encodeToString([B)Ljava/lang/String;

    move-result-object v0

    .line 622
    .local v0, "header":Ljava/lang/String;
    invoke-static {}, Ljava/util/Base64;->getUrlEncoder()Ljava/util/Base64$Encoder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/Base64$Encoder;->withoutPadding()Ljava/util/Base64$Encoder;

    move-result-object v1

    iget-object v2, p0, Lcom/auth0/jwt/JWTCreator;->payloadJson:Ljava/lang/String;

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 623
    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/Base64$Encoder;->encodeToString([B)Ljava/lang/String;

    move-result-object v1

    .line 625
    .local v1, "payload":Ljava/lang/String;
    iget-object v2, p0, Lcom/auth0/jwt/JWTCreator;->algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 626
    invoke-virtual {v1, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    .line 625
    invoke-virtual {v2, v3, v4}, Lcom/auth0/jwt/algorithms/Algorithm;->sign([B[B)[B

    move-result-object v2

    .line 627
    .local v2, "signatureBytes":[B
    invoke-static {}, Ljava/util/Base64;->getUrlEncoder()Ljava/util/Base64$Encoder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Base64$Encoder;->withoutPadding()Ljava/util/Base64$Encoder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/util/Base64$Encoder;->encodeToString([B)Ljava/lang/String;

    move-result-object v3

    .line 629
    .local v3, "signature":Ljava/lang/String;
    const-string v4, "%s.%s.%s"

    filled-new-array {v0, v1, v3}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    return-object v4
.end method
