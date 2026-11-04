.class public final Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;
.super Ljava/lang/Object;
.source "SignUtils.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nSignUtils.kt\nKotlin\n*S Kotlin\n*F\n+ 1 SignUtils.kt\ncom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils\n+ 2 Strings.kt\nkotlin/text/StringsKt__StringsKt\n*L\n1#1,104:1\n107#2:105\n79#2,22:106\n*S KotlinDebug\n*F\n+ 1 SignUtils.kt\ncom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils\n*L\n61#1:105\n61#1:106,22\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0010$\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0007\u001a\u00020\u00042\u0006\u0010\u0008\u001a\u00020\u0004J\u000e\u0010\t\u001a\u00020\u00042\u0006\u0010\n\u001a\u00020\u0004J\u001c\u0010\u000b\u001a\u00020\u00042\u0014\u0010\u000c\u001a\u0010\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u0004\u0018\u00010\rJ\u001c\u0010\u000e\u001a\u00020\u00042\u0012\u0010\u000f\u001a\u000e\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00040\rH\u0003R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;",
        "",
        "()V",
        "APP_KEY",
        "",
        "APP_SECRET",
        "TAG",
        "encryptMd5",
        "context",
        "getBasicAuthorization",
        "sign",
        "getSign",
        "params",
        "",
        "getSortedStr",
        "unSortedStr",
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
.field public static final APP_KEY:Ljava/lang/String; = "F967C3F3ECA944418AB06B3567D8825E"

.field private static final APP_SECRET:Ljava/lang/String; = "F89F1447CFBB423E9DD51ED1AC2286BD"

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;

.field private static final TAG:Ljava/lang/String; = "SignUtils"


# direct methods
.method public static synthetic $r8$lambda$CxBFkYX9_pqsOp7B7YFavVC3N3A(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Z
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;->getSortedStr$lambda$2(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$ZLkGYmbC6B9Kp9ft7V7aMJaI1Y4(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;->getSign$lambda$0(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)I

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$ZvPmP36yMefipTyuWxpENyF3me4(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;->getSortedStr$lambda$3(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static final getSign$lambda$0(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function2;
    .param p1, "p0"    # Ljava/lang/Object;
    .param p2, "p1"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 26
    invoke-interface {p0, p1, p2}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    return v0
.end method

.method private final getSortedStr(Ljava/util/Map;)Ljava/lang/String;
    .locals 3
    .param p1, "unSortedStr"    # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 92
    nop

    .line 93
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    .line 94
    invoke-interface {v0}, Ljava/util/Set;->stream()Ljava/util/stream/Stream;

    move-result-object v0

    .line 95
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils$getSortedStr$1;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils$getSortedStr$1;

    check-cast v1, Lkotlin/jvm/functions/Function1;

    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils$$ExternalSyntheticLambda0;

    invoke-direct {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-interface {v0, v2}, Ljava/util/stream/Stream;->filter(Ljava/util/function/Predicate;)Ljava/util/stream/Stream;

    move-result-object v0

    .line 100
    invoke-static {}, Ljava/util/Map$Entry;->comparingByKey()Ljava/util/Comparator;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/stream/Stream;->sorted(Ljava/util/Comparator;)Ljava/util/stream/Stream;

    move-result-object v0

    .line 101
    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils$getSortedStr$2;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils$getSortedStr$2;

    check-cast v1, Lkotlin/jvm/functions/Function1;

    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils$$ExternalSyntheticLambda1;

    invoke-direct {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils$$ExternalSyntheticLambda1;-><init>(Lkotlin/jvm/functions/Function1;)V

    invoke-interface {v0, v2}, Ljava/util/stream/Stream;->map(Ljava/util/function/Function;)Ljava/util/stream/Stream;

    move-result-object v0

    .line 102
    const-string v1, "&"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Ljava/util/stream/Collectors;->joining(Ljava/lang/CharSequence;)Ljava/util/stream/Collector;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/stream/Stream;->collect(Ljava/util/stream/Collector;)Ljava/lang/Object;

    move-result-object v0

    .line 101
    const-string/jumbo v1, "unSortedStr\n            \u2026(Collectors.joining(\"&\"))"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/lang/String;

    .line 92
    return-object v0
.end method

.method private static final getSortedStr$lambda$2(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Z
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function1;
    .param p1, "p0"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 95
    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    return v0
.end method

.method private static final getSortedStr$lambda$3(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Ljava/lang/String;
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function1;
    .param p1, "p0"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 101
    invoke-interface {p0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public final encryptMd5(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p1, "context"    # Ljava/lang/String;

    const-string v0, ""

    const-string v1, "context"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    nop

    .line 68
    :try_start_0
    const-string v1, "MD5"

    invoke-static {v1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    .line 69
    .local v1, "md":Ljava/security/MessageDigest;
    sget-object v2, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    const-string/jumbo v3, "this as java.lang.String).getBytes(charset)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljava/security/MessageDigest;->update([B)V

    .line 70
    invoke-virtual {v1}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v2

    .local v2, "encryContext":[B
    const/4 v3, 0x0

    .line 72
    .local v3, "i":I
    new-instance v4, Ljava/lang/StringBuffer;

    invoke-direct {v4, v0}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 73
    .local v4, "buf":Ljava/lang/StringBuffer;
    const-string v5, "encryContext"

    invoke-static {v2, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v5, v2

    const/4 v6, 0x0

    :goto_0
    if-ge v6, v5, :cond_2

    aget-byte v7, v2, v6

    .line 74
    .local v7, "b":B
    move v3, v7

    .line 75
    if-gez v3, :cond_0

    .line 76
    add-int/lit16 v3, v3, 0x100

    .line 78
    :cond_0
    const/16 v8, 0x10

    if-ge v3, v8, :cond_1

    .line 79
    const-string v8, "0"

    invoke-virtual {v4, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 81
    :cond_1
    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 73
    nop

    .end local v7    # "b":B
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 83
    :cond_2
    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "buf.toString()"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v5

    .line 84
    .end local v1    # "md":Ljava/security/MessageDigest;
    .end local v2    # "encryContext":[B
    .end local v3    # "i":I
    .end local v4    # "buf":Ljava/lang/StringBuffer;
    :catch_0
    move-exception v1

    .line 85
    .local v1, "e":Ljava/security/NoSuchAlgorithmException;
    invoke-virtual {v1}, Ljava/security/NoSuchAlgorithmException;->printStackTrace()V

    .line 87
    .end local v1    # "e":Ljava/security/NoSuchAlgorithmException;
    return-object v0
.end method

.method public final getBasicAuthorization(Ljava/lang/String;)Ljava/lang/String;
    .locals 14
    .param p1, "sign"    # Ljava/lang/String;

    const-string/jumbo v0, "sign"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 53
    .local v0, "signed":Ljava/lang/String;
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    const-string/jumbo v3, "this as java.lang.String).getBytes(charset)"

    const-string v4, "F967C3F3ECA944418AB06B3567D8825E:"

    const-string v5, "Basic "

    if-lt v1, v2, :cond_0

    .line 54
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Ljava/util/Base64;->getEncoder()Ljava/util/Base64$Encoder;

    move-result-object v2

    .line 55
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    sget-object v5, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v4, v5}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v4}, Ljava/util/Base64$Encoder;->encodeToString([B)Ljava/lang/String;

    move-result-object v2

    .line 54
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 56
    goto/16 :goto_4

    .line 58
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 59
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v4, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v2, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v2

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 60
    nop

    .line 58
    const/4 v3, 0x2

    invoke-static {v2, v3}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v2

    const-string v3, "encodeToString(\n        \u2026e64.NO_WRAP\n            )"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 61
    nop

    .local v2, "$this$trim$iv":Ljava/lang/String;
    const/4 v3, 0x0

    .line 105
    .local v3, "$i$f$trim":I
    move-object v4, v2

    check-cast v4, Ljava/lang/CharSequence;

    .local v4, "$this$trim$iv$iv":Ljava/lang/CharSequence;
    const/4 v5, 0x0

    .line 106
    .local v5, "$i$f$trim":I
    const/4 v6, 0x0

    .line 107
    .local v6, "startIndex$iv$iv":I
    invoke-interface {v4}, Ljava/lang/CharSequence;->length()I

    move-result v7

    const/4 v8, 0x1

    sub-int/2addr v7, v8

    .line 108
    .local v7, "endIndex$iv$iv":I
    const/4 v9, 0x0

    .line 110
    .local v9, "startFound$iv$iv":Z
    :goto_0
    if-gt v6, v7, :cond_6

    .line 111
    if-nez v9, :cond_1

    move v10, v6

    goto :goto_1

    :cond_1
    move v10, v7

    .line 112
    .local v10, "index$iv$iv":I
    :goto_1
    invoke-interface {v4, v10}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v11

    .local v11, "it":C
    const/4 v12, 0x0

    .line 61
    .local v12, "$i$a$-trim-SignUtils$getBasicAuthorization$1":I
    const/16 v13, 0x20

    invoke-static {v11, v13}, Lkotlin/jvm/internal/Intrinsics;->compare(II)I

    move-result v13

    if-gtz v13, :cond_2

    move v13, v8

    goto :goto_2

    :cond_2
    const/4 v13, 0x0

    .line 112
    .end local v11    # "it":C
    .end local v12    # "$i$a$-trim-SignUtils$getBasicAuthorization$1":I
    :goto_2
    move v11, v13

    .line 114
    .local v11, "match$iv$iv":Z
    if-nez v9, :cond_4

    .line 115
    if-nez v11, :cond_3

    .line 116
    const/4 v9, 0x1

    goto :goto_0

    :cond_3
    add-int/lit8 v6, v6, 0x1

    .line 118
    goto :goto_0

    .line 120
    :cond_4
    if-nez v11, :cond_5

    .line 121
    goto :goto_3

    :cond_5
    add-int/lit8 v7, v7, -0x1

    .line 123
    nop

    .end local v10    # "index$iv$iv":I
    .end local v11    # "match$iv$iv":Z
    goto :goto_0

    .line 127
    :cond_6
    :goto_3
    add-int/lit8 v8, v7, 0x1

    invoke-interface {v4, v6, v8}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v4

    .line 105
    .end local v4    # "$this$trim$iv$iv":Ljava/lang/CharSequence;
    .end local v5    # "$i$f$trim":I
    .end local v6    # "startIndex$iv$iv":I
    .end local v7    # "endIndex$iv$iv":I
    .end local v9    # "startFound$iv$iv":Z
    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    .line 58
    .end local v2    # "$this$trim$iv":Ljava/lang/String;
    .end local v3    # "$i$f$trim":I
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 62
    nop

    .line 53
    :goto_4
    return-object v0
.end method

.method public final getSign(Ljava/util/Map;)Ljava/lang/String;
    .locals 3
    .param p1, "params"    # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .line 21
    const-string v0, ""

    .line 22
    .local v0, "sign":Ljava/lang/String;
    if-eqz p1, :cond_0

    .line 23
    nop

    .line 24
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;->getSortedStr(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    .line 42
    :cond_0
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 43
    const-string v1, "appSecret=F89F1447CFBB423E9DD51ED1AC2286BD"

    invoke-virtual {p0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;->encryptMd5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    .line 45
    :cond_1
    nop

    .line 46
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "appSecret=F89F1447CFBB423E9DD51ED1AC2286BD&body="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;->encryptMd5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 45
    invoke-virtual {p0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/SignUtils;->encryptMd5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 42
    :goto_0
    return-object v1
.end method
