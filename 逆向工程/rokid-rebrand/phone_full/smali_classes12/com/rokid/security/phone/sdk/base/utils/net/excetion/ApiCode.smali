.class public final Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiCode;
.super Ljava/lang/Object;
.source "ApiException.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiCode;",
        "",
        "()V",
        "TOKEN_INVALID",
        "",
        "TOKEN_INVALID2",
        "TOKEN_NEED_LOGIN",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiCode;

.field public static final TOKEN_INVALID:I = 0x2712

.field public static final TOKEN_INVALID2:I = 0x2714

.field public static final TOKEN_NEED_LOGIN:I = 0x4e23


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiCode;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiCode;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiCode;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/excetion/ApiCode;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 267
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
