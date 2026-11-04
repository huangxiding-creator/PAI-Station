.class public final Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;
.super Ljava/lang/Object;
.source "UserTokenFailureInterceptor.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0005\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0015\u0010\u0003\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0005\u001a\u00020\u0006\u00a2\u0006\u0002\u0010\u0007J\u0018\u0010\u0008\u001a\u00020\u00042\u0006\u0010\t\u001a\u00020\u00062\u0006\u0010\n\u001a\u00020\u0004H\u0002\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;",
        "",
        "()V",
        "parse",
        "",
        "body",
        "",
        "(Ljava/lang/String;)Ljava/lang/Integer;",
        "skipWhitespace",
        "value",
        "from",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;->INSTANCE:Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final skipWhitespace(Ljava/lang/String;I)I
    .locals 2
    .param p1, "value"    # Ljava/lang/String;
    .param p2, "from"    # I

    .line 99
    move v0, p2

    .line 100
    .local v0, "index":I
    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-ge v0, v1, :cond_0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    invoke-static {v1}, Lkotlin/text/CharsKt;->isWhitespace(C)Z

    move-result v1

    if-eqz v1, :cond_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 101
    :cond_0
    return v0
.end method


# virtual methods
.method public final parse(Ljava/lang/String;)Ljava/lang/Integer;
    .locals 14
    .param p1, "body"    # Ljava/lang/String;

    const-string v0, "body"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 46
    const/4 v0, 0x0

    .line 47
    .local v0, "index":I
    const/4 v1, 0x0

    .line 48
    .local v1, "depth":I
    :cond_0
    :goto_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v0, v2, :cond_12

    .line 49
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 50
    const/16 v3, 0x7b

    if-ne v2, v3, :cond_1

    .line 51
    add-int/lit8 v1, v1, 0x1

    .line 52
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 54
    :cond_1
    const/16 v3, 0x7d

    if-ne v2, v3, :cond_2

    .line 55
    add-int/lit8 v1, v1, -0x1

    .line 56
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 58
    :cond_2
    const/16 v3, 0x22

    if-ne v2, v3, :cond_11

    add-int/lit8 v0, v0, 0x1

    .line 59
    move v2, v0

    .line 60
    .local v2, "start":I
    const/4 v4, 0x0

    move v12, v4

    .line 61
    .local v12, "escaped":Z
    :goto_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    const/4 v5, 0x1

    if-ge v0, v4, :cond_6

    .line 62
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 63
    .local v4, "char":C
    if-nez v12, :cond_3

    if-eq v4, v3, :cond_6

    .line 64
    :cond_3
    const/16 v6, 0x5c

    if-nez v12, :cond_4

    if-ne v4, v6, :cond_4

    goto :goto_2

    :cond_4
    const/4 v5, 0x0

    .line 65
    .end local v12    # "escaped":Z
    .local v5, "escaped":Z
    :goto_2
    if-eq v4, v6, :cond_5

    const/4 v5, 0x0

    :cond_5
    move v12, v5

    .line 66
    .end local v5    # "escaped":Z
    .restart local v12    # "escaped":Z
    nop

    .end local v4    # "char":C
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 68
    :cond_6
    move v13, v0

    .line 69
    .local v13, "end":I
    add-int/lit8 v0, v0, 0x1

    .line 70
    if-ne v1, v5, :cond_10

    sub-int v4, v13, v2

    const/4 v5, 0x4

    if-ne v4, v5, :cond_10

    .line 71
    const/16 v10, 0x10

    const/4 v11, 0x0

    const-string v6, "code"

    const/4 v7, 0x0

    const/4 v8, 0x4

    const/4 v9, 0x0

    move-object v4, p1

    move v5, v2

    invoke-static/range {v4 .. v11}, Lkotlin/text/StringsKt;->regionMatches$default(Ljava/lang/String;ILjava/lang/String;IIZILjava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_7

    goto/16 :goto_5

    .line 75
    :cond_7
    invoke-direct {p0, p1, v0}, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;->skipWhitespace(Ljava/lang/String;I)I

    move-result v0

    .line 76
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v0, v4, :cond_0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x3a

    if-eq v4, v5, :cond_8

    goto :goto_0

    .line 77
    :cond_8
    add-int/lit8 v4, v0, 0x1

    invoke-direct {p0, p1, v4}, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;->skipWhitespace(Ljava/lang/String;I)I

    move-result v0

    .line 78
    const/4 v4, 0x0

    .line 79
    .local v4, "quoted":Z
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v0, v5, :cond_9

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-ne v5, v3, :cond_9

    .line 80
    const/4 v4, 0x1

    .line 81
    add-int/lit8 v0, v0, 0x1

    .line 83
    :cond_9
    move v5, v0

    .line 84
    .local v5, "numberStart":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v6

    const/16 v7, 0x2d

    if-ge v0, v6, :cond_a

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v6

    if-ne v6, v7, :cond_a

    add-int/lit8 v0, v0, 0x1

    .line 85
    :cond_a
    :goto_3
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v6

    if-ge v0, v6, :cond_b

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v6

    invoke-static {v6}, Ljava/lang/Character;->isDigit(C)Z

    move-result v6

    if-eqz v6, :cond_b

    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    .line 86
    :cond_b
    if-eq v0, v5, :cond_f

    add-int/lit8 v6, v5, 0x1

    if-ne v0, v6, :cond_c

    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v6

    if-ne v6, v7, :cond_c

    goto :goto_4

    .line 89
    :cond_c
    if-eqz v4, :cond_e

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v6

    if-ge v0, v6, :cond_d

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v6

    if-eq v6, v3, :cond_e

    :cond_d
    goto/16 :goto_0

    .line 90
    :cond_e
    invoke-virtual {p1, v5, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    const-string/jumbo v6, "this as java.lang.String\u2026ing(startIndex, endIndex)"

    invoke-static {v3, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v3}, Lkotlin/text/StringsKt;->toIntOrNull(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v3

    return-object v3

    .line 87
    :cond_f
    :goto_4
    goto/16 :goto_0

    .line 73
    .end local v4    # "quoted":Z
    .end local v5    # "numberStart":I
    :cond_10
    :goto_5
    goto/16 :goto_0

    .line 92
    .end local v2    # "start":I
    .end local v12    # "escaped":Z
    .end local v13    # "end":I
    :cond_11
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_0

    .line 95
    :cond_12
    const/4 v2, 0x0

    return-object v2
.end method
