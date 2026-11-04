.class public final Lcom/rokid/security/phone/sdk/base/utils/CustomHostParser;
.super Ljava/lang/Object;
.source "CustomHostParser.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0003\u001a\u00020\u00042\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u0006\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/CustomHostParser;",
        "",
        "()V",
        "parse",
        "Lcom/rokid/security/phone/sdk/base/utils/ParsedHost;",
        "input",
        "",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/CustomHostParser;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/CustomHostParser;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/CustomHostParser;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/CustomHostParser;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/CustomHostParser;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final parse(Ljava/lang/String;)Lcom/rokid/security/phone/sdk/base/utils/ParsedHost;
    .locals 13
    .param p1, "input"    # Ljava/lang/String;

    .line 15
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
    const-string v3, "https"

    const-string v4, ""

    if-eqz v0, :cond_2

    .line 16
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/ParsedHost;

    invoke-direct {v0, v3, v4, v4}, Lcom/rokid/security/phone/sdk/base/utils/ParsedHost;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v0

    .line 19
    :cond_2
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 22
    .local v0, "url":Ljava/lang/String;
    const-string v5, "http://"

    const/4 v6, 0x2

    const/4 v7, 0x0

    invoke-static {v0, v5, v2, v6, v7}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_3

    const-string v5, "https://"

    invoke-static {v0, v5, v2, v6, v7}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_3

    .line 23
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 26
    :cond_3
    nop

    .line 27
    :try_start_0
    new-instance v5, Ljava/net/URI;

    invoke-direct {v5, v0}, Ljava/net/URI;-><init>(Ljava/lang/String;)V

    .line 29
    .local v5, "uri":Ljava/net/URI;
    invoke-virtual {v5}, Ljava/net/URI;->getScheme()Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_4

    move-object v6, v3

    .line 32
    .local v6, "protocol":Ljava/lang/String;
    :cond_4
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    move-object v8, v7

    .local v8, "$this$parse_u24lambda_u240":Ljava/lang/StringBuilder;
    const/4 v9, 0x0

    .line 34
    .local v9, "$i$a$-buildString-CustomHostParser$parse$host$1":I
    invoke-virtual {v5}, Ljava/net/URI;->getHost()Ljava/lang/String;

    move-result-object v10

    if-nez v10, :cond_5

    invoke-virtual {v5}, Ljava/net/URI;->getAuthority()Ljava/lang/String;

    move-result-object v10

    :cond_5
    if-nez v10, :cond_6

    move-object v10, v4

    goto :goto_2

    :cond_6
    const-string/jumbo v11, "uri.host ?: uri.authority ?: \"\""

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 35
    .local v10, "rawHost":Ljava/lang/String;
    :goto_2
    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 36
    invoke-virtual {v5}, Ljava/net/URI;->getPort()I

    move-result v11

    const/4 v12, -0x1

    if-eq v11, v12, :cond_7

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v12, 0x3a

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v5}, Ljava/net/URI;->getPort()I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 37
    :cond_7
    nop

    .line 32
    .end local v8    # "$this$parse_u24lambda_u240":Ljava/lang/StringBuilder;
    .end local v9    # "$i$a$-buildString-CustomHostParser$parse$host$1":I
    .end local v10    # "rawHost":Ljava/lang/String;
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    const-string v8, "StringBuilder().apply(builderAction).toString()"

    invoke-static {v7, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 40
    .local v7, "host":Ljava/lang/String;
    invoke-virtual {v5}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v8

    .local v8, "it":Ljava/lang/String;
    const/4 v9, 0x0

    .line 41
    .local v9, "$i$a$-let-CustomHostParser$parse$prefix$1":I
    move-object v10, v8

    check-cast v10, Ljava/lang/CharSequence;

    if-eqz v10, :cond_9

    invoke-static {v10}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v10

    if-eqz v10, :cond_8

    goto :goto_3

    :cond_8
    move v10, v2

    goto :goto_4

    :cond_9
    :goto_3
    move v10, v1

    :goto_4
    if-nez v10, :cond_b

    const-string v10, "/"

    invoke-static {v8, v10}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_a

    goto :goto_5

    :cond_a
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "it"

    invoke-static {v8, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-array v1, v1, [C

    const/16 v11, 0x2f

    aput-char v11, v1, v2

    invoke-static {v8, v1}, Lkotlin/text/StringsKt;->trimEnd(Ljava/lang/String;[C)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_6

    :cond_b
    :goto_5
    move-object v1, v4

    .line 40
    .end local v8    # "it":Ljava/lang/String;
    .end local v9    # "$i$a$-let-CustomHostParser$parse$prefix$1":I
    :goto_6
    nop

    .line 44
    .local v1, "prefix":Ljava/lang/String;
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/ParsedHost;

    invoke-direct {v2, v6, v7, v1}, Lcom/rokid/security/phone/sdk/base/utils/ParsedHost;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "prefix":Ljava/lang/String;
    .end local v5    # "uri":Ljava/net/URI;
    .end local v6    # "protocol":Ljava/lang/String;
    .end local v7    # "host":Ljava/lang/String;
    goto :goto_7

    .line 45
    :catch_0
    move-exception v1

    .line 46
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 47
    new-instance v2, Lcom/rokid/security/phone/sdk/base/utils/ParsedHost;

    invoke-direct {v2, v3, p1, v4}, Lcom/rokid/security/phone/sdk/base/utils/ParsedHost;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 26
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_7
    return-object v2
.end method
