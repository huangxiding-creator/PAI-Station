.class public final Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;
.super Ljava/lang/Object;
.source "DirectPhotoIntentDetector.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nDirectPhotoIntentDetector.kt\nKotlin\n*S Kotlin\n*F\n+ 1 DirectPhotoIntentDetector.kt\ncom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector\n+ 2 _Arrays.kt\nkotlin/collections/ArraysKt___ArraysKt\n*L\n1#1,48:1\n12744#2,2:49\n12744#2,2:51\n*S KotlinDebug\n*F\n+ 1 DirectPhotoIntentDetector.kt\ncom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector\n*L\n44#1:49,2\n45#1:51,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0011\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u000b\u001a\u00020\u000c2\u0008\u0010\r\u001a\u0004\u0018\u00010\tR\u0016\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u00020\u00050\u0004X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0006R\u000e\u0010\u0007\u001a\u00020\u0005X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u0008\u001a\u0008\u0012\u0004\u0012\u00020\t0\u0004X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\n\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;",
        "",
        "()V",
        "directPhotoPatterns",
        "",
        "Lkotlin/text/Regex;",
        "[Lkotlin/text/Regex;",
        "punctuationAndWhitespace",
        "visualSemanticKeywords",
        "",
        "[Ljava/lang/String;",
        "isDirectPhotoIntent",
        "",
        "text",
        "sdk-common-ability_release"
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;

.field private static final directPhotoPatterns:[Lkotlin/text/Regex;

.field private static final punctuationAndWhitespace:Lkotlin/text/Regex;

.field private static final visualSemanticKeywords:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    new-instance v0, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;

    .line 10
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "[^a-zA-Z0-9\\u4e00-\\u9fa5]"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;->punctuationAndWhitespace:Lkotlin/text/Regex;

    .line 12
    nop

    .line 13
    const/16 v0, 0x1b

    new-array v0, v0, [Ljava/lang/String;

    const-string/jumbo v1, "\u770b"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string/jumbo v1, "\u8bc6\u522b"

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const-string/jumbo v1, "\u8fa8\u8ba4"

    const/4 v4, 0x2

    aput-object v1, v0, v4

    const-string/jumbo v1, "\u68c0\u6d4b"

    const/4 v5, 0x3

    aput-object v1, v0, v5

    const-string/jumbo v1, "\u68c0\u67e5"

    const/4 v6, 0x4

    aput-object v1, v0, v6

    const/4 v1, 0x5

    const-string/jumbo v7, "\u6392\u67e5"

    aput-object v7, v0, v1

    const/4 v1, 0x6

    const-string/jumbo v7, "\u5de1\u68c0"

    aput-object v7, v0, v1

    const/4 v1, 0x7

    const-string/jumbo v7, "\u5206\u6790"

    aput-object v7, v0, v1

    const/16 v1, 0x8

    const-string/jumbo v7, "\u5224\u65ad"

    aput-object v7, v0, v1

    .line 14
    const-string/jumbo v1, "\u9690\u60a3"

    const/16 v7, 0x9

    aput-object v1, v0, v7

    .line 13
    nop

    .line 14
    const-string/jumbo v1, "\u6545\u969c"

    const/16 v7, 0xa

    aput-object v1, v0, v7

    .line 13
    nop

    .line 14
    const-string/jumbo v1, "\u5f02\u5e38"

    const/16 v7, 0xb

    aput-object v1, v0, v7

    .line 13
    nop

    .line 14
    const-string/jumbo v1, "\u95ee\u9898"

    const/16 v7, 0xc

    aput-object v1, v0, v7

    .line 13
    nop

    .line 14
    const-string/jumbo v1, "\u662f\u4ec0\u4e48"

    const/16 v7, 0xd

    aput-object v1, v0, v7

    .line 13
    nop

    .line 14
    const-string/jumbo v1, "\u6709\u4ec0\u4e48"

    const/16 v7, 0xe

    aput-object v1, v0, v7

    .line 13
    nop

    .line 14
    const-string/jumbo v1, "\u6709\u591a\u5c11"

    const/16 v7, 0xf

    aput-object v1, v0, v7

    .line 13
    nop

    .line 14
    const-string/jumbo v1, "\u51e0\u4e2a"

    const/16 v7, 0x10

    aput-object v1, v0, v7

    .line 13
    nop

    .line 14
    const-string/jumbo v1, "\u662f\u8c01"

    const/16 v7, 0x11

    aput-object v1, v0, v7

    .line 13
    nop

    .line 15
    const-string/jumbo v1, "\u6587\u5b57"

    const/16 v7, 0x12

    aput-object v1, v0, v7

    .line 13
    nop

    .line 15
    const-string/jumbo v1, "\u4e8c\u7ef4\u7801"

    const/16 v7, 0x13

    aput-object v1, v0, v7

    .line 13
    nop

    .line 15
    const-string/jumbo v1, "\u6761\u7801"

    const/16 v7, 0x14

    aput-object v1, v0, v7

    .line 13
    nop

    .line 15
    const-string/jumbo v1, "\u626b\u63cf"

    const/16 v7, 0x15

    aput-object v1, v0, v7

    .line 13
    nop

    .line 15
    const-string/jumbo v1, "\u773c\u524d"

    const/16 v7, 0x16

    aput-object v1, v0, v7

    .line 13
    nop

    .line 15
    const-string/jumbo v1, "\u524d\u9762"

    const/16 v7, 0x17

    aput-object v1, v0, v7

    .line 13
    nop

    .line 15
    const-string/jumbo v1, "\u524d\u65b9"

    const/16 v7, 0x18

    aput-object v1, v0, v7

    .line 13
    nop

    .line 15
    const-string/jumbo v1, "\u5468\u56f4"

    const/16 v7, 0x19

    aput-object v1, v0, v7

    .line 13
    nop

    .line 15
    const-string/jumbo v1, "\u753b\u9762\u4e2d"

    const/16 v7, 0x1a

    aput-object v1, v0, v7

    .line 13
    nop

    .line 12
    sput-object v0, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;->visualSemanticKeywords:[Ljava/lang/String;

    .line 18
    nop

    .line 19
    new-array v0, v6, [Lkotlin/text/Regex;

    new-instance v1, Lkotlin/text/Regex;

    .line 20
    nop

    .line 19
    const-string v6, "^(?:\u8bf7|\u9ebb\u70e6)?(?:\u4f60)?(?:\u518d|\u91cd\u65b0|\u7ee7\u7eed)?(?:\u5e2e\u6211|\u7ed9\u6211|\u66ff\u6211|\u4e3a\u6211|\u5e2e\u5fd9)?(?:\u518d|\u91cd\u65b0|\u7ee7\u7eed)?\u62cd(?:\u6444)?(?:\u4e00\u4e0b|\u4e0b|\u4e2a|\u4e00\u4e2a|\u5f20|\u4e00\u5f20)?(?:\u7167|\u7167\u7247|\u76f8\u7247)?(?:\u4fdd\u5b58(?:\u4e00\u4e0b|\u4e0b\u6765))?(?:\u5427|\u5440|\u554a|\u5462|\u54c8)?$"

    invoke-direct {v1, v6}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    aput-object v1, v0, v2

    .line 25
    new-instance v1, Lkotlin/text/Regex;

    .line 26
    nop

    .line 25
    const-string v2, "^(?:\u8bf7|\u9ebb\u70e6)?(?:\u4f60)?(?:\u518d|\u91cd\u65b0|\u7ee7\u7eed)?(?:\u5e2e\u6211|\u7ed9\u6211|\u66ff\u6211|\u4e3a\u6211|\u5e2e\u5fd9)?(?:\u518d|\u91cd\u65b0|\u7ee7\u7eed)?\u7167(?:\u76f8|\u4e00\u4e0b|\u4e0b|\u5f20|\u4e00\u5f20|\u5f20\u76f8|\u4e00\u5f20\u76f8)?(?:\u5427|\u5440|\u554a|\u5462|\u54c8)?$"

    invoke-direct {v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    aput-object v1, v0, v3

    .line 19
    nop

    .line 30
    new-instance v1, Lkotlin/text/Regex;

    .line 31
    nop

    .line 30
    const-string v2, "^(?:\u8bf7|\u9ebb\u70e6)?(?:\u4f60)?(?:\u518d|\u91cd\u65b0|\u7ee7\u7eed)?\u6765(?:\u4e2a|\u4e00\u4e2a|\u5f20|\u4e00\u5f20)(?:\u7167|\u7167\u7247|\u76f8\u7247)(?:\u5427|\u5440|\u554a|\u5462|\u54c8)?$"

    invoke-direct {v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    aput-object v1, v0, v4

    .line 19
    nop

    .line 34
    new-instance v1, Lkotlin/text/Regex;

    .line 35
    nop

    .line 34
    const-string v2, "^(?:\u8bf7|\u9ebb\u70e6)?(?:\u4f60)?(?:\u5e2e\u6211|\u7ed9\u6211)?\u628a(?:\u8fd9\u4e2a|\u8fd9\u91cc|\u5f53\u524d)?(?:\u4e1c\u897f|\u573a\u666f|\u753b\u9762)?\u62cd(?:\u6444)?\u4e0b\u6765(?:\u4fdd\u5b58)?(?:\u5427|\u5440|\u554a|\u5462|\u54c8)?$"

    invoke-direct {v1, v2}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    aput-object v1, v0, v5

    .line 19
    nop

    .line 18
    sput-object v0, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;->directPhotoPatterns:[Lkotlin/text/Regex;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final isDirectPhotoIntent(Ljava/lang/String;)Z
    .locals 13
    .param p1, "text"    # Ljava/lang/String;

    .line 41
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v2

    goto :goto_1

    :cond_1
    :goto_0
    move v0, v1

    :goto_1
    if-eqz v0, :cond_2

    return v2

    .line 42
    :cond_2
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;->punctuationAndWhitespace:Lkotlin/text/Regex;

    move-object v3, p1

    check-cast v3, Ljava/lang/CharSequence;

    const-string v4, ""

    invoke-virtual {v0, v3, v4}, Lkotlin/text/Regex;->replace(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v3, "this as java.lang.String).toLowerCase(Locale.ROOT)"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    .local v0, "normalized":Ljava/lang/String;
    move-object v3, v0

    check-cast v3, Ljava/lang/CharSequence;

    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I

    move-result v3

    if-nez v3, :cond_3

    move v3, v1

    goto :goto_2

    :cond_3
    move v3, v2

    :goto_2
    if-eqz v3, :cond_4

    return v2

    .line 44
    :cond_4
    sget-object v3, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;->visualSemanticKeywords:[Ljava/lang/String;

    .local v3, "$this$any$iv":[Ljava/lang/Object;
    const/4 v4, 0x0

    .line 49
    .local v4, "$i$f$any":I
    array-length v5, v3

    move v6, v2

    :goto_3
    if-ge v6, v5, :cond_6

    aget-object v7, v3, v6

    .local v7, "element$iv":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, Ljava/lang/CharSequence;

    .local v8, "p0":Ljava/lang/CharSequence;
    const/4 v9, 0x0

    .line 44
    .local v9, "$i$a$-any-DirectPhotoIntentDetector$isDirectPhotoIntent$1":I
    move-object v10, v0

    check-cast v10, Ljava/lang/CharSequence;

    const/4 v11, 0x2

    const/4 v12, 0x0

    invoke-static {v10, v8, v2, v11, v12}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v8

    .line 49
    .end local v8    # "p0":Ljava/lang/CharSequence;
    .end local v9    # "$i$a$-any-DirectPhotoIntentDetector$isDirectPhotoIntent$1":I
    if-eqz v8, :cond_5

    move v3, v1

    goto :goto_4

    .end local v7    # "element$iv":Ljava/lang/Object;
    :cond_5
    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    .line 50
    :cond_6
    move v3, v2

    .line 44
    .end local v3    # "$this$any$iv":[Ljava/lang/Object;
    .end local v4    # "$i$f$any":I
    :goto_4
    if-eqz v3, :cond_7

    return v2

    .line 45
    :cond_7
    sget-object v3, Lcom/rokid/security/sdk/ability/asr/DirectPhotoIntentDetector;->directPhotoPatterns:[Lkotlin/text/Regex;

    .restart local v3    # "$this$any$iv":[Ljava/lang/Object;
    const/4 v4, 0x0

    .line 51
    .restart local v4    # "$i$f$any":I
    array-length v5, v3

    move v6, v2

    :goto_5
    if-ge v6, v5, :cond_9

    aget-object v7, v3, v6

    .restart local v7    # "element$iv":Ljava/lang/Object;
    move-object v8, v7

    .local v8, "it":Lkotlin/text/Regex;
    const/4 v9, 0x0

    .line 45
    .local v9, "$i$a$-any-DirectPhotoIntentDetector$isDirectPhotoIntent$2":I
    move-object v10, v0

    check-cast v10, Ljava/lang/CharSequence;

    invoke-virtual {v8, v10}, Lkotlin/text/Regex;->matches(Ljava/lang/CharSequence;)Z

    move-result v8

    .line 51
    .end local v8    # "it":Lkotlin/text/Regex;
    .end local v9    # "$i$a$-any-DirectPhotoIntentDetector$isDirectPhotoIntent$2":I
    if-eqz v8, :cond_8

    goto :goto_6

    .end local v7    # "element$iv":Ljava/lang/Object;
    :cond_8
    add-int/lit8 v6, v6, 0x1

    goto :goto_5

    .line 52
    :cond_9
    move v1, v2

    .line 45
    .end local v3    # "$this$any$iv":[Ljava/lang/Object;
    .end local v4    # "$i$f$any":I
    :goto_6
    return v1
.end method
