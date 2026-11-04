.class public final Lokhttp3/logging/HttpLoggingInterceptor;
.super Ljava/lang/Object;
.source "HttpLoggingInterceptor.java"

# interfaces
.implements Lokhttp3/Interceptor;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lokhttp3/logging/HttpLoggingInterceptor$Logger;,
        Lokhttp3/logging/HttpLoggingInterceptor$Level;
    }
.end annotation


# static fields
.field private static final UTF8:Ljava/nio/charset/Charset;


# instance fields
.field private volatile headersToRedact:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private volatile level:Lokhttp3/logging/HttpLoggingInterceptor$Level;

.field private final logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 50
    const-string v0, "UTF-8"

    invoke-static {v0}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v0

    sput-object v0, Lokhttp3/logging/HttpLoggingInterceptor;->UTF8:Ljava/nio/charset/Charset;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 120
    sget-object v0, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->DEFAULT:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    invoke-direct {p0, v0}, Lokhttp3/logging/HttpLoggingInterceptor;-><init>(Lokhttp3/logging/HttpLoggingInterceptor$Logger;)V

    .line 121
    return-void
.end method

.method public constructor <init>(Lokhttp3/logging/HttpLoggingInterceptor$Logger;)V
    .locals 1
    .param p1, "logger"    # Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    .line 123
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 129
    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object v0

    iput-object v0, p0, Lokhttp3/logging/HttpLoggingInterceptor;->headersToRedact:Ljava/util/Set;

    .line 138
    sget-object v0, Lokhttp3/logging/HttpLoggingInterceptor$Level;->NONE:Lokhttp3/logging/HttpLoggingInterceptor$Level;

    iput-object v0, p0, Lokhttp3/logging/HttpLoggingInterceptor;->level:Lokhttp3/logging/HttpLoggingInterceptor$Level;

    .line 124
    iput-object p1, p0, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    .line 125
    return-void
.end method

.method private static bodyHasUnknownEncoding(Lokhttp3/Headers;)Z
    .locals 2
    .param p0, "headers"    # Lokhttp3/Headers;

    .line 330
    const-string v0, "Content-Encoding"

    invoke-virtual {p0, v0}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 331
    .local v0, "contentEncoding":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 332
    const-string v1, "identity"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 333
    const-string v1, "gzip"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 331
    :goto_0
    return v1
.end method

.method static isPlaintext(Lokio/Buffer;)Z
    .locals 7
    .param p0, "buffer"    # Lokio/Buffer;

    .line 311
    const/4 v0, 0x0

    :try_start_0
    new-instance v2, Lokio/Buffer;

    invoke-direct {v2}, Lokio/Buffer;-><init>()V

    .line 312
    .local v2, "prefix":Lokio/Buffer;
    invoke-virtual {p0}, Lokio/Buffer;->size()J

    move-result-wide v3

    const-wide/16 v5, 0x40

    cmp-long v1, v3, v5

    if-gez v1, :cond_0

    invoke-virtual {p0}, Lokio/Buffer;->size()J

    move-result-wide v3

    move-wide v5, v3

    .line 313
    .local v5, "byteCount":J
    :cond_0
    const-wide/16 v3, 0x0

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lokio/Buffer;->copyTo(Lokio/Buffer;JJ)Lokio/Buffer;

    .line 314
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    const/16 v3, 0x10

    if-ge v1, v3, :cond_3

    .line 315
    invoke-virtual {v2}, Lokio/Buffer;->exhausted()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 316
    goto :goto_1

    .line 318
    :cond_1
    invoke-virtual {v2}, Lokio/Buffer;->readUtf8CodePoint()I

    move-result v3

    .line 319
    .local v3, "codePoint":I
    invoke-static {v3}, Ljava/lang/Character;->isISOControl(I)Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-static {v3}, Ljava/lang/Character;->isWhitespace(I)Z

    move-result v4
    :try_end_0
    .catch Ljava/io/EOFException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v4, :cond_2

    .line 320
    return v0

    .line 314
    .end local v3    # "codePoint":I
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 323
    .end local v1    # "i":I
    :cond_3
    :goto_1
    const/4 v0, 0x1

    return v0

    .line 324
    .end local v2    # "prefix":Lokio/Buffer;
    .end local v5    # "byteCount":J
    :catch_0
    move-exception v1

    .line 325
    .local v1, "e":Ljava/io/EOFException;
    return v0
.end method

.method private logHeader(Lokhttp3/Headers;I)V
    .locals 4
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "i"    # I

    .line 301
    iget-object v0, p0, Lokhttp3/logging/HttpLoggingInterceptor;->headersToRedact:Ljava/util/Set;

    invoke-virtual {p1, p2}, Lokhttp3/Headers;->name(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string/jumbo v0, "\u2588\u2588"

    goto :goto_0

    :cond_0
    invoke-virtual {p1, p2}, Lokhttp3/Headers;->value(I)Ljava/lang/String;

    move-result-object v0

    .line 302
    .local v0, "value":Ljava/lang/String;
    :goto_0
    iget-object v1, p0, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p2}, Lokhttp3/Headers;->name(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ": "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 303
    return-void
.end method


# virtual methods
.method public getLevel()Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .locals 1

    .line 148
    iget-object v0, p0, Lokhttp3/logging/HttpLoggingInterceptor;->level:Lokhttp3/logging/HttpLoggingInterceptor$Level;

    return-object v0
.end method

.method public intercept(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 30
    .param p1, "chain"    # Lokhttp3/Interceptor$Chain;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 152
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    iget-object v3, v1, Lokhttp3/logging/HttpLoggingInterceptor;->level:Lokhttp3/logging/HttpLoggingInterceptor$Level;

    .line 154
    .local v3, "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    invoke-interface/range {p1 .. p1}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v4

    .line 155
    .local v4, "request":Lokhttp3/Request;
    sget-object v0, Lokhttp3/logging/HttpLoggingInterceptor$Level;->NONE:Lokhttp3/logging/HttpLoggingInterceptor$Level;

    if-ne v3, v0, :cond_0

    .line 156
    invoke-interface {v2, v4}, Lokhttp3/Interceptor$Chain;->proceed(Lokhttp3/Request;)Lokhttp3/Response;

    move-result-object v0

    return-object v0

    .line 159
    :cond_0
    sget-object v0, Lokhttp3/logging/HttpLoggingInterceptor$Level;->BODY:Lokhttp3/logging/HttpLoggingInterceptor$Level;

    const/4 v5, 0x0

    const/4 v6, 0x1

    if-ne v3, v0, :cond_1

    move v0, v6

    goto :goto_0

    :cond_1
    move v0, v5

    :goto_0
    move v7, v0

    .line 160
    .local v7, "logBody":Z
    if-nez v7, :cond_3

    sget-object v0, Lokhttp3/logging/HttpLoggingInterceptor$Level;->HEADERS:Lokhttp3/logging/HttpLoggingInterceptor$Level;

    if-ne v3, v0, :cond_2

    goto :goto_1

    :cond_2
    move v0, v5

    goto :goto_2

    :cond_3
    :goto_1
    move v0, v6

    :goto_2
    move v8, v0

    .line 162
    .local v8, "logHeaders":Z
    invoke-virtual {v4}, Lokhttp3/Request;->body()Lokhttp3/RequestBody;

    move-result-object v9

    .line 163
    .local v9, "requestBody":Lokhttp3/RequestBody;
    if-eqz v9, :cond_4

    move v5, v6

    .line 165
    .local v5, "hasRequestBody":Z
    :cond_4
    invoke-interface/range {p1 .. p1}, Lokhttp3/Interceptor$Chain;->connection()Lokhttp3/Connection;

    move-result-object v6

    .line 166
    .local v6, "connection":Lokhttp3/Connection;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "--> "

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 167
    invoke-virtual {v4}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v10, 0x20

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 168
    invoke-virtual {v4}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v11

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 169
    const-string v11, ""

    if-eqz v6, :cond_5

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, " "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-interface {v6}, Lokhttp3/Connection;->protocol()Lokhttp3/Protocol;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    goto :goto_3

    :cond_5
    move-object v12, v11

    :goto_3
    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 170
    .local v0, "requestStartMessage":Ljava/lang/String;
    const-string v12, "-byte body)"

    const-string v13, " ("

    if-nez v8, :cond_6

    if-eqz v5, :cond_6

    .line 171
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v16, v11

    invoke-virtual {v9}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v10

    invoke-virtual {v14, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v10, v0

    goto :goto_4

    .line 170
    :cond_6
    move-object/from16 v16, v11

    .line 173
    move-object v10, v0

    .end local v0    # "requestStartMessage":Ljava/lang/String;
    .local v10, "requestStartMessage":Ljava/lang/String;
    :goto_4
    iget-object v0, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    invoke-interface {v0, v10}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 175
    const-string v0, "-byte body omitted)"

    const-wide/16 v17, -0x1

    if-eqz v8, :cond_11

    .line 176
    if-eqz v5, :cond_9

    .line 179
    invoke-virtual {v9}, Lokhttp3/RequestBody;->contentType()Lokhttp3/MediaType;

    move-result-object v11

    if-eqz v11, :cond_7

    .line 180
    iget-object v11, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Content-Type: "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v9}, Lokhttp3/RequestBody;->contentType()Lokhttp3/MediaType;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-interface {v11, v14}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 182
    :cond_7
    invoke-virtual {v9}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v14

    cmp-long v11, v14, v17

    if-eqz v11, :cond_8

    .line 183
    iget-object v11, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "Content-Length: "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object v15, v3

    .end local v3    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .local v15, "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    invoke-virtual {v9}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v2

    invoke-virtual {v14, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v11, v2}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    goto :goto_5

    .line 182
    .end local v15    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .restart local v3    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    :cond_8
    move-object v15, v3

    .end local v3    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .restart local v15    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    goto :goto_5

    .line 176
    .end local v15    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .restart local v3    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    :cond_9
    move-object v15, v3

    .line 187
    .end local v3    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .restart local v15    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    :goto_5
    invoke-virtual {v4}, Lokhttp3/Request;->headers()Lokhttp3/Headers;

    move-result-object v2

    .line 188
    .local v2, "headers":Lokhttp3/Headers;
    const/4 v3, 0x0

    .local v3, "i":I
    invoke-virtual {v2}, Lokhttp3/Headers;->size()I

    move-result v11

    .local v11, "count":I
    :goto_6
    if-ge v3, v11, :cond_b

    .line 189
    invoke-virtual {v2, v3}, Lokhttp3/Headers;->name(I)Ljava/lang/String;

    move-result-object v14

    .line 191
    .local v14, "name":Ljava/lang/String;
    move-object/from16 v20, v6

    .end local v6    # "connection":Lokhttp3/Connection;
    .local v20, "connection":Lokhttp3/Connection;
    const-string v6, "Content-Type"

    invoke-virtual {v6, v14}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_a

    const-string v6, "Content-Length"

    invoke-virtual {v6, v14}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_a

    .line 192
    invoke-direct {v1, v2, v3}, Lokhttp3/logging/HttpLoggingInterceptor;->logHeader(Lokhttp3/Headers;I)V

    .line 188
    .end local v14    # "name":Ljava/lang/String;
    :cond_a
    add-int/lit8 v3, v3, 0x1

    move-object/from16 v6, v20

    goto :goto_6

    .end local v20    # "connection":Lokhttp3/Connection;
    .restart local v6    # "connection":Lokhttp3/Connection;
    :cond_b
    move-object/from16 v20, v6

    .line 196
    .end local v3    # "i":I
    .end local v6    # "connection":Lokhttp3/Connection;
    .end local v11    # "count":I
    .restart local v20    # "connection":Lokhttp3/Connection;
    const-string v3, "--> END "

    if-eqz v7, :cond_10

    if-nez v5, :cond_c

    move-object/from16 v21, v2

    move/from16 v22, v5

    move-object/from16 v5, v16

    move-object/from16 v16, v10

    goto/16 :goto_8

    .line 198
    :cond_c
    invoke-virtual {v4}, Lokhttp3/Request;->headers()Lokhttp3/Headers;

    move-result-object v6

    invoke-static {v6}, Lokhttp3/logging/HttpLoggingInterceptor;->bodyHasUnknownEncoding(Lokhttp3/Headers;)Z

    move-result v6

    if-eqz v6, :cond_d

    .line 199
    iget-object v6, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v4}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v11, " (encoded body omitted)"

    invoke-virtual {v3, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v6, v3}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    move/from16 v22, v5

    move-object/from16 v5, v16

    move-object/from16 v16, v10

    goto/16 :goto_9

    .line 201
    :cond_d
    new-instance v6, Lokio/Buffer;

    invoke-direct {v6}, Lokio/Buffer;-><init>()V

    .line 202
    .local v6, "buffer":Lokio/Buffer;
    invoke-virtual {v9, v6}, Lokhttp3/RequestBody;->writeTo(Lokio/BufferedSink;)V

    .line 204
    sget-object v11, Lokhttp3/logging/HttpLoggingInterceptor;->UTF8:Ljava/nio/charset/Charset;

    .line 205
    .local v11, "charset":Ljava/nio/charset/Charset;
    invoke-virtual {v9}, Lokhttp3/RequestBody;->contentType()Lokhttp3/MediaType;

    move-result-object v14

    .line 206
    .local v14, "contentType":Lokhttp3/MediaType;
    if-eqz v14, :cond_e

    .line 207
    move-object/from16 v21, v2

    .end local v2    # "headers":Lokhttp3/Headers;
    .local v21, "headers":Lokhttp3/Headers;
    sget-object v2, Lokhttp3/logging/HttpLoggingInterceptor;->UTF8:Ljava/nio/charset/Charset;

    invoke-virtual {v14, v2}, Lokhttp3/MediaType;->charset(Ljava/nio/charset/Charset;)Ljava/nio/charset/Charset;

    move-result-object v11

    goto :goto_7

    .line 206
    .end local v21    # "headers":Lokhttp3/Headers;
    .restart local v2    # "headers":Lokhttp3/Headers;
    :cond_e
    move-object/from16 v21, v2

    .line 210
    .end local v2    # "headers":Lokhttp3/Headers;
    .restart local v21    # "headers":Lokhttp3/Headers;
    :goto_7
    iget-object v2, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    move/from16 v22, v5

    move-object/from16 v5, v16

    .end local v5    # "hasRequestBody":Z
    .local v22, "hasRequestBody":Z
    invoke-interface {v2, v5}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 211
    invoke-static {v6}, Lokhttp3/logging/HttpLoggingInterceptor;->isPlaintext(Lokio/Buffer;)Z

    move-result v2

    if-eqz v2, :cond_f

    .line 212
    iget-object v2, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    move-object/from16 v16, v10

    .end local v10    # "requestStartMessage":Ljava/lang/String;
    .local v16, "requestStartMessage":Ljava/lang/String;
    invoke-virtual {v6, v11}, Lokio/Buffer;->readString(Ljava/nio/charset/Charset;)Ljava/lang/String;

    move-result-object v10

    invoke-interface {v2, v10}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 213
    iget-object v2, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v4}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 214
    move-object/from16 v23, v11

    .end local v11    # "charset":Ljava/nio/charset/Charset;
    .local v23, "charset":Ljava/nio/charset/Charset;
    invoke-virtual {v9}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v10

    invoke-virtual {v3, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 213
    invoke-interface {v2, v3}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    goto :goto_9

    .line 216
    .end local v16    # "requestStartMessage":Ljava/lang/String;
    .end local v23    # "charset":Ljava/nio/charset/Charset;
    .restart local v10    # "requestStartMessage":Ljava/lang/String;
    .restart local v11    # "charset":Ljava/nio/charset/Charset;
    :cond_f
    move-object/from16 v16, v10

    move-object/from16 v23, v11

    .end local v10    # "requestStartMessage":Ljava/lang/String;
    .end local v11    # "charset":Ljava/nio/charset/Charset;
    .restart local v16    # "requestStartMessage":Ljava/lang/String;
    .restart local v23    # "charset":Ljava/nio/charset/Charset;
    iget-object v2, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v4}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v10, " (binary "

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 217
    invoke-virtual {v9}, Lokhttp3/RequestBody;->contentLength()J

    move-result-wide v10

    invoke-virtual {v3, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 216
    invoke-interface {v2, v3}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    goto :goto_9

    .line 196
    .end local v6    # "buffer":Lokio/Buffer;
    .end local v14    # "contentType":Lokhttp3/MediaType;
    .end local v16    # "requestStartMessage":Ljava/lang/String;
    .end local v21    # "headers":Lokhttp3/Headers;
    .end local v22    # "hasRequestBody":Z
    .end local v23    # "charset":Ljava/nio/charset/Charset;
    .restart local v2    # "headers":Lokhttp3/Headers;
    .restart local v5    # "hasRequestBody":Z
    .restart local v10    # "requestStartMessage":Ljava/lang/String;
    :cond_10
    move-object/from16 v21, v2

    move/from16 v22, v5

    move-object/from16 v5, v16

    move-object/from16 v16, v10

    .line 197
    .end local v2    # "headers":Lokhttp3/Headers;
    .end local v5    # "hasRequestBody":Z
    .end local v10    # "requestStartMessage":Ljava/lang/String;
    .restart local v16    # "requestStartMessage":Ljava/lang/String;
    .restart local v21    # "headers":Lokhttp3/Headers;
    .restart local v22    # "hasRequestBody":Z
    :goto_8
    iget-object v2, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v4}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    goto :goto_9

    .line 175
    .end local v15    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .end local v16    # "requestStartMessage":Ljava/lang/String;
    .end local v20    # "connection":Lokhttp3/Connection;
    .end local v21    # "headers":Lokhttp3/Headers;
    .end local v22    # "hasRequestBody":Z
    .local v3, "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .restart local v5    # "hasRequestBody":Z
    .local v6, "connection":Lokhttp3/Connection;
    .restart local v10    # "requestStartMessage":Ljava/lang/String;
    :cond_11
    move-object v15, v3

    move/from16 v22, v5

    move-object/from16 v20, v6

    move-object/from16 v5, v16

    move-object/from16 v16, v10

    .line 222
    .end local v3    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .end local v5    # "hasRequestBody":Z
    .end local v6    # "connection":Lokhttp3/Connection;
    .end local v10    # "requestStartMessage":Ljava/lang/String;
    .restart local v15    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .restart local v16    # "requestStartMessage":Ljava/lang/String;
    .restart local v20    # "connection":Lokhttp3/Connection;
    .restart local v22    # "hasRequestBody":Z
    :goto_9
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    .line 225
    .local v2, "startNs":J
    move-object/from16 v6, p1

    :try_start_0
    invoke-interface {v6, v4}, Lokhttp3/Interceptor$Chain;->proceed(Lokhttp3/Request;)Lokhttp3/Response;

    move-result-object v10
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 229
    .local v10, "response":Lokhttp3/Response;
    nop

    .line 230
    sget-object v11, Ljava/util/concurrent/TimeUnit;->NANOSECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v23

    move-object/from16 v21, v15

    .end local v15    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .local v21, "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    sub-long v14, v23, v2

    invoke-virtual {v11, v14, v15}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v14

    .line 232
    .local v14, "tookMs":J
    invoke-virtual {v10}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v11

    .line 233
    .local v11, "responseBody":Lokhttp3/ResponseBody;
    move-wide/from16 v23, v2

    .end local v2    # "startNs":J
    .local v23, "startNs":J
    invoke-virtual {v11}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v2

    .line 234
    .local v2, "contentLength":J
    cmp-long v17, v2, v17

    if-eqz v17, :cond_12

    move-object/from16 v17, v4

    .end local v4    # "request":Lokhttp3/Request;
    .local v17, "request":Lokhttp3/Request;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, "-byte"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_a

    .end local v17    # "request":Lokhttp3/Request;
    .restart local v4    # "request":Lokhttp3/Request;
    :cond_12
    move-object/from16 v17, v4

    .end local v4    # "request":Lokhttp3/Request;
    .restart local v17    # "request":Lokhttp3/Request;
    const-string/jumbo v4, "unknown-length"

    .line 235
    .local v4, "bodySize":Ljava/lang/String;
    :goto_a
    iget-object v6, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    move-object/from16 v18, v9

    .end local v9    # "requestBody":Lokhttp3/RequestBody;
    .local v18, "requestBody":Lokhttp3/RequestBody;
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v25, v12

    const-string v12, "<-- "

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    .line 236
    invoke-virtual {v10}, Lokhttp3/Response;->code()I

    move-result v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    .line 237
    invoke-virtual {v10}, Lokhttp3/Response;->message()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-eqz v12, :cond_13

    move-wide/from16 v26, v2

    move-object v3, v5

    const/16 v2, 0x20

    goto :goto_b

    :cond_13
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    move-wide/from16 v26, v2

    const/16 v2, 0x20

    .end local v2    # "contentLength":J
    .local v26, "contentLength":J
    invoke-virtual {v12, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v10}, Lokhttp3/Response;->message()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v3, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_b
    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 238
    invoke-virtual {v10}, Lokhttp3/Response;->request()Lokhttp3/Request;

    move-result-object v3

    invoke-virtual {v3}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "ms"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 239
    if-nez v8, :cond_14

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, ", "

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v9, " body"

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_c

    :cond_14
    move-object v3, v5

    :goto_c
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x29

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 235
    invoke-interface {v6, v2}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 241
    if-eqz v8, :cond_1f

    .line 242
    invoke-virtual {v10}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    .line 243
    .local v2, "headers":Lokhttp3/Headers;
    const/4 v3, 0x0

    .local v3, "i":I
    invoke-virtual {v2}, Lokhttp3/Headers;->size()I

    move-result v6

    .local v6, "count":I
    :goto_d
    if-ge v3, v6, :cond_15

    .line 244
    invoke-direct {v1, v2, v3}, Lokhttp3/logging/HttpLoggingInterceptor;->logHeader(Lokhttp3/Headers;I)V

    .line 243
    add-int/lit8 v3, v3, 0x1

    goto :goto_d

    .line 247
    .end local v3    # "i":I
    .end local v6    # "count":I
    :cond_15
    if-eqz v7, :cond_1e

    invoke-static {v10}, Lokhttp3/internal/http/HttpHeaders;->hasBody(Lokhttp3/Response;)Z

    move-result v3

    if-nez v3, :cond_16

    move-object/from16 v19, v2

    move v13, v7

    move/from16 v29, v8

    goto/16 :goto_10

    .line 249
    :cond_16
    invoke-virtual {v10}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v3

    invoke-static {v3}, Lokhttp3/logging/HttpLoggingInterceptor;->bodyHasUnknownEncoding(Lokhttp3/Headers;)Z

    move-result v3

    if-eqz v3, :cond_17

    .line 250
    iget-object v0, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    const-string v3, "<-- END HTTP (encoded body omitted)"

    invoke-interface {v0, v3}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    move v13, v7

    move/from16 v29, v8

    goto/16 :goto_11

    .line 252
    :cond_17
    invoke-virtual {v11}, Lokhttp3/ResponseBody;->source()Lokio/BufferedSource;

    move-result-object v3

    .line 253
    .local v3, "source":Lokio/BufferedSource;
    const-wide v12, 0x7fffffffffffffffL

    invoke-interface {v3, v12, v13}, Lokio/BufferedSource;->request(J)Z

    .line 254
    invoke-interface {v3}, Lokio/BufferedSource;->buffer()Lokio/Buffer;

    move-result-object v6

    .line 256
    .local v6, "buffer":Lokio/Buffer;
    const/4 v9, 0x0

    .line 257
    .local v9, "gzippedLength":Ljava/lang/Long;
    const-string v12, "Content-Encoding"

    invoke-virtual {v2, v12}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    const-string v13, "gzip"

    invoke-virtual {v13, v12}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_19

    .line 258
    invoke-virtual {v6}, Lokio/Buffer;->size()J

    move-result-wide v12

    invoke-static {v12, v13}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    .line 259
    const/4 v12, 0x0

    .line 261
    .local v12, "gzippedResponseBody":Lokio/GzipSource;
    :try_start_1
    new-instance v13, Lokio/GzipSource;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object/from16 v19, v2

    .end local v2    # "headers":Lokhttp3/Headers;
    .local v19, "headers":Lokhttp3/Headers;
    :try_start_2
    invoke-virtual {v6}, Lokio/Buffer;->clone()Lokio/Buffer;

    move-result-object v2

    invoke-direct {v13, v2}, Lokio/GzipSource;-><init>(Lokio/Source;)V

    move-object v12, v13

    .line 262
    new-instance v2, Lokio/Buffer;

    invoke-direct {v2}, Lokio/Buffer;-><init>()V

    move-object v6, v2

    .line 263
    invoke-virtual {v6, v12}, Lokio/Buffer;->writeAll(Lokio/Source;)J
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 265
    nop

    .line 266
    invoke-virtual {v12}, Lokio/GzipSource;->close()V

    goto :goto_f

    .line 265
    :catchall_0
    move-exception v0

    goto :goto_e

    .end local v19    # "headers":Lokhttp3/Headers;
    .restart local v2    # "headers":Lokhttp3/Headers;
    :catchall_1
    move-exception v0

    move-object/from16 v19, v2

    .end local v2    # "headers":Lokhttp3/Headers;
    .restart local v19    # "headers":Lokhttp3/Headers;
    :goto_e
    if-eqz v12, :cond_18

    .line 266
    invoke-virtual {v12}, Lokio/GzipSource;->close()V

    :cond_18
    throw v0

    .line 257
    .end local v12    # "gzippedResponseBody":Lokio/GzipSource;
    .end local v19    # "headers":Lokhttp3/Headers;
    .restart local v2    # "headers":Lokhttp3/Headers;
    :cond_19
    move-object/from16 v19, v2

    .line 271
    .end local v2    # "headers":Lokhttp3/Headers;
    .restart local v19    # "headers":Lokhttp3/Headers;
    :goto_f
    sget-object v2, Lokhttp3/logging/HttpLoggingInterceptor;->UTF8:Ljava/nio/charset/Charset;

    .line 272
    .local v2, "charset":Ljava/nio/charset/Charset;
    invoke-virtual {v11}, Lokhttp3/ResponseBody;->contentType()Lokhttp3/MediaType;

    move-result-object v12

    .line 273
    .local v12, "contentType":Lokhttp3/MediaType;
    if-eqz v12, :cond_1a

    .line 274
    sget-object v13, Lokhttp3/logging/HttpLoggingInterceptor;->UTF8:Ljava/nio/charset/Charset;

    invoke-virtual {v12, v13}, Lokhttp3/MediaType;->charset(Ljava/nio/charset/Charset;)Ljava/nio/charset/Charset;

    move-result-object v2

    .line 277
    :cond_1a
    invoke-static {v6}, Lokhttp3/logging/HttpLoggingInterceptor;->isPlaintext(Lokio/Buffer;)Z

    move-result v13

    if-nez v13, :cond_1b

    .line 278
    iget-object v13, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    invoke-interface {v13, v5}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 279
    iget-object v5, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v28, v3

    .end local v3    # "source":Lokio/BufferedSource;
    .local v28, "source":Lokio/BufferedSource;
    const-string v3, "<-- END HTTP (binary "

    invoke-virtual {v13, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move v13, v7

    move/from16 v29, v8

    .end local v7    # "logBody":Z
    .end local v8    # "logHeaders":Z
    .local v13, "logBody":Z
    .local v29, "logHeaders":Z
    invoke-virtual {v6}, Lokio/Buffer;->size()J

    move-result-wide v7

    invoke-virtual {v3, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v5, v0}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 280
    return-object v10

    .line 283
    .end local v13    # "logBody":Z
    .end local v28    # "source":Lokio/BufferedSource;
    .end local v29    # "logHeaders":Z
    .restart local v3    # "source":Lokio/BufferedSource;
    .restart local v7    # "logBody":Z
    .restart local v8    # "logHeaders":Z
    :cond_1b
    move-object/from16 v28, v3

    move v13, v7

    move/from16 v29, v8

    .end local v3    # "source":Lokio/BufferedSource;
    .end local v7    # "logBody":Z
    .end local v8    # "logHeaders":Z
    .restart local v13    # "logBody":Z
    .restart local v28    # "source":Lokio/BufferedSource;
    .restart local v29    # "logHeaders":Z
    const-wide/16 v7, 0x0

    cmp-long v0, v26, v7

    if-eqz v0, :cond_1c

    .line 284
    iget-object v0, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    invoke-interface {v0, v5}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 285
    iget-object v0, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    invoke-virtual {v6}, Lokio/Buffer;->clone()Lokio/Buffer;

    move-result-object v3

    invoke-virtual {v3, v2}, Lokio/Buffer;->readString(Ljava/nio/charset/Charset;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v3}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 288
    :cond_1c
    const-string v0, "<-- END HTTP ("

    if-eqz v9, :cond_1d

    .line 289
    iget-object v3, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v6}, Lokio/Buffer;->size()J

    move-result-wide v7

    invoke-virtual {v0, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "-byte, "

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "-gzipped-byte body)"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v3, v0}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    goto :goto_11

    .line 292
    :cond_1d
    iget-object v3, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v6}, Lokio/Buffer;->size()J

    move-result-wide v7

    invoke-virtual {v0, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    move-object/from16 v5, v25

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v3, v0}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    goto :goto_11

    .line 247
    .end local v6    # "buffer":Lokio/Buffer;
    .end local v9    # "gzippedLength":Ljava/lang/Long;
    .end local v12    # "contentType":Lokhttp3/MediaType;
    .end local v13    # "logBody":Z
    .end local v19    # "headers":Lokhttp3/Headers;
    .end local v28    # "source":Lokio/BufferedSource;
    .end local v29    # "logHeaders":Z
    .local v2, "headers":Lokhttp3/Headers;
    .restart local v7    # "logBody":Z
    .restart local v8    # "logHeaders":Z
    :cond_1e
    move-object/from16 v19, v2

    move v13, v7

    move/from16 v29, v8

    .line 248
    .end local v2    # "headers":Lokhttp3/Headers;
    .end local v7    # "logBody":Z
    .end local v8    # "logHeaders":Z
    .restart local v13    # "logBody":Z
    .restart local v19    # "headers":Lokhttp3/Headers;
    .restart local v29    # "logHeaders":Z
    :goto_10
    iget-object v0, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    const-string v2, "<-- END HTTP"

    invoke-interface {v0, v2}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    goto :goto_11

    .line 241
    .end local v13    # "logBody":Z
    .end local v19    # "headers":Lokhttp3/Headers;
    .end local v29    # "logHeaders":Z
    .restart local v7    # "logBody":Z
    .restart local v8    # "logHeaders":Z
    :cond_1f
    move v13, v7

    move/from16 v29, v8

    .line 297
    .end local v7    # "logBody":Z
    .end local v8    # "logHeaders":Z
    .restart local v13    # "logBody":Z
    .restart local v29    # "logHeaders":Z
    :goto_11
    return-object v10

    .line 226
    .end local v10    # "response":Lokhttp3/Response;
    .end local v11    # "responseBody":Lokhttp3/ResponseBody;
    .end local v13    # "logBody":Z
    .end local v14    # "tookMs":J
    .end local v17    # "request":Lokhttp3/Request;
    .end local v18    # "requestBody":Lokhttp3/RequestBody;
    .end local v21    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .end local v23    # "startNs":J
    .end local v26    # "contentLength":J
    .end local v29    # "logHeaders":Z
    .local v2, "startNs":J
    .local v4, "request":Lokhttp3/Request;
    .restart local v7    # "logBody":Z
    .restart local v8    # "logHeaders":Z
    .local v9, "requestBody":Lokhttp3/RequestBody;
    .restart local v15    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    :catch_0
    move-exception v0

    move-wide/from16 v23, v2

    move-object/from16 v17, v4

    move v13, v7

    move/from16 v29, v8

    move-object/from16 v18, v9

    move-object/from16 v21, v15

    move-object v2, v0

    .end local v2    # "startNs":J
    .end local v4    # "request":Lokhttp3/Request;
    .end local v7    # "logBody":Z
    .end local v8    # "logHeaders":Z
    .end local v9    # "requestBody":Lokhttp3/RequestBody;
    .end local v15    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .restart local v13    # "logBody":Z
    .restart local v17    # "request":Lokhttp3/Request;
    .restart local v18    # "requestBody":Lokhttp3/RequestBody;
    .restart local v21    # "level":Lokhttp3/logging/HttpLoggingInterceptor$Level;
    .restart local v23    # "startNs":J
    .restart local v29    # "logHeaders":Z
    move-object v0, v2

    .line 227
    .local v0, "e":Ljava/lang/Exception;
    iget-object v2, v1, Lokhttp3/logging/HttpLoggingInterceptor;->logger:Lokhttp3/logging/HttpLoggingInterceptor$Logger;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "<-- HTTP FAILED: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lokhttp3/logging/HttpLoggingInterceptor$Logger;->log(Ljava/lang/String;)V

    .line 228
    throw v0
.end method

.method public redactHeader(Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 132
    new-instance v0, Ljava/util/TreeSet;

    sget-object v1, Ljava/lang/String;->CASE_INSENSITIVE_ORDER:Ljava/util/Comparator;

    invoke-direct {v0, v1}, Ljava/util/TreeSet;-><init>(Ljava/util/Comparator;)V

    .line 133
    .local v0, "newHeadersToRedact":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    iget-object v1, p0, Lokhttp3/logging/HttpLoggingInterceptor;->headersToRedact:Ljava/util/Set;

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    .line 134
    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 135
    iput-object v0, p0, Lokhttp3/logging/HttpLoggingInterceptor;->headersToRedact:Ljava/util/Set;

    .line 136
    return-void
.end method

.method public setLevel(Lokhttp3/logging/HttpLoggingInterceptor$Level;)Lokhttp3/logging/HttpLoggingInterceptor;
    .locals 2
    .param p1, "level"    # Lokhttp3/logging/HttpLoggingInterceptor$Level;

    .line 142
    if-eqz p1, :cond_0

    .line 143
    iput-object p1, p0, Lokhttp3/logging/HttpLoggingInterceptor;->level:Lokhttp3/logging/HttpLoggingInterceptor$Level;

    .line 144
    return-object p0

    .line 142
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "level == null. Use Level.NONE instead."

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
