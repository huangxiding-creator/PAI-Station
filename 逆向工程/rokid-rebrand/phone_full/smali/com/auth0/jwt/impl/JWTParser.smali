.class public Lcom/auth0/jwt/impl/JWTParser;
.super Ljava/lang/Object;
.source "JWTParser.java"

# interfaces
.implements Lcom/auth0/jwt/interfaces/JWTPartsParser;


# static fields
.field private static final DEFAULT_HEADER_READER:Lcom/fasterxml/jackson/databind/ObjectReader;

.field private static final DEFAULT_OBJECT_MAPPER:Lcom/fasterxml/jackson/databind/ObjectMapper;

.field private static final DEFAULT_PAYLOAD_READER:Lcom/fasterxml/jackson/databind/ObjectReader;


# instance fields
.field private final headerReader:Lcom/fasterxml/jackson/databind/ObjectReader;

.field private final payloadReader:Lcom/fasterxml/jackson/databind/ObjectReader;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 19
    invoke-static {}, Lcom/auth0/jwt/impl/JWTParser;->createDefaultObjectMapper()Lcom/fasterxml/jackson/databind/ObjectMapper;

    move-result-object v0

    sput-object v0, Lcom/auth0/jwt/impl/JWTParser;->DEFAULT_OBJECT_MAPPER:Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 20
    sget-object v0, Lcom/auth0/jwt/impl/JWTParser;->DEFAULT_OBJECT_MAPPER:Lcom/fasterxml/jackson/databind/ObjectMapper;

    const-class v1, Lcom/auth0/jwt/interfaces/Payload;

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/ObjectMapper;->readerFor(Ljava/lang/Class;)Lcom/fasterxml/jackson/databind/ObjectReader;

    move-result-object v0

    sput-object v0, Lcom/auth0/jwt/impl/JWTParser;->DEFAULT_PAYLOAD_READER:Lcom/fasterxml/jackson/databind/ObjectReader;

    .line 21
    sget-object v0, Lcom/auth0/jwt/impl/JWTParser;->DEFAULT_OBJECT_MAPPER:Lcom/fasterxml/jackson/databind/ObjectMapper;

    const-class v1, Lcom/auth0/jwt/interfaces/Header;

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/ObjectMapper;->readerFor(Ljava/lang/Class;)Lcom/fasterxml/jackson/databind/ObjectReader;

    move-result-object v0

    sput-object v0, Lcom/auth0/jwt/impl/JWTParser;->DEFAULT_HEADER_READER:Lcom/fasterxml/jackson/databind/ObjectReader;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    sget-object v0, Lcom/auth0/jwt/impl/JWTParser;->DEFAULT_PAYLOAD_READER:Lcom/fasterxml/jackson/databind/ObjectReader;

    iput-object v0, p0, Lcom/auth0/jwt/impl/JWTParser;->payloadReader:Lcom/fasterxml/jackson/databind/ObjectReader;

    .line 28
    sget-object v0, Lcom/auth0/jwt/impl/JWTParser;->DEFAULT_HEADER_READER:Lcom/fasterxml/jackson/databind/ObjectReader;

    iput-object v0, p0, Lcom/auth0/jwt/impl/JWTParser;->headerReader:Lcom/fasterxml/jackson/databind/ObjectReader;

    .line 29
    return-void
.end method

.method constructor <init>(Lcom/fasterxml/jackson/databind/ObjectMapper;)V
    .locals 1
    .param p1, "mapper"    # Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    invoke-static {p1}, Lcom/auth0/jwt/impl/JWTParser;->addDeserializers(Lcom/fasterxml/jackson/databind/ObjectMapper;)V

    .line 34
    const-class v0, Lcom/auth0/jwt/interfaces/Payload;

    invoke-virtual {p1, v0}, Lcom/fasterxml/jackson/databind/ObjectMapper;->readerFor(Ljava/lang/Class;)Lcom/fasterxml/jackson/databind/ObjectReader;

    move-result-object v0

    iput-object v0, p0, Lcom/auth0/jwt/impl/JWTParser;->payloadReader:Lcom/fasterxml/jackson/databind/ObjectReader;

    .line 35
    const-class v0, Lcom/auth0/jwt/interfaces/Header;

    invoke-virtual {p1, v0}, Lcom/fasterxml/jackson/databind/ObjectMapper;->readerFor(Ljava/lang/Class;)Lcom/fasterxml/jackson/databind/ObjectReader;

    move-result-object v0

    iput-object v0, p0, Lcom/auth0/jwt/impl/JWTParser;->headerReader:Lcom/fasterxml/jackson/databind/ObjectReader;

    .line 36
    return-void
.end method

.method static addDeserializers(Lcom/fasterxml/jackson/databind/ObjectMapper;)V
    .locals 3
    .param p0, "mapper"    # Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 65
    new-instance v0, Lcom/fasterxml/jackson/databind/module/SimpleModule;

    invoke-direct {v0}, Lcom/fasterxml/jackson/databind/module/SimpleModule;-><init>()V

    .line 66
    .local v0, "module":Lcom/fasterxml/jackson/databind/module/SimpleModule;
    const-class v1, Lcom/auth0/jwt/interfaces/Payload;

    new-instance v2, Lcom/auth0/jwt/impl/PayloadDeserializer;

    invoke-direct {v2}, Lcom/auth0/jwt/impl/PayloadDeserializer;-><init>()V

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/jackson/databind/module/SimpleModule;->addDeserializer(Ljava/lang/Class;Lcom/fasterxml/jackson/databind/JsonDeserializer;)Lcom/fasterxml/jackson/databind/module/SimpleModule;

    .line 67
    const-class v1, Lcom/auth0/jwt/interfaces/Header;

    new-instance v2, Lcom/auth0/jwt/impl/HeaderDeserializer;

    invoke-direct {v2}, Lcom/auth0/jwt/impl/HeaderDeserializer;-><init>()V

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/jackson/databind/module/SimpleModule;->addDeserializer(Ljava/lang/Class;Lcom/fasterxml/jackson/databind/JsonDeserializer;)Lcom/fasterxml/jackson/databind/module/SimpleModule;

    .line 68
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/databind/ObjectMapper;->registerModule(Lcom/fasterxml/jackson/databind/Module;)Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 69
    return-void
.end method

.method private static createDefaultObjectMapper()Lcom/fasterxml/jackson/databind/ObjectMapper;
    .locals 2

    .line 76
    new-instance v0, Lcom/fasterxml/jackson/databind/ObjectMapper;

    invoke-direct {v0}, Lcom/fasterxml/jackson/databind/ObjectMapper;-><init>()V

    .line 77
    .local v0, "mapper":Lcom/fasterxml/jackson/databind/ObjectMapper;
    sget-object v1, Lcom/fasterxml/jackson/databind/SerializationFeature;->FAIL_ON_EMPTY_BEANS:Lcom/fasterxml/jackson/databind/SerializationFeature;

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/ObjectMapper;->disable(Lcom/fasterxml/jackson/databind/SerializationFeature;)Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 78
    sget-object v1, Lcom/fasterxml/jackson/annotation/JsonInclude$Include;->NON_EMPTY:Lcom/fasterxml/jackson/annotation/JsonInclude$Include;

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/databind/ObjectMapper;->setSerializationInclusion(Lcom/fasterxml/jackson/annotation/JsonInclude$Include;)Lcom/fasterxml/jackson/databind/ObjectMapper;

    .line 80
    invoke-static {v0}, Lcom/auth0/jwt/impl/JWTParser;->addDeserializers(Lcom/fasterxml/jackson/databind/ObjectMapper;)V

    .line 82
    return-object v0
.end method

.method private static decodeException()Lcom/auth0/jwt/exceptions/JWTDecodeException;
    .locals 1

    .line 86
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/auth0/jwt/impl/JWTParser;->decodeException(Ljava/lang/String;)Lcom/auth0/jwt/exceptions/JWTDecodeException;

    move-result-object v0

    return-object v0
.end method

.method private static decodeException(Ljava/lang/String;)Lcom/auth0/jwt/exceptions/JWTDecodeException;
    .locals 3
    .param p0, "json"    # Ljava/lang/String;

    .line 90
    new-instance v0, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    const-string v1, "The string \'%s\' doesn\'t have a valid JSON format."

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method static getDefaultObjectMapper()Lcom/fasterxml/jackson/databind/ObjectMapper;
    .locals 1

    .line 72
    sget-object v0, Lcom/auth0/jwt/impl/JWTParser;->DEFAULT_OBJECT_MAPPER:Lcom/fasterxml/jackson/databind/ObjectMapper;

    return-object v0
.end method


# virtual methods
.method public parseHeader(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Header;
    .locals 2
    .param p1, "json"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 53
    if-eqz p1, :cond_0

    .line 58
    :try_start_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JWTParser;->headerReader:Lcom/fasterxml/jackson/databind/ObjectReader;

    invoke-virtual {v0, p1}, Lcom/fasterxml/jackson/databind/ObjectReader;->readValue(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/auth0/jwt/interfaces/Header;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 59
    :catch_0
    move-exception v0

    .line 60
    .local v0, "e":Ljava/io/IOException;
    invoke-static {p1}, Lcom/auth0/jwt/impl/JWTParser;->decodeException(Ljava/lang/String;)Lcom/auth0/jwt/exceptions/JWTDecodeException;

    move-result-object v1

    throw v1

    .line 54
    .end local v0    # "e":Ljava/io/IOException;
    :cond_0
    invoke-static {}, Lcom/auth0/jwt/impl/JWTParser;->decodeException()Lcom/auth0/jwt/exceptions/JWTDecodeException;

    move-result-object v0

    throw v0
.end method

.method public parsePayload(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Payload;
    .locals 2
    .param p1, "json"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 40
    if-eqz p1, :cond_0

    .line 45
    :try_start_0
    iget-object v0, p0, Lcom/auth0/jwt/impl/JWTParser;->payloadReader:Lcom/fasterxml/jackson/databind/ObjectReader;

    invoke-virtual {v0, p1}, Lcom/fasterxml/jackson/databind/ObjectReader;->readValue(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/auth0/jwt/interfaces/Payload;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 46
    :catch_0
    move-exception v0

    .line 47
    .local v0, "e":Ljava/io/IOException;
    invoke-static {p1}, Lcom/auth0/jwt/impl/JWTParser;->decodeException(Ljava/lang/String;)Lcom/auth0/jwt/exceptions/JWTDecodeException;

    move-result-object v1

    throw v1

    .line 41
    .end local v0    # "e":Ljava/io/IOException;
    :cond_0
    invoke-static {}, Lcom/auth0/jwt/impl/JWTParser;->decodeException()Lcom/auth0/jwt/exceptions/JWTDecodeException;

    move-result-object v0

    throw v0
.end method
