.class public final Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Headers;
.super Ljava/lang/Object;
.source "ApiService.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Headers"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Headers;",
        "",
        "()V",
        "AUTHORIZATION",
        "",
        "NO_AUTH",
        "VERSION",
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
.field public static final AUTHORIZATION:Ljava/lang/String; = "Authorization"

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Headers;

.field public static final NO_AUTH:Ljava/lang/String; = "no_auth"

.field public static final VERSION:Ljava/lang/String; = "version"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Headers;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Headers;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Headers;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Headers;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
