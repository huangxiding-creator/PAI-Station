.class public final Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;
.super Ljava/lang/RuntimeException;
.source "ApiException2.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0003\n\u0002\u0008\t\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0018\u0000 \u00142\u00060\u0001j\u0002`\u0002:\u0001\u0014B%\u0012\u0008\u0010\u0003\u001a\u0004\u0018\u00010\u0004\u0012\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u0006\u0012\n\u0008\u0002\u0010\u0007\u001a\u0004\u0018\u00010\u0008\u00a2\u0006\u0002\u0010\tJ\u0012\u0010\u0011\u001a\u0008\u0012\u0004\u0012\u0002H\u00130\u0012\"\u0004\u0008\u0000\u0010\u0013R\u0016\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0096\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u000bR\u0015\u0010\u0003\u001a\u0004\u0018\u00010\u0004\u00a2\u0006\n\n\u0002\u0010\u000e\u001a\u0004\u0008\u000c\u0010\rR\u0016\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0096\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000f\u0010\u0010\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;",
        "Ljava/lang/RuntimeException;",
        "Lkotlin/RuntimeException;",
        "code",
        "",
        "message",
        "",
        "cause",
        "",
        "(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;)V",
        "getCause",
        "()Ljava/lang/Throwable;",
        "getCode",
        "()Ljava/lang/Integer;",
        "Ljava/lang/Integer;",
        "getMessage",
        "()Ljava/lang/String;",
        "toResponse",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "T",
        "Companion",
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
.field public static final CODE_AUTH_INVALID_ERROR:I = 0x2712

.field public static final CODE_DATA_EMPTY:I = 0x1389

.field public static final CODE_JSON_PARSE_ERROR:I = 0xfa3

.field public static final CODE_NET_ERROR:I = 0xfa0

.field public static final CODE_SERVER_ERROR:I = 0x1388

.field public static final CODE_TIMEOUT_ERROR:I = 0xfa2

.field public static final Companion:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2$Companion;

.field public static final SSL_ERROR:I = 0xfa1


# instance fields
.field private final cause:Ljava/lang/Throwable;

.field private final code:Ljava/lang/Integer;

.field private final message:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->Companion:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2$Companion;

    return-void
.end method

.method public constructor <init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0
    .param p1, "code"    # Ljava/lang/Integer;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "cause"    # Ljava/lang/Throwable;

    .line 35
    invoke-direct {p0, p2, p3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 32
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->code:Ljava/lang/Integer;

    .line 33
    iput-object p2, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->message:Ljava/lang/String;

    .line 34
    iput-object p3, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->cause:Ljava/lang/Throwable;

    .line 31
    return-void
.end method

.method public synthetic constructor <init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    .line 31
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_0

    .line 34
    const/4 p3, 0x0

    .line 31
    :cond_0
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 93
    return-void
.end method


# virtual methods
.method public getCause()Ljava/lang/Throwable;
    .locals 1

    .line 34
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->cause:Ljava/lang/Throwable;

    return-object v0
.end method

.method public final getCode()Ljava/lang/Integer;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->code:Ljava/lang/Integer;

    return-object v0
.end method

.method public getMessage()Ljava/lang/String;
    .locals 1

    .line 33
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->message:Ljava/lang/String;

    return-object v0
.end method

.method public final toResponse()Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">()",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "TT;>;"
        }
    .end annotation

    .line 91
    new-instance v8, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->code:Ljava/lang/Integer;

    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiException2;->getMessage()Ljava/lang/String;

    move-result-object v3

    const-wide/16 v5, 0x0

    const/4 v7, 0x0

    const/4 v4, 0x0

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;-><init>(Ljava/lang/Integer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLjava/lang/Object;)V

    return-object v8
.end method
