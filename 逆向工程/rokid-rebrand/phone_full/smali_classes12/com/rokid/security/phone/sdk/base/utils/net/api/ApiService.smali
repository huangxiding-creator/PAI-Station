.class public interface abstract Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService;
.super Ljava/lang/Object;
.source "ApiService.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Companion;,
        Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Headers;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\u0008f\u0018\u0000 \u00022\u00020\u0001:\u0002\u0002\u0003\u00a8\u0006\u0004"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService;",
        "",
        "Companion",
        "Headers",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Companion;

.field public static final TOKEN:Ljava/lang/String; = "Authorization"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Companion;->$$INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Companion;

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService;->Companion:Lcom/rokid/security/phone/sdk/base/utils/net/api/ApiService$Companion;

    return-void
.end method
