.class public Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;
.super Ljava/lang/Object;
.source "InetAddressValidator.java"

# interfaces
.implements Ljava/io/Serializable;


# static fields
.field private static final BASE_16:I = 0x10

.field private static final IPV4_MAX_OCTET_VALUE:I = 0xff

.field private static final IPV4_REGEX:Ljava/lang/String; = "^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"

.field private static final IPV6_MAX_HEX_DIGITS_PER_GROUP:I = 0x4

.field private static final IPV6_MAX_HEX_GROUPS:I = 0x8

.field private static final MAX_UNSIGNED_SHORT:I = 0xffff

.field private static final VALIDATOR:Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;

.field private static final serialVersionUID:J = -0xcc1a905893109a5L


# instance fields
.field private final ipv4Validator:Lio/minio/org/apache/commons/validator/routines/RegexValidator;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 61
    new-instance v0, Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;

    invoke-direct {v0}, Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;-><init>()V

    sput-object v0, Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;->VALIDATOR:Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 64
    new-instance v0, Lio/minio/org/apache/commons/validator/routines/RegexValidator;

    const-string v1, "^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"

    invoke-direct {v0, v1}, Lio/minio/org/apache/commons/validator/routines/RegexValidator;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;->ipv4Validator:Lio/minio/org/apache/commons/validator/routines/RegexValidator;

    return-void
.end method

.method public static getInstance()Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;
    .locals 1

    .line 72
    sget-object v0, Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;->VALIDATOR:Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;

    return-object v0
.end method


# virtual methods
.method public isValid(Ljava/lang/String;)Z
    .locals 1
    .param p1, "inetAddress"    # Ljava/lang/String;

    .line 82
    invoke-virtual {p0, p1}, Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;->isValidInet4Address(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0, p1}, Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;->isValidInet6Address(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public isValidInet4Address(Ljava/lang/String;)Z
    .locals 8
    .param p1, "inet4Address"    # Ljava/lang/String;

    .line 93
    iget-object v0, p0, Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;->ipv4Validator:Lio/minio/org/apache/commons/validator/routines/RegexValidator;

    invoke-virtual {v0, p1}, Lio/minio/org/apache/commons/validator/routines/RegexValidator;->match(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 95
    .local v0, "groups":[Ljava/lang/String;
    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 96
    return v1

    .line 100
    :cond_0
    array-length v2, v0

    move v3, v1

    :goto_0
    const/4 v4, 0x1

    if-ge v3, v2, :cond_5

    aget-object v5, v0, v3

    .line 101
    .local v5, "ipSegment":Ljava/lang/String;
    if-eqz v5, :cond_4

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    if-nez v6, :cond_1

    goto :goto_1

    .line 105
    :cond_1
    const/4 v6, 0x0

    .line 108
    .local v6, "iIpSegment":I
    :try_start_0
    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move v6, v7

    .line 111
    nop

    .line 113
    const/16 v7, 0xff

    if-le v6, v7, :cond_2

    .line 114
    return v1

    .line 117
    :cond_2
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-le v7, v4, :cond_3

    const-string v4, "0"

    invoke-virtual {v5, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 118
    return v1

    .line 100
    .end local v5    # "ipSegment":Ljava/lang/String;
    .end local v6    # "iIpSegment":I
    :cond_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 109
    .restart local v5    # "ipSegment":Ljava/lang/String;
    .restart local v6    # "iIpSegment":I
    :catch_0
    move-exception v2

    .line 110
    .local v2, "e":Ljava/lang/NumberFormatException;
    return v1

    .line 102
    .end local v2    # "e":Ljava/lang/NumberFormatException;
    .end local v6    # "iIpSegment":I
    :cond_4
    :goto_1
    return v1

    .line 122
    .end local v5    # "ipSegment":Ljava/lang/String;
    :cond_5
    return v4
.end method

.method public isValidInet6Address(Ljava/lang/String;)Z
    .locals 10
    .param p1, "inet6Address"    # Ljava/lang/String;

    .line 133
    const-string v0, "::"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    .line 134
    .local v1, "containsCompressedZeroes":Z
    const/4 v2, 0x0

    if-eqz v1, :cond_0

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {p1, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v4

    if-eq v3, v4, :cond_0

    .line 135
    return v2

    .line 137
    :cond_0
    const-string v3, ":"

    invoke-virtual {p1, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 138
    :cond_1
    invoke-virtual {p1, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    .line 139
    :cond_2
    return v2

    .line 141
    :cond_3
    invoke-virtual {p1, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    .line 142
    .local v3, "octets":[Ljava/lang/String;
    if-eqz v1, :cond_6

    .line 143
    new-instance v4, Ljava/util/ArrayList;

    invoke-static {v3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 144
    .local v4, "octetList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 146
    const-string v0, ""

    invoke-interface {v4, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 147
    :cond_4
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-interface {v4}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_5

    .line 148
    invoke-interface {v4, v2}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 150
    :cond_5
    :goto_0
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {v4, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    move-object v3, v0

    check-cast v3, [Ljava/lang/String;

    .line 152
    .end local v4    # "octetList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    :cond_6
    array-length v0, v3

    const/16 v4, 0x8

    if-le v0, v4, :cond_7

    .line 153
    return v2

    .line 155
    :cond_7
    const/4 v0, 0x0

    .line 156
    .local v0, "validOctets":I
    const/4 v5, 0x0

    .line 157
    .local v5, "emptyOctets":I
    const/4 v6, 0x0

    .local v6, "index":I
    :goto_1
    array-length v7, v3

    const/4 v8, 0x1

    if-ge v6, v7, :cond_11

    .line 158
    aget-object v7, v3, v6

    .line 159
    .local v7, "octet":Ljava/lang/String;
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v9

    if-nez v9, :cond_8

    .line 160
    add-int/lit8 v5, v5, 0x1

    .line 161
    if-le v5, v8, :cond_f

    .line 162
    return v2

    .line 165
    :cond_8
    const/4 v5, 0x0

    .line 166
    const-string v9, "."

    invoke-virtual {v7, v9}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_d

    .line 167
    invoke-virtual {p1, v7}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_9

    .line 168
    return v2

    .line 170
    :cond_9
    array-length v9, v3

    sub-int/2addr v9, v8

    if-gt v6, v9, :cond_c

    const/4 v8, 0x6

    if-le v6, v8, :cond_a

    goto :goto_2

    .line 174
    :cond_a
    invoke-virtual {p0, v7}, Lio/minio/org/apache/commons/validator/routines/InetAddressValidator;->isValidInet4Address(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_b

    .line 175
    return v2

    .line 177
    :cond_b
    add-int/lit8 v0, v0, 0x2

    .line 178
    goto :goto_3

    .line 172
    :cond_c
    :goto_2
    return v2

    .line 180
    :cond_d
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v8

    const/4 v9, 0x4

    if-le v8, v9, :cond_e

    .line 181
    return v2

    .line 183
    :cond_e
    const/4 v8, 0x0

    .line 185
    .local v8, "octetInt":I
    const/16 v9, 0x10

    :try_start_0
    invoke-static {v7, v9}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;I)Ljava/lang/Integer;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v9
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move v8, v9

    .line 188
    nop

    .line 189
    if-ltz v8, :cond_10

    const v9, 0xffff

    if-le v8, v9, :cond_f

    goto :goto_4

    .line 193
    .end local v8    # "octetInt":I
    :cond_f
    add-int/lit8 v0, v0, 0x1

    .line 157
    .end local v7    # "octet":Ljava/lang/String;
    :goto_3
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 190
    .restart local v7    # "octet":Ljava/lang/String;
    .restart local v8    # "octetInt":I
    :cond_10
    :goto_4
    return v2

    .line 186
    :catch_0
    move-exception v4

    .line 187
    .local v4, "e":Ljava/lang/NumberFormatException;
    return v2

    .line 195
    .end local v4    # "e":Ljava/lang/NumberFormatException;
    .end local v6    # "index":I
    .end local v7    # "octet":Ljava/lang/String;
    .end local v8    # "octetInt":I
    :cond_11
    if-ge v0, v4, :cond_12

    if-nez v1, :cond_12

    .line 196
    return v2

    .line 198
    :cond_12
    return v8
.end method
