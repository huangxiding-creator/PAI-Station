.class public Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;
.super Ljava/lang/Object;
.source "HttpUtil.java"


# static fields
.field private static final ENCODED_CHARACTERS_WITHOUT_SLASHES:[Ljava/lang/String;

.field private static final ENCODED_CHARACTERS_WITHOUT_SLASHES_REPLACEMENTS:[Ljava/lang/String;

.field private static final ENCODED_CHARACTERS_WITH_SLASHES:[Ljava/lang/String;

.field private static final ENCODED_CHARACTERS_WITH_SLASHES_REPLACEMENTS:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 12

    .line 19
    const/4 v0, 0x4

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "+"

    aput-object v3, v1, v2

    const/4 v4, 0x1

    const-string v5, "*"

    aput-object v5, v1, v4

    const/4 v6, 0x2

    const-string v7, "%7E"

    aput-object v7, v1, v6

    const-string v8, "%2F"

    const/4 v9, 0x3

    aput-object v8, v1, v9

    sput-object v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->ENCODED_CHARACTERS_WITH_SLASHES:[Ljava/lang/String;

    .line 20
    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "%20"

    aput-object v1, v0, v2

    const-string v8, "%2A"

    aput-object v8, v0, v4

    const-string/jumbo v10, "~"

    aput-object v10, v0, v6

    const-string v11, "/"

    aput-object v11, v0, v9

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->ENCODED_CHARACTERS_WITH_SLASHES_REPLACEMENTS:[Ljava/lang/String;

    .line 22
    new-array v0, v9, [Ljava/lang/String;

    aput-object v3, v0, v2

    aput-object v5, v0, v4

    aput-object v7, v0, v6

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->ENCODED_CHARACTERS_WITHOUT_SLASHES:[Ljava/lang/String;

    .line 23
    new-array v0, v9, [Ljava/lang/String;

    aput-object v1, v0, v2

    aput-object v8, v0, v4

    aput-object v10, v0, v6

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->ENCODED_CHARACTERS_WITHOUT_SLASHES_REPLACEMENTS:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static paramToQueryString(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "charset"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 68
    .local p0, "params":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-eqz p0, :cond_4

    invoke-interface {p0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 72
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 73
    .local v0, "paramString":Ljava/lang/StringBuilder;
    const/4 v1, 0x1

    .line 74
    .local v1, "first":Z
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 75
    .local v3, "p":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 76
    .local v4, "key":Ljava/lang/String;
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 78
    .local v5, "value":Ljava/lang/String;
    if-nez v1, :cond_1

    .line 79
    const-string v6, "&"

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 83
    :cond_1
    invoke-static {v4, p1}, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->urlEncode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 84
    if-eqz v5, :cond_2

    .line 85
    const-string v6, "="

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {v5, p1}, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->urlEncode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 88
    :cond_2
    const/4 v1, 0x0

    .line 89
    .end local v3    # "p":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v4    # "key":Ljava/lang/String;
    .end local v5    # "value":Ljava/lang/String;
    goto :goto_0

    .line 91
    :cond_3
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 69
    .end local v0    # "paramString":Ljava/lang/StringBuilder;
    .end local v1    # "first":Z
    :cond_4
    :goto_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public static urlEncode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "value"    # Ljava/lang/String;
    .param p1, "encoding"    # Ljava/lang/String;

    .line 34
    if-nez p0, :cond_0

    .line 35
    const-string v0, ""

    return-object v0

    .line 39
    :cond_0
    :try_start_0
    invoke-static {p0, p1}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 41
    .local v0, "encoded":Ljava/lang/String;
    const-string v1, "+"

    const-string v2, "%20"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "*"

    const-string v3, "%2A"

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "%7E"

    const-string/jumbo v3, "~"

    .line 42
    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "%2F"

    const-string v3, "/"

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 41
    return-object v1

    .line 43
    .end local v0    # "encoded":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 44
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "failed to encode url!"

    invoke-direct {v1, v2, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public static urlEncode(Ljava/lang/String;Z)Ljava/lang/String;
    .locals 3
    .param p0, "value"    # Ljava/lang/String;
    .param p1, "ignoreSlashes"    # Z

    .line 49
    if-nez p0, :cond_0

    .line 50
    const-string v0, ""

    return-object v0

    .line 53
    :cond_0
    :try_start_0
    const-string/jumbo v0, "utf-8"

    invoke-static {p0, v0}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 54
    .local v0, "encoded":Ljava/lang/String;
    if-nez p1, :cond_1

    .line 55
    sget-object v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->ENCODED_CHARACTERS_WITHOUT_SLASHES:[Ljava/lang/String;

    sget-object v2, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->ENCODED_CHARACTERS_WITHOUT_SLASHES_REPLACEMENTS:[Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/alibaba/sdk/android/oss/common/utils/StringUtils;->replaceEach(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 57
    :cond_1
    sget-object v1, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->ENCODED_CHARACTERS_WITH_SLASHES:[Ljava/lang/String;

    sget-object v2, Lcom/alibaba/sdk/android/oss/common/utils/HttpUtil;->ENCODED_CHARACTERS_WITH_SLASHES_REPLACEMENTS:[Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lcom/alibaba/sdk/android/oss/common/utils/StringUtils;->replaceEach(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 58
    .end local v0    # "encoded":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 59
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "FailedToEncodeUri"

    invoke-direct {v1, v2, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method
