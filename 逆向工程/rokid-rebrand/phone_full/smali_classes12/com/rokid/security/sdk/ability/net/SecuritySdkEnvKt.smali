.class public final Lcom/rokid/security/sdk/ability/net/SecuritySdkEnvKt;
.super Ljava/lang/Object;
.source "SecuritySdkEnv.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\"\u0019\u0010\u0000\u001a\n \u0002*\u0004\u0018\u00010\u00010\u0001\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0003\u0010\u0004\u00a8\u0006\u0005"
    }
    d2 = {
        "securitySdkMmkv",
        "Lcom/tencent/mmkv/MMKV;",
        "kotlin.jvm.PlatformType",
        "getSecuritySdkMmkv",
        "()Lcom/tencent/mmkv/MMKV;",
        "sdk-common-ability_release"
    }
    k = 0x2
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field private static final securitySdkMmkv:Lcom/tencent/mmkv/MMKV;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 30
    const-string/jumbo v0, "security-phone-sdk"

    invoke-static {v0}, Lcom/tencent/mmkv/MMKV;->mmkvWithID(Ljava/lang/String;)Lcom/tencent/mmkv/MMKV;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySdkEnvKt;->securitySdkMmkv:Lcom/tencent/mmkv/MMKV;

    return-void
.end method

.method public static final getSecuritySdkMmkv()Lcom/tencent/mmkv/MMKV;
    .locals 1

    .line 30
    sget-object v0, Lcom/rokid/security/sdk/ability/net/SecuritySdkEnvKt;->securitySdkMmkv:Lcom/tencent/mmkv/MMKV;

    return-object v0
.end method
