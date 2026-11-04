.class public final Lcom/rokid/security/sdk/base/common/util/NetErrorCode;
.super Ljava/lang/Object;
.source "NetErrorCode.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\t\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u0014\u0010\u0003\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006R\u0014\u0010\u0007\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\u0006R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u000c\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/util/NetErrorCode;",
        "",
        "()V",
        "HTTP_CONNECT_ERROR",
        "",
        "getHTTP_CONNECT_ERROR",
        "()I",
        "NET_CONNECT_ERROR",
        "getNET_CONNECT_ERROR",
        "NOT_KONW_ERROR",
        "getNOT_KONW_ERROR",
        "setNOT_KONW_ERROR",
        "(I)V",
        "sdk-base-common_release"
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
.field private static final HTTP_CONNECT_ERROR:I

.field public static final INSTANCE:Lcom/rokid/security/sdk/base/common/util/NetErrorCode;

.field private static final NET_CONNECT_ERROR:I

.field private static NOT_KONW_ERROR:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;->INSTANCE:Lcom/rokid/security/sdk/base/common/util/NetErrorCode;

    .line 9
    const v0, 0x186a1

    sput v0, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;->NET_CONNECT_ERROR:I

    .line 10
    const v0, 0x186a2

    sput v0, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;->HTTP_CONNECT_ERROR:I

    .line 11
    const v0, 0x18704

    sput v0, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;->NOT_KONW_ERROR:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getHTTP_CONNECT_ERROR()I
    .locals 1

    .line 10
    sget v0, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;->HTTP_CONNECT_ERROR:I

    return v0
.end method

.method public final getNET_CONNECT_ERROR()I
    .locals 1

    .line 9
    sget v0, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;->NET_CONNECT_ERROR:I

    return v0
.end method

.method public final getNOT_KONW_ERROR()I
    .locals 1

    .line 11
    sget v0, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;->NOT_KONW_ERROR:I

    return v0
.end method

.method public final setNOT_KONW_ERROR(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 11
    sput p1, Lcom/rokid/security/sdk/base/common/util/NetErrorCode;->NOT_KONW_ERROR:I

    return-void
.end method
