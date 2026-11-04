.class public Lio/minio/Signer;
.super Ljava/lang/Object;
.source "Signer.java"


# static fields
.field private static final IGNORED_HEADERS:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final PRESIGN_IGNORED_HEADERS:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private accessKey:Ljava/lang/String;

.field private authorization:Ljava/lang/String;

.field private canonicalHeaders:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private canonicalQueryString:Ljava/lang/String;

.field private canonicalRequest:Ljava/lang/String;

.field private canonicalRequestHash:Ljava/lang/String;

.field private contentSha256:Ljava/lang/String;

.field private date:Ljava/time/ZonedDateTime;

.field private prevSignature:Ljava/lang/String;

.field private region:Ljava/lang/String;

.field private request:Lokhttp3/Request;

.field private scope:Ljava/lang/String;

.field private secretKey:Ljava/lang/String;

.field private signature:Ljava/lang/String;

.field private signedHeaders:Ljava/lang/String;

.field private signingKey:[B

.field private stringToSign:Ljava/lang/String;

.field private url:Lokhttp3/HttpUrl;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .line 56
    nop

    .line 57
    const-string v0, "accept-encoding"

    const-string v1, "authorization"

    const-string/jumbo v2, "user-agent"

    invoke-static {v0, v1, v2}, Lcom/google/common/collect/ImmutableSet;->of(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Lcom/google/common/collect/ImmutableSet;

    move-result-object v0

    sput-object v0, Lio/minio/Signer;->IGNORED_HEADERS:Ljava/util/Set;

    .line 58
    const/4 v0, 0x1

    new-array v7, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    const-string/jumbo v1, "x-amz-security-token"

    aput-object v1, v7, v0

    .line 59
    const-string v1, "accept-encoding"

    const-string v2, "authorization"

    const-string/jumbo v3, "user-agent"

    const-string v4, "content-md5"

    const-string/jumbo v5, "x-amz-content-sha256"

    const-string/jumbo v6, "x-amz-date"

    invoke-static/range {v1 .. v7}, Lcom/google/common/collect/ImmutableSet;->of(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;[Ljava/lang/Object;)Lcom/google/common/collect/ImmutableSet;

    move-result-object v0

    sput-object v0, Lio/minio/Signer;->PRESIGN_IGNORED_HEADERS:Ljava/util/Set;

    .line 58
    return-void
.end method

.method private constructor <init>(Lokhttp3/Request;Ljava/lang/String;Ljava/time/ZonedDateTime;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "request"    # Lokhttp3/Request;
    .param p2, "contentSha256"    # Ljava/lang/String;
    .param p3, "date"    # Ljava/time/ZonedDateTime;
    .param p4, "region"    # Ljava/lang/String;
    .param p5, "accessKey"    # Ljava/lang/String;
    .param p6, "secretKey"    # Ljava/lang/String;
    .param p7, "prevSignature"    # Ljava/lang/String;

    .line 106
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 107
    iput-object p1, p0, Lio/minio/Signer;->request:Lokhttp3/Request;

    .line 108
    iput-object p2, p0, Lio/minio/Signer;->contentSha256:Ljava/lang/String;

    .line 109
    iput-object p3, p0, Lio/minio/Signer;->date:Ljava/time/ZonedDateTime;

    .line 110
    iput-object p4, p0, Lio/minio/Signer;->region:Ljava/lang/String;

    .line 111
    iput-object p5, p0, Lio/minio/Signer;->accessKey:Ljava/lang/String;

    .line 112
    iput-object p6, p0, Lio/minio/Signer;->secretKey:Ljava/lang/String;

    .line 113
    iput-object p7, p0, Lio/minio/Signer;->prevSignature:Ljava/lang/String;

    .line 114
    return-void
.end method

.method public static credential(Ljava/lang/String;Ljava/time/ZonedDateTime;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "accessKey"    # Ljava/lang/String;
    .param p1, "date"    # Ljava/time/ZonedDateTime;
    .param p2, "region"    # Ljava/lang/String;

    .line 375
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Lio/minio/Time;->SIGNER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 377
    invoke-virtual {p1, v2}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/s3/aws4_request"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 375
    return-object v0
.end method

.method public static getChunkSignature(Ljava/lang/String;Ljava/time/ZonedDateTime;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p0, "chunkSha256"    # Ljava/lang/String;
    .param p1, "date"    # Ljava/time/ZonedDateTime;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "secretKey"    # Ljava/lang/String;
    .param p4, "prevSignature"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 269
    new-instance v8, Lio/minio/Signer;

    const/4 v1, 0x0

    const/4 v5, 0x0

    move-object v0, v8

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v6, p3

    move-object v7, p4

    invoke-direct/range {v0 .. v7}, Lio/minio/Signer;-><init>(Lokhttp3/Request;Ljava/lang/String;Ljava/time/ZonedDateTime;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 270
    .local v0, "signer":Lio/minio/Signer;
    const-string/jumbo v1, "s3"

    invoke-direct {v0, v1}, Lio/minio/Signer;->setScope(Ljava/lang/String;)V

    .line 271
    invoke-direct {v0}, Lio/minio/Signer;->setChunkStringToSign()V

    .line 272
    invoke-direct {v0, v1}, Lio/minio/Signer;->setSigningKey(Ljava/lang/String;)V

    .line 273
    invoke-direct {v0}, Lio/minio/Signer;->setSignature()V

    .line 275
    iget-object v1, v0, Lio/minio/Signer;->signature:Ljava/lang/String;

    return-object v1
.end method

.method static synthetic lambda$setCanonicalHeaders$0(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "value"    # Ljava/lang/String;

    .line 142
    const-string v0, "( +)"

    const-string v1, " "

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static postPresignV4(Ljava/lang/String;Ljava/lang/String;Ljava/time/ZonedDateTime;Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p0, "stringToSign"    # Ljava/lang/String;
    .param p1, "secretKey"    # Ljava/lang/String;
    .param p2, "date"    # Ljava/time/ZonedDateTime;
    .param p3, "region"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 387
    new-instance v8, Lio/minio/Signer;

    const/4 v5, 0x0

    const/4 v7, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v0, v8

    move-object v3, p2

    move-object v4, p3

    move-object v6, p1

    invoke-direct/range {v0 .. v7}, Lio/minio/Signer;-><init>(Lokhttp3/Request;Ljava/lang/String;Ljava/time/ZonedDateTime;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 388
    .local v0, "signer":Lio/minio/Signer;
    iput-object p0, v0, Lio/minio/Signer;->stringToSign:Ljava/lang/String;

    .line 389
    const-string/jumbo v1, "s3"

    invoke-direct {v0, v1}, Lio/minio/Signer;->setSigningKey(Ljava/lang/String;)V

    .line 390
    invoke-direct {v0}, Lio/minio/Signer;->setSignature()V

    .line 392
    iget-object v1, v0, Lio/minio/Signer;->signature:Ljava/lang/String;

    return-object v1
.end method

.method public static presignV4(Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lokhttp3/HttpUrl;
    .locals 11
    .param p0, "request"    # Lokhttp3/Request;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "accessKey"    # Ljava/lang/String;
    .param p3, "secretKey"    # Ljava/lang/String;
    .param p4, "expires"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 355
    const-string v8, "UNSIGNED-PAYLOAD"

    .line 356
    .local v8, "contentSha256":Ljava/lang/String;
    const-string/jumbo v0, "x-amz-date"

    invoke-virtual {p0, v0}, Lokhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lio/minio/Time;->AMZ_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-static {v0, v1}, Ljava/time/ZonedDateTime;->parse(Ljava/lang/CharSequence;Ljava/time/format/DateTimeFormatter;)Ljava/time/ZonedDateTime;

    move-result-object v9

    .line 358
    .local v9, "date":Ljava/time/ZonedDateTime;
    new-instance v10, Lio/minio/Signer;

    const/4 v7, 0x0

    move-object v0, v10

    move-object v1, p0

    move-object v2, v8

    move-object v3, v9

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v0 .. v7}, Lio/minio/Signer;-><init>(Lokhttp3/Request;Ljava/lang/String;Ljava/time/ZonedDateTime;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 359
    .local v0, "signer":Lio/minio/Signer;
    const-string/jumbo v1, "s3"

    invoke-direct {v0, v1}, Lio/minio/Signer;->setScope(Ljava/lang/String;)V

    .line 360
    invoke-direct {v0, p4}, Lio/minio/Signer;->setPresignCanonicalRequest(I)V

    .line 361
    invoke-direct {v0}, Lio/minio/Signer;->setStringToSign()V

    .line 362
    invoke-direct {v0, v1}, Lio/minio/Signer;->setSigningKey(Ljava/lang/String;)V

    .line 363
    invoke-direct {v0}, Lio/minio/Signer;->setSignature()V

    .line 365
    iget-object v1, v0, Lio/minio/Signer;->url:Lokhttp3/HttpUrl;

    .line 367
    invoke-virtual {v1}, Lokhttp3/HttpUrl;->newBuilder()Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 369
    const-string v2, "X-Amz-Signature"

    invoke-static {v2}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, v0, Lio/minio/Signer;->signature:Ljava/lang/String;

    invoke-static {v3}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 368
    invoke-virtual {v1, v2, v3}, Lokhttp3/HttpUrl$Builder;->addEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    move-result-object v1

    .line 370
    invoke-virtual {v1}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v1

    .line 365
    return-object v1
.end method

.method private setAuthorization()V
    .locals 2

    .line 254
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AWS4-HMAC-SHA256 Credential="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->accessKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->scope:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", SignedHeaders="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->signedHeaders:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", Signature="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->signature:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/Signer;->authorization:Ljava/lang/String;

    .line 263
    return-void
.end method

.method private setCanonicalHeaders(Ljava/util/Set;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 127
    .local p1, "ignored_headers":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    iput-object v0, p0, Lio/minio/Signer;->canonicalHeaders:Ljava/util/Map;

    .line 129
    iget-object v0, p0, Lio/minio/Signer;->request:Lokhttp3/Request;

    invoke-virtual {v0}, Lokhttp3/Request;->headers()Lokhttp3/Headers;

    move-result-object v0

    .line 130
    .local v0, "headers":Lokhttp3/Headers;
    invoke-virtual {v0}, Lokhttp3/Headers;->names()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 131
    .local v2, "name":Ljava/lang/String;
    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v2, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    .line 132
    .local v3, "signedHeader":Ljava/lang/String;
    invoke-interface {p1, v3}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 137
    iget-object v4, p0, Lio/minio/Signer;->canonicalHeaders:Ljava/util/Map;

    .line 139
    invoke-virtual {v0, v2}, Lokhttp3/Headers;->values(Ljava/lang/String;)Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->stream()Ljava/util/stream/Stream;

    move-result-object v5

    new-instance v6, Lio/minio/Signer$$ExternalSyntheticLambda0;

    invoke-direct {v6}, Lio/minio/Signer$$ExternalSyntheticLambda0;-><init>()V

    .line 140
    invoke-interface {v5, v6}, Ljava/util/stream/Stream;->map(Ljava/util/function/Function;)Ljava/util/stream/Stream;

    move-result-object v5

    .line 144
    const-string v6, ","

    invoke-static {v6}, Ljava/util/stream/Collectors;->joining(Ljava/lang/CharSequence;)Ljava/util/stream/Collector;

    move-result-object v6

    invoke-interface {v5, v6}, Ljava/util/stream/Stream;->collect(Ljava/util/stream/Collector;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 137
    invoke-interface {v4, v3, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 146
    .end local v2    # "name":Ljava/lang/String;
    .end local v3    # "signedHeader":Ljava/lang/String;
    :cond_0
    goto :goto_0

    .line 148
    :cond_1
    const-string v1, ";"

    invoke-static {v1}, Lcom/google/common/base/Joiner;->on(Ljava/lang/String;)Lcom/google/common/base/Joiner;

    move-result-object v1

    iget-object v2, p0, Lio/minio/Signer;->canonicalHeaders:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/common/base/Joiner;->join(Ljava/lang/Iterable;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lio/minio/Signer;->signedHeaders:Ljava/lang/String;

    .line 149
    return-void
.end method

.method private setCanonicalQueryString()V
    .locals 12

    .line 152
    iget-object v0, p0, Lio/minio/Signer;->url:Lokhttp3/HttpUrl;

    invoke-virtual {v0}, Lokhttp3/HttpUrl;->encodedQuery()Ljava/lang/String;

    move-result-object v0

    .line 153
    .local v0, "encodedQuery":Ljava/lang/String;
    const-string v1, ""

    if-nez v0, :cond_0

    .line 154
    iput-object v1, p0, Lio/minio/Signer;->canonicalQueryString:Ljava/lang/String;

    .line 155
    return-void

    .line 161
    :cond_0
    invoke-static {}, Lcom/google/common/collect/MultimapBuilder;->treeKeys()Lcom/google/common/collect/MultimapBuilder$MultimapBuilderWithKeys;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/common/collect/MultimapBuilder$MultimapBuilderWithKeys;->arrayListValues()Lcom/google/common/collect/MultimapBuilder$ListMultimapBuilder;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/common/collect/MultimapBuilder$ListMultimapBuilder;->build()Lcom/google/common/collect/ListMultimap;

    move-result-object v2

    .line 163
    .local v2, "signedQueryParams":Lcom/google/common/collect/Multimap;, "Lcom/google/common/collect/Multimap<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v3, "&"

    invoke-virtual {v0, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    array-length v5, v4

    const/4 v6, 0x0

    move v7, v6

    :goto_0
    const-string v8, "="

    if-ge v7, v5, :cond_2

    aget-object v9, v4, v7

    .line 164
    .local v9, "queryParam":Ljava/lang/String;
    invoke-virtual {v9, v8}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v8

    .line 165
    .local v8, "tokens":[Ljava/lang/String;
    array-length v10, v8

    const/4 v11, 0x1

    if-le v10, v11, :cond_1

    .line 166
    aget-object v10, v8, v6

    aget-object v11, v8, v11

    invoke-interface {v2, v10, v11}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    goto :goto_1

    .line 168
    :cond_1
    aget-object v10, v8, v6

    invoke-interface {v2, v10, v1}, Lcom/google/common/collect/Multimap;->put(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 163
    .end local v8    # "tokens":[Ljava/lang/String;
    .end local v9    # "queryParam":Ljava/lang/String;
    :goto_1
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 172
    :cond_2
    nop

    .line 173
    invoke-static {v3}, Lcom/google/common/base/Joiner;->on(Ljava/lang/String;)Lcom/google/common/base/Joiner;

    move-result-object v1

    invoke-virtual {v1, v8}, Lcom/google/common/base/Joiner;->withKeyValueSeparator(Ljava/lang/String;)Lcom/google/common/base/Joiner$MapJoiner;

    move-result-object v1

    invoke-interface {v2}, Lcom/google/common/collect/Multimap;->entries()Ljava/util/Collection;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/google/common/base/Joiner$MapJoiner;->join(Ljava/lang/Iterable;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lio/minio/Signer;->canonicalQueryString:Ljava/lang/String;

    .line 174
    return-void
.end method

.method private setCanonicalRequest()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 177
    sget-object v0, Lio/minio/Signer;->IGNORED_HEADERS:Ljava/util/Set;

    invoke-direct {p0, v0}, Lio/minio/Signer;->setCanonicalHeaders(Ljava/util/Set;)V

    .line 178
    iget-object v0, p0, Lio/minio/Signer;->request:Lokhttp3/Request;

    invoke-virtual {v0}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v0

    iput-object v0, p0, Lio/minio/Signer;->url:Lokhttp3/HttpUrl;

    .line 179
    invoke-direct {p0}, Lio/minio/Signer;->setCanonicalQueryString()V

    .line 188
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lio/minio/Signer;->request:Lokhttp3/Request;

    .line 189
    invoke-virtual {v1}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lio/minio/Signer;->url:Lokhttp3/HttpUrl;

    .line 191
    invoke-virtual {v2}, Lokhttp3/HttpUrl;->encodedPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lio/minio/Signer;->canonicalQueryString:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 195
    invoke-static {v1}, Lcom/google/common/base/Joiner;->on(Ljava/lang/String;)Lcom/google/common/base/Joiner;

    move-result-object v2

    const-string v3, ":"

    invoke-virtual {v2, v3}, Lcom/google/common/base/Joiner;->withKeyValueSeparator(Ljava/lang/String;)Lcom/google/common/base/Joiner$MapJoiner;

    move-result-object v2

    iget-object v3, p0, Lio/minio/Signer;->canonicalHeaders:Ljava/util/Map;

    invoke-virtual {v2, v3}, Lcom/google/common/base/Joiner$MapJoiner;->join(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\n\n"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lio/minio/Signer;->signedHeaders:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->contentSha256:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/Signer;->canonicalRequest:Ljava/lang/String;

    .line 201
    iget-object v0, p0, Lio/minio/Signer;->canonicalRequest:Ljava/lang/String;

    invoke-static {v0}, Lio/minio/Digest;->sha256Hash(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/Signer;->canonicalRequestHash:Ljava/lang/String;

    .line 202
    return-void
.end method

.method private setChunkStringToSign()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 216
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AWS4-HMAC-SHA256-PAYLOAD\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->date:Ljava/time/ZonedDateTime;

    sget-object v2, Lio/minio/Time;->AMZ_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 219
    invoke-virtual {v1, v2}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lio/minio/Signer;->scope:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lio/minio/Signer;->prevSignature:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 225
    const-string v2, ""

    invoke-static {v2}, Lio/minio/Digest;->sha256Hash(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->contentSha256:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/Signer;->stringToSign:Ljava/lang/String;

    .line 228
    return-void
.end method

.method private setPresignCanonicalRequest(I)V
    .locals 5
    .param p1, "expires"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 315
    sget-object v0, Lio/minio/Signer;->PRESIGN_IGNORED_HEADERS:Ljava/util/Set;

    invoke-direct {p0, v0}, Lio/minio/Signer;->setCanonicalHeaders(Ljava/util/Set;)V

    .line 317
    iget-object v0, p0, Lio/minio/Signer;->request:Lokhttp3/Request;

    invoke-virtual {v0}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/HttpUrl;->newBuilder()Lokhttp3/HttpUrl$Builder;

    move-result-object v0

    .line 318
    .local v0, "urlBuilder":Lokhttp3/HttpUrl$Builder;
    nop

    .line 319
    const-string v1, "X-Amz-Algorithm"

    invoke-static {v1}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "AWS4-HMAC-SHA256"

    invoke-static {v2}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 318
    invoke-virtual {v0, v1, v2}, Lokhttp3/HttpUrl$Builder;->addEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 320
    nop

    .line 321
    const-string v1, "X-Amz-Credential"

    invoke-static {v1}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lio/minio/Signer;->accessKey:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lio/minio/Signer;->scope:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 320
    invoke-virtual {v0, v1, v2}, Lokhttp3/HttpUrl$Builder;->addEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 322
    nop

    .line 323
    const-string v1, "X-Amz-Date"

    invoke-static {v1}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lio/minio/Signer;->date:Ljava/time/ZonedDateTime;

    sget-object v3, Lio/minio/Time;->AMZ_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-virtual {v2, v3}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 322
    invoke-virtual {v0, v1, v2}, Lokhttp3/HttpUrl$Builder;->addEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 324
    nop

    .line 325
    const-string v1, "X-Amz-Expires"

    invoke-static {v1}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 324
    invoke-virtual {v0, v1, v2}, Lokhttp3/HttpUrl$Builder;->addEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 326
    nop

    .line 327
    const-string v1, "X-Amz-SignedHeaders"

    invoke-static {v1}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lio/minio/Signer;->signedHeaders:Ljava/lang/String;

    invoke-static {v2}, Lio/minio/S3Escaper;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 326
    invoke-virtual {v0, v1, v2}, Lokhttp3/HttpUrl$Builder;->addEncodedQueryParameter(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/HttpUrl$Builder;

    .line 328
    invoke-virtual {v0}, Lokhttp3/HttpUrl$Builder;->build()Lokhttp3/HttpUrl;

    move-result-object v1

    iput-object v1, p0, Lio/minio/Signer;->url:Lokhttp3/HttpUrl;

    .line 330
    invoke-direct {p0}, Lio/minio/Signer;->setCanonicalQueryString()V

    .line 332
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lio/minio/Signer;->request:Lokhttp3/Request;

    .line 333
    invoke-virtual {v2}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lio/minio/Signer;->url:Lokhttp3/HttpUrl;

    .line 335
    invoke-virtual {v3}, Lokhttp3/HttpUrl;->encodedPath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lio/minio/Signer;->canonicalQueryString:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 339
    invoke-static {v2}, Lcom/google/common/base/Joiner;->on(Ljava/lang/String;)Lcom/google/common/base/Joiner;

    move-result-object v3

    const-string v4, ":"

    invoke-virtual {v3, v4}, Lcom/google/common/base/Joiner;->withKeyValueSeparator(Ljava/lang/String;)Lcom/google/common/base/Joiner$MapJoiner;

    move-result-object v3

    iget-object v4, p0, Lio/minio/Signer;->canonicalHeaders:Ljava/util/Map;

    invoke-virtual {v3, v4}, Lcom/google/common/base/Joiner$MapJoiner;->join(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\n\n"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lio/minio/Signer;->signedHeaders:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lio/minio/Signer;->contentSha256:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lio/minio/Signer;->canonicalRequest:Ljava/lang/String;

    .line 345
    iget-object v1, p0, Lio/minio/Signer;->canonicalRequest:Ljava/lang/String;

    invoke-static {v1}, Lio/minio/Digest;->sha256Hash(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lio/minio/Signer;->canonicalRequestHash:Ljava/lang/String;

    .line 346
    return-void
.end method

.method private setScope(Ljava/lang/String;)V
    .locals 3
    .param p1, "serviceName"    # Ljava/lang/String;

    .line 117
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lio/minio/Signer;->date:Ljava/time/ZonedDateTime;

    sget-object v2, Lio/minio/Time;->SIGNER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 118
    invoke-virtual {v1, v2}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lio/minio/Signer;->region:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/aws4_request"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/Signer;->scope:Ljava/lang/String;

    .line 124
    return-void
.end method

.method private setSignature()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 249
    iget-object v0, p0, Lio/minio/Signer;->signingKey:[B

    iget-object v1, p0, Lio/minio/Signer;->stringToSign:Ljava/lang/String;

    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    invoke-static {v0, v1}, Lio/minio/Signer;->sumHmac([B[B)[B

    move-result-object v0

    .line 250
    .local v0, "digest":[B
    invoke-static {}, Lcom/google/common/io/BaseEncoding;->base16()Lcom/google/common/io/BaseEncoding;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/common/io/BaseEncoding;->encode([B)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lio/minio/Signer;->signature:Ljava/lang/String;

    .line 251
    return-void
.end method

.method private setSigningKey(Ljava/lang/String;)V
    .locals 6
    .param p1, "serviceName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 232
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AWS4"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->secretKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 234
    .local v0, "aws4SecretKey":Ljava/lang/String;
    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 236
    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    iget-object v2, p0, Lio/minio/Signer;->date:Ljava/time/ZonedDateTime;

    sget-object v3, Lio/minio/Time;->SIGNER_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 237
    invoke-virtual {v2, v3}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    .line 235
    invoke-static {v1, v2}, Lio/minio/Signer;->sumHmac([B[B)[B

    move-result-object v1

    .line 239
    .local v1, "dateKey":[B
    iget-object v2, p0, Lio/minio/Signer;->region:Ljava/lang/String;

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    invoke-static {v1, v2}, Lio/minio/Signer;->sumHmac([B[B)[B

    move-result-object v2

    .line 241
    .local v2, "dateRegionKey":[B
    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 242
    invoke-virtual {p1, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    invoke-static {v2, v3}, Lio/minio/Signer;->sumHmac([B[B)[B

    move-result-object v3

    .line 244
    .local v3, "dateRegionServiceKey":[B
    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 245
    const-string v5, "aws4_request"

    invoke-virtual {v5, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-static {v3, v4}, Lio/minio/Signer;->sumHmac([B[B)[B

    move-result-object v4

    iput-object v4, p0, Lio/minio/Signer;->signingKey:[B

    .line 246
    return-void
.end method

.method private setStringToSign()V
    .locals 3

    .line 205
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AWS4-HMAC-SHA256\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->date:Ljava/time/ZonedDateTime;

    sget-object v2, Lio/minio/Time;->AMZ_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    .line 208
    invoke-virtual {v1, v2}, Ljava/time/ZonedDateTime;->format(Ljava/time/format/DateTimeFormatter;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lio/minio/Signer;->scope:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/Signer;->canonicalRequestHash:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lio/minio/Signer;->stringToSign:Ljava/lang/String;

    .line 213
    return-void
.end method

.method private static signV4(Ljava/lang/String;Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request;
    .locals 10
    .param p0, "serviceName"    # Ljava/lang/String;
    .param p1, "request"    # Lokhttp3/Request;
    .param p2, "region"    # Ljava/lang/String;
    .param p3, "accessKey"    # Ljava/lang/String;
    .param p4, "secretKey"    # Ljava/lang/String;
    .param p5, "contentSha256"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 287
    const-string/jumbo v0, "x-amz-date"

    invoke-virtual {p1, v0}, Lokhttp3/Request;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lio/minio/Time;->AMZ_DATE_FORMAT:Ljava/time/format/DateTimeFormatter;

    invoke-static {v0, v1}, Ljava/time/ZonedDateTime;->parse(Ljava/lang/CharSequence;Ljava/time/format/DateTimeFormatter;)Ljava/time/ZonedDateTime;

    move-result-object v0

    .line 289
    .local v0, "date":Ljava/time/ZonedDateTime;
    new-instance v1, Lio/minio/Signer;

    const/4 v9, 0x0

    move-object v2, v1

    move-object v3, p1

    move-object v4, p5

    move-object v5, v0

    move-object v6, p2

    move-object v7, p3

    move-object v8, p4

    invoke-direct/range {v2 .. v9}, Lio/minio/Signer;-><init>(Lokhttp3/Request;Ljava/lang/String;Ljava/time/ZonedDateTime;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 290
    .local v1, "signer":Lio/minio/Signer;
    invoke-direct {v1, p0}, Lio/minio/Signer;->setScope(Ljava/lang/String;)V

    .line 291
    invoke-direct {v1}, Lio/minio/Signer;->setCanonicalRequest()V

    .line 292
    invoke-direct {v1}, Lio/minio/Signer;->setStringToSign()V

    .line 293
    invoke-direct {v1, p0}, Lio/minio/Signer;->setSigningKey(Ljava/lang/String;)V

    .line 294
    invoke-direct {v1}, Lio/minio/Signer;->setSignature()V

    .line 295
    invoke-direct {v1}, Lio/minio/Signer;->setAuthorization()V

    .line 297
    invoke-virtual {p1}, Lokhttp3/Request;->newBuilder()Lokhttp3/Request$Builder;

    move-result-object v2

    const-string v3, "Authorization"

    iget-object v4, v1, Lio/minio/Signer;->authorization:Ljava/lang/String;

    invoke-virtual {v2, v3, v4}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v2

    invoke-virtual {v2}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2

    return-object v2
.end method

.method public static signV4S3(Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request;
    .locals 6
    .param p0, "request"    # Lokhttp3/Request;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "accessKey"    # Ljava/lang/String;
    .param p3, "secretKey"    # Ljava/lang/String;
    .param p4, "contentSha256"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 304
    const-string/jumbo v0, "s3"

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-static/range {v0 .. v5}, Lio/minio/Signer;->signV4(Ljava/lang/String;Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request;

    move-result-object v0

    return-object v0
.end method

.method public static signV4Sts(Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request;
    .locals 6
    .param p0, "request"    # Lokhttp3/Request;
    .param p1, "region"    # Ljava/lang/String;
    .param p2, "accessKey"    # Ljava/lang/String;
    .param p3, "secretKey"    # Ljava/lang/String;
    .param p4, "contentSha256"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 311
    const-string/jumbo v0, "sts"

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-static/range {v0 .. v5}, Lio/minio/Signer;->signV4(Ljava/lang/String;Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request;

    move-result-object v0

    return-object v0
.end method

.method public static sumHmac([B[B)[B
    .locals 3
    .param p0, "key"    # [B
    .param p1, "data"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 398
    const-string v0, "HmacSHA256"

    invoke-static {v0}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v1

    .line 400
    .local v1, "mac":Ljavax/crypto/Mac;
    new-instance v2, Ljavax/crypto/spec/SecretKeySpec;

    invoke-direct {v2, p0, v0}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    invoke-virtual {v1, v2}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V

    .line 401
    invoke-virtual {v1, p1}, Ljavax/crypto/Mac;->update([B)V

    .line 403
    invoke-virtual {v1}, Ljavax/crypto/Mac;->doFinal()[B

    move-result-object v0

    return-object v0
.end method
