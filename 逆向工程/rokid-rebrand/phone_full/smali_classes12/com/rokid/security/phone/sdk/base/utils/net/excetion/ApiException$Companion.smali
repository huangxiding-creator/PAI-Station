.class public final Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException$Companion;
.super Ljava/lang/Object;
.source "ApiException.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0003\n\u0000\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eR\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException$Companion;",
        "",
        "()V",
        "CODE_AUTH_INVALID_ERROR",
        "",
        "CODE_DATA_EMPTY",
        "CODE_JSON_PARSE_ERROR",
        "CODE_NET_ERROR",
        "CODE_SERVER_ERROR",
        "CODE_TIMEOUT_ERROR",
        "SSL_ERROR",
        "build",
        "Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;",
        "e",
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


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException$Companion;-><init>()V

    return-void
.end method


# virtual methods
.method public final build(Ljava/lang/Throwable;)Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;
    .locals 16
    .param p1, "e"    # Ljava/lang/Throwable;

    move-object/from16 v0, p1

    const-string v1, "e"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 49
    nop

    .line 50
    instance-of v1, v0, Lretrofit2/HttpException;

    const-string/jumbo v2, "\u7f51\u7edc\u5f02\u5e38("

    const/16 v3, 0xfa0

    .line 51
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 50
    const/16 v3, 0x29

    if-eqz v1, :cond_0

    .line 51
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object v4, v0

    check-cast v4, Lretrofit2/HttpException;

    invoke-virtual {v4}, Lretrofit2/HttpException;->code()I

    move-result v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v4, 0x2c

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object v4, v0

    check-cast v4, Lretrofit2/HttpException;

    invoke-virtual {v4}, Lretrofit2/HttpException;->message()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const/4 v8, 0x4

    const/4 v9, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-direct/range {v4 .. v9}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    goto/16 :goto_3

    .line 55
    :cond_0
    nop

    .line 54
    instance-of v1, v0, Ljava/net/ConnectException;

    const/4 v4, 0x1

    if-eqz v1, :cond_1

    move v1, v4

    goto :goto_0

    .line 55
    :cond_1
    instance-of v1, v0, Ljava/net/UnknownHostException;

    :goto_0
    if-eqz v1, :cond_2

    .line 56
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    const/4 v8, 0x4

    const/4 v9, 0x0

    const-string/jumbo v6, "\u7f51\u7edc\u8fde\u63a5\u5931\u8d25\uff0c\u8bf7\u68c0\u67e5\u540e\u518d\u8bd5"

    const/4 v7, 0x0

    move-object v4, v1

    invoke-direct/range {v4 .. v9}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    goto/16 :goto_3

    .line 60
    :cond_2
    nop

    .line 59
    instance-of v1, v0, Lorg/apache/http/conn/ConnectTimeoutException;

    if-eqz v1, :cond_3

    move v1, v4

    goto :goto_1

    .line 60
    :cond_3
    instance-of v1, v0, Ljava/net/SocketTimeoutException;

    :goto_1
    if-eqz v1, :cond_4

    .line 61
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    const/16 v2, 0xfa2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    const/4 v10, 0x4

    const/4 v11, 0x0

    const-string/jumbo v8, "\u8bf7\u6c42\u8d85\u65f6\uff0c\u8bf7\u7a0d\u540e\u518d\u8bd5"

    const/4 v9, 0x0

    move-object v6, v1

    invoke-direct/range {v6 .. v11}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    goto/16 :goto_3

    .line 64
    :cond_4
    instance-of v1, v0, Ljava/io/IOException;

    if-eqz v1, :cond_5

    .line 65
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const/4 v8, 0x4

    const/4 v9, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-direct/range {v4 .. v9}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    goto/16 :goto_3

    .line 68
    :cond_5
    instance-of v1, v0, Ljavax/net/ssl/SSLException;

    if-eqz v1, :cond_6

    .line 69
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    const/16 v2, 0xfa1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u8bc1\u4e66\u9a8c\u8bc1\u5f02\u5e38("

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    const/4 v9, 0x4

    const/4 v10, 0x0

    const/4 v8, 0x0

    move-object v5, v1

    invoke-direct/range {v5 .. v10}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    goto :goto_3

    .line 73
    :cond_6
    nop

    .line 72
    instance-of v1, v0, Lcom/google/gson/JsonParseException;

    if-eqz v1, :cond_7

    goto :goto_2

    .line 73
    :cond_7
    instance-of v4, v0, Lorg/json/JSONException;

    :goto_2
    if-eqz v4, :cond_8

    .line 75
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    const/16 v2, 0xfa3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const/4 v9, 0x4

    const/4 v10, 0x0

    const-string/jumbo v7, "\u6570\u636e\u89e3\u6790\u9519\u8bef\uff0c\u8bf7\u7a0d\u540e\u518d\u8bd5"

    const/4 v8, 0x0

    move-object v5, v1

    invoke-direct/range {v5 .. v10}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    goto :goto_3

    .line 78
    :cond_8
    instance-of v1, v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;

    if-eqz v1, :cond_9

    .line 79
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    move-object v2, v0

    check-cast v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;->getCode()Ljava/lang/Integer;

    move-result-object v5

    move-object v2, v0

    check-cast v2, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ResponseException;->getMsg()Ljava/lang/String;

    move-result-object v6

    const/4 v8, 0x4

    const/4 v9, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-direct/range {v4 .. v9}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    goto :goto_3

    .line 83
    :cond_9
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;

    const/16 v2, 0x1388

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u7cfb\u7edf\u9519\u8bef("

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual/range {p1 .. p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    const/4 v14, 0x4

    const/4 v15, 0x0

    const/4 v13, 0x0

    move-object v10, v1

    invoke-direct/range {v10 .. v15}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 49
    :goto_3
    return-object v1
.end method
