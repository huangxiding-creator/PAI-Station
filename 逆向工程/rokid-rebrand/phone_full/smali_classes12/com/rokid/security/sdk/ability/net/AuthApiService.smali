.class public interface abstract Lcom/rokid/security/sdk/ability/net/AuthApiService;
.super Ljava/lang/Object;
.source "AuthApiService.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/net/AuthApiService$Companion;,
        Lcom/rokid/security/sdk/ability/net/AuthApiService$DefaultImpls;,
        Lcom/rokid/security/sdk/ability/net/AuthApiService$Headers;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0005\u0008f\u0018\u0000 \t2\u00020\u0001:\u0002\t\nJ,\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u00032\u0008\u0008\u0003\u0010\u0005\u001a\u00020\u00062\u0008\u0008\u0001\u0010\u0007\u001a\u00020\u00062\u0008\u0008\u0001\u0010\u0008\u001a\u00020\u0006H\'\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/AuthApiService;",
        "",
        "getAppToken",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/sdk/base/common/auth/CredentialResp;",
        "grantType",
        "",
        "appId",
        "appSecret",
        "Companion",
        "Headers",
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
.field public static final Companion:Lcom/rokid/security/sdk/ability/net/AuthApiService$Companion;

.field public static final TOKEN:Ljava/lang/String; = "Authorization"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/ability/net/AuthApiService$Companion;->$$INSTANCE:Lcom/rokid/security/sdk/ability/net/AuthApiService$Companion;

    sput-object v0, Lcom/rokid/security/sdk/ability/net/AuthApiService;->Companion:Lcom/rokid/security/sdk/ability/net/AuthApiService$Companion;

    return-void
.end method


# virtual methods
.method public abstract getAppToken(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Query;
            value = "grant_type"
        .end annotation
    .end param
    .param p2    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Query;
            value = "appid"
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Query;
            value = "secret"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/sdk/base/common/auth/CredentialResp;",
            ">;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/GET;
        value = "/v1/apptoken/create"
    .end annotation
.end method
