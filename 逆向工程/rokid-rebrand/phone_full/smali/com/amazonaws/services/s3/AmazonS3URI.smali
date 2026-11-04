.class public Lcom/amazonaws/services/s3/AmazonS3URI;
.super Ljava/lang/Object;
.source "AmazonS3URI.java"


# static fields
.field private static final ENDPOINT_PATTERN:Ljava/util/regex/Pattern;

.field private static final VERSION_ID_PATTERN:Ljava/util/regex/Pattern;


# instance fields
.field private final bucket:Ljava/lang/String;

.field private final isPathStyle:Z

.field private final key:Ljava/lang/String;

.field private final region:Ljava/lang/String;

.field private final uri:Ljava/net/URI;

.field private final versionId:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 28
    nop

    .line 29
    const-string v0, "^(.+\\.)?s3[.-]([a-z0-9-]+)\\."

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/AmazonS3URI;->ENDPOINT_PATTERN:Ljava/util/regex/Pattern;

    .line 31
    const-string v0, "[&;]"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/AmazonS3URI;->VERSION_ID_PATTERN:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "str"    # Ljava/lang/String;

    .line 48
    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/services/s3/AmazonS3URI;-><init>(Ljava/lang/String;Z)V

    .line 49
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Z)V
    .locals 1
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "urlEncode"    # Z

    .line 62
    invoke-static {p1, p2}, Lcom/amazonaws/services/s3/AmazonS3URI;->preprocessUrlStr(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/net/URI;->create(Ljava/lang/String;)Ljava/net/URI;

    move-result-object v0

    invoke-direct {p0, v0, p2}, Lcom/amazonaws/services/s3/AmazonS3URI;-><init>(Ljava/net/URI;Z)V

    .line 63
    return-void
.end method

.method public constructor <init>(Ljava/net/URI;)V
    .locals 1
    .param p1, "uri"    # Ljava/net/URI;

    .line 71
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/services/s3/AmazonS3URI;-><init>(Ljava/net/URI;Z)V

    .line 72
    return-void
.end method

.method private constructor <init>(Ljava/net/URI;Z)V
    .locals 8
    .param p1, "uri"    # Ljava/net/URI;
    .param p2, "urlEncode"    # Z

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    if-eqz p1, :cond_e

    .line 78
    iput-object p1, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->uri:Ljava/net/URI;

    .line 81
    const-string v0, "s3"

    invoke-virtual {p1}, Ljava/net/URI;->getScheme()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v0, :cond_2

    .line 82
    iput-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    .line 83
    iput-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->versionId:Ljava/lang/String;

    .line 84
    iput-boolean v1, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->isPathStyle:Z

    .line 85
    invoke-virtual {p1}, Ljava/net/URI;->getAuthority()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    .line 87
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 92
    invoke-virtual {p1}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v0

    .line 93
    .local v0, "path":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-gt v1, v3, :cond_0

    .line 95
    iput-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    goto :goto_0

    .line 99
    :cond_0
    invoke-virtual {p1}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    .line 101
    :goto_0
    return-void

    .line 88
    .end local v0    # "path":Ljava/lang/String;
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid S3 URI: no bucket: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 104
    :cond_2
    invoke-virtual {p1}, Ljava/net/URI;->getHost()Ljava/lang/String;

    move-result-object v0

    .line 105
    .local v0, "host":Ljava/lang/String;
    if-eqz v0, :cond_d

    .line 110
    sget-object v4, Lcom/amazonaws/services/s3/AmazonS3URI;->ENDPOINT_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v4, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v4

    .line 111
    .local v4, "matcher":Ljava/util/regex/Matcher;
    invoke-virtual {v4}, Ljava/util/regex/Matcher;->find()Z

    move-result v5

    if-eqz v5, :cond_c

    .line 117
    invoke-virtual {v4, v3}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v5

    .line 118
    .local v5, "prefix":Ljava/lang/String;
    const-string v6, "/"

    if-eqz v5, :cond_6

    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-eqz v7, :cond_3

    goto :goto_2

    .line 157
    :cond_3
    iput-boolean v1, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->isPathStyle:Z

    .line 160
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    sub-int/2addr v7, v3

    invoke-virtual {v5, v1, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    .line 162
    invoke-virtual {p1}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v1

    .line 163
    .local v1, "path":Ljava/lang/String;
    if-eqz v1, :cond_5

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_5

    invoke-virtual {p1}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_4

    goto :goto_1

    .line 167
    :cond_4
    invoke-virtual {p1}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    goto :goto_5

    .line 164
    :cond_5
    :goto_1
    iput-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    goto :goto_5

    .line 121
    .end local v1    # "path":Ljava/lang/String;
    :cond_6
    :goto_2
    iput-boolean v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->isPathStyle:Z

    .line 125
    if-eqz p2, :cond_7

    invoke-virtual {p1}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v1

    goto :goto_3

    :cond_7
    invoke-virtual {p1}, Ljava/net/URI;->getRawPath()Ljava/lang/String;

    move-result-object v1

    .line 127
    .restart local v1    # "path":Ljava/lang/String;
    :goto_3
    invoke-virtual {v6, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_8

    .line 128
    iput-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    .line 129
    iput-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    goto :goto_4

    .line 132
    :cond_8
    const/16 v6, 0x2f

    invoke-virtual {v1, v6, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v6

    .line 133
    .local v6, "index":I
    const/4 v7, -0x1

    if-ne v6, v7, :cond_9

    .line 136
    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/amazonaws/services/s3/AmazonS3URI;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    .line 137
    iput-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    goto :goto_4

    .line 139
    :cond_9
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v7

    sub-int/2addr v7, v3

    if-ne v6, v7, :cond_a

    .line 142
    invoke-virtual {v1, v3, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/amazonaws/services/s3/AmazonS3URI;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    .line 143
    iput-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    goto :goto_4

    .line 148
    :cond_a
    invoke-virtual {v1, v3, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/amazonaws/services/s3/AmazonS3URI;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    .line 149
    add-int/lit8 v3, v6, 0x1

    invoke-virtual {v1, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/amazonaws/services/s3/AmazonS3URI;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    .line 154
    .end local v1    # "path":Ljava/lang/String;
    .end local v6    # "index":I
    :goto_4
    nop

    .line 171
    :goto_5
    invoke-virtual {p1}, Ljava/net/URI;->getRawQuery()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/amazonaws/services/s3/AmazonS3URI;->parseVersionId(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->versionId:Ljava/lang/String;

    .line 173
    const-string v1, "amazonaws"

    const/4 v3, 0x2

    invoke-virtual {v4, v3}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_b

    .line 175
    iput-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    goto :goto_6

    .line 177
    :cond_b
    invoke-virtual {v4, v3}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    .line 179
    :goto_6
    return-void

    .line 112
    .end local v5    # "prefix":Ljava/lang/String;
    :cond_c
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid S3 URI: hostname does not appear to be a valid S3 endpoint: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 106
    .end local v4    # "matcher":Ljava/util/regex/Matcher;
    :cond_d
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid S3 URI: no hostname: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 76
    .end local v0    # "host":Ljava/lang/String;
    :cond_e
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string/jumbo v1, "uri cannot be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static appendDecoded(Ljava/lang/StringBuilder;Ljava/lang/String;I)V
    .locals 4
    .param p0, "builder"    # Ljava/lang/StringBuilder;
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "index"    # I

    .line 332
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x3

    if-gt p2, v0, :cond_0

    .line 337
    add-int/lit8 v0, p2, 0x1

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 338
    .local v0, "first":C
    add-int/lit8 v1, p2, 0x2

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 340
    .local v1, "second":C
    invoke-static {v0}, Lcom/amazonaws/services/s3/AmazonS3URI;->fromHex(C)I

    move-result v2

    shl-int/lit8 v2, v2, 0x4

    invoke-static {v1}, Lcom/amazonaws/services/s3/AmazonS3URI;->fromHex(C)I

    move-result v3

    or-int/2addr v2, v3

    int-to-char v2, v2

    .line 341
    .local v2, "decoded":C
    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 342
    return-void

    .line 333
    .end local v0    # "first":C
    .end local v1    # "second":C
    .end local v2    # "decoded":C
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid percent-encoded string:\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\"."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static decode(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "str"    # Ljava/lang/String;

    .line 282
    if-nez p0, :cond_0

    .line 283
    const/4 v0, 0x0

    return-object v0

    .line 286
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-ge v0, v1, :cond_2

    .line 287
    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x25

    if-ne v1, v2, :cond_1

    .line 288
    invoke-static {p0, v0}, Lcom/amazonaws/services/s3/AmazonS3URI;->decode(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 286
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 292
    .end local v0    # "i":I
    :cond_2
    return-object p0
.end method

.method private static decode(Ljava/lang/String;I)Ljava/lang/String;
    .locals 4
    .param p0, "str"    # Ljava/lang/String;
    .param p1, "firstPercent"    # I

    .line 303
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 304
    .local v0, "builder":Ljava/lang/StringBuilder;
    const/4 v1, 0x0

    invoke-virtual {p0, v1, p1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 306
    invoke-static {v0, p0, p1}, Lcom/amazonaws/services/s3/AmazonS3URI;->appendDecoded(Ljava/lang/StringBuilder;Ljava/lang/String;I)V

    .line 308
    add-int/lit8 v1, p1, 0x3

    .local v1, "i":I
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_1

    .line 309
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x25

    if-ne v2, v3, :cond_0

    .line 310
    invoke-static {v0, p0, v1}, Lcom/amazonaws/services/s3/AmazonS3URI;->appendDecoded(Ljava/lang/StringBuilder;Ljava/lang/String;I)V

    .line 311
    add-int/lit8 v1, v1, 0x2

    goto :goto_1

    .line 313
    :cond_0
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 308
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 317
    .end local v1    # "i":I
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private static fromHex(C)I
    .locals 4
    .param p0, "c"    # C

    .line 351
    const/16 v0, 0x30

    const-string v1, "\' in escape sequence."

    const-string v2, "Invalid percent-encoded string: bad character \'"

    if-lt p0, v0, :cond_5

    .line 356
    const/16 v0, 0x39

    if-gt p0, v0, :cond_0

    .line 357
    add-int/lit8 v0, p0, -0x30

    return v0

    .line 360
    :cond_0
    const/16 v0, 0x41

    if-lt p0, v0, :cond_4

    .line 365
    const/16 v0, 0x46

    if-gt p0, v0, :cond_1

    .line 366
    add-int/lit8 v0, p0, -0x41

    add-int/lit8 v0, v0, 0xa

    return v0

    .line 369
    :cond_1
    const/16 v0, 0x61

    if-lt p0, v0, :cond_3

    .line 374
    const/16 v0, 0x66

    if-gt p0, v0, :cond_2

    .line 375
    add-int/lit8 v0, p0, -0x61

    add-int/lit8 v0, v0, 0xa

    return v0

    .line 378
    :cond_2
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 370
    :cond_3
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 361
    :cond_4
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 352
    :cond_5
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static parseVersionId(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p0, "query"    # Ljava/lang/String;

    .line 189
    if-eqz p0, :cond_1

    .line 190
    sget-object v0, Lcom/amazonaws/services/s3/AmazonS3URI;->VERSION_ID_PATTERN:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->split(Ljava/lang/CharSequence;)[Ljava/lang/String;

    move-result-object v0

    .line 191
    .local v0, "params":[Ljava/lang/String;
    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 192
    .local v3, "param":Ljava/lang/String;
    const-string/jumbo v4, "versionId="

    invoke-virtual {v3, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 193
    const/16 v1, 0xa

    invoke-virtual {v3, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/amazonaws/services/s3/AmazonS3URI;->decode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 191
    .end local v3    # "param":Ljava/lang/String;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 197
    .end local v0    # "params":[Ljava/lang/String;
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method private static preprocessUrlStr(Ljava/lang/String;Z)Ljava/lang/String;
    .locals 3
    .param p0, "str"    # Ljava/lang/String;
    .param p1, "encode"    # Z

    .line 259
    if-eqz p1, :cond_0

    .line 261
    :try_start_0
    const-string v0, "UTF-8"

    invoke-static {p0, v0}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "%3A"

    const-string v2, ":"

    .line 262
    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "%2F"

    const-string v2, "/"

    .line 263
    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "+"

    const-string v2, " "

    .line 264
    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 261
    return-object v0

    .line 265
    :catch_0
    move-exception v0

    .line 268
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 271
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_0
    return-object p0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 385
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 386
    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_c

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto/16 :goto_4

    .line 388
    :cond_1
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/s3/AmazonS3URI;

    .line 390
    .local v2, "that":Lcom/amazonaws/services/s3/AmazonS3URI;
    iget-boolean v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->isPathStyle:Z

    iget-boolean v4, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->isPathStyle:Z

    if-eq v3, v4, :cond_2

    return v1

    .line 391
    :cond_2
    iget-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->uri:Ljava/net/URI;

    iget-object v4, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->uri:Ljava/net/URI;

    invoke-virtual {v3, v4}, Ljava/net/URI;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v1

    .line 392
    :cond_3
    iget-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    if-eqz v3, :cond_4

    iget-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    iget-object v4, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    goto :goto_0

    :cond_4
    iget-object v3, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    if-eqz v3, :cond_5

    :goto_0
    return v1

    .line 393
    :cond_5
    iget-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    if-eqz v3, :cond_6

    iget-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    iget-object v4, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_7

    goto :goto_1

    :cond_6
    iget-object v3, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    if-eqz v3, :cond_7

    :goto_1
    return v1

    .line 394
    :cond_7
    iget-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->versionId:Ljava/lang/String;

    if-eqz v3, :cond_8

    iget-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->versionId:Ljava/lang/String;

    iget-object v4, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->versionId:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_9

    goto :goto_2

    :cond_8
    iget-object v3, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->versionId:Ljava/lang/String;

    if-eqz v3, :cond_9

    :goto_2
    return v1

    .line 395
    :cond_9
    iget-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    if-eqz v3, :cond_a

    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    iget-object v1, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_3

    :cond_a
    iget-object v3, v2, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    if-nez v3, :cond_b

    goto :goto_3

    :cond_b
    move v0, v1

    :goto_3
    return v0

    .line 386
    .end local v2    # "that":Lcom/amazonaws/services/s3/AmazonS3URI;
    :cond_c
    :goto_4
    return v1
.end method

.method public getBucket()Ljava/lang/String;
    .locals 1

    .line 220
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    return-object v0
.end method

.method public getKey()Ljava/lang/String;
    .locals 1

    .line 227
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    return-object v0
.end method

.method public getRegion()Ljava/lang/String;
    .locals 1

    .line 241
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    return-object v0
.end method

.method public getURI()Ljava/net/URI;
    .locals 1

    .line 204
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->uri:Ljava/net/URI;

    return-object v0
.end method

.method public getVersionId()Ljava/lang/String;
    .locals 1

    .line 234
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->versionId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 400
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->uri:Ljava/net/URI;

    invoke-virtual {v0}, Ljava/net/URI;->hashCode()I

    move-result v0

    .line 401
    .local v0, "result":I
    mul-int/lit8 v1, v0, 0x1f

    iget-boolean v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->isPathStyle:Z

    add-int/2addr v1, v2

    .line 402
    .end local v0    # "result":I
    .local v1, "result":I
    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->bucket:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    goto :goto_0

    :cond_0
    move v2, v3

    :goto_0
    add-int/2addr v0, v2

    .line 403
    .end local v1    # "result":I
    .restart local v0    # "result":I
    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->key:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    goto :goto_1

    :cond_1
    move v2, v3

    :goto_1
    add-int/2addr v1, v2

    .line 404
    .end local v0    # "result":I
    .restart local v1    # "result":I
    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->versionId:Ljava/lang/String;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->versionId:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    goto :goto_2

    :cond_2
    move v2, v3

    :goto_2
    add-int/2addr v0, v2

    .line 405
    .end local v1    # "result":I
    .restart local v0    # "result":I
    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->region:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v3

    :cond_3
    add-int/2addr v1, v3

    .line 406
    .end local v0    # "result":I
    .restart local v1    # "result":I
    return v1
.end method

.method public isPathStyle()Z
    .locals 1

    .line 212
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->isPathStyle:Z

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 246
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3URI;->uri:Ljava/net/URI;

    invoke-virtual {v0}, Ljava/net/URI;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
