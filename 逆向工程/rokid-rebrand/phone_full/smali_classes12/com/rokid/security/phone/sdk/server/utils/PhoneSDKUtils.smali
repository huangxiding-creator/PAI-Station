.class public final Lcom/rokid/security/phone/sdk/server/utils/PhoneSDKUtils;
.super Ljava/lang/Object;
.source "PhoneSDKUtils.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0006\u001a\u00020\u0007J\u0006\u0010\u0008\u001a\u00020\u0007R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/utils/PhoneSDKUtils;",
        "",
        "()V",
        "ENTERPRISE_GLASS3_SUBTYPE",
        "",
        "POLICE_GLASS3_SUBTYPE",
        "isPhoneSdkForEnterprise",
        "",
        "isPhoneSdkForPolice",
        "sdk-server_release"
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
.field public static final ENTERPRISE_GLASS3_SUBTYPE:Ljava/lang/String; = "ab9d547e319c93b462d866055ddb31c1"

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/PhoneSDKUtils;

.field public static final POLICE_GLASS3_SUBTYPE:Ljava/lang/String; = "c692851fa858ed977171be9c8af6205a"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/utils/PhoneSDKUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/utils/PhoneSDKUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/utils/PhoneSDKUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/PhoneSDKUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final isPhoneSdkForEnterprise()Z
    .locals 2

    .line 17
    const-string v0, "ab9d547e319c93b462d866055ddb31c1"

    .line 18
    .local v0, "GLASS3_SUBTYPE":Ljava/lang/String;
    const-string v1, "ab9d547e319c93b462d866055ddb31c1"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public final isPhoneSdkForPolice()Z
    .locals 2

    .line 13
    const-string v0, "ab9d547e319c93b462d866055ddb31c1"

    .line 14
    .local v0, "GLASS3_SUBTYPE":Ljava/lang/String;
    const-string v1, "c692851fa858ed977171be9c8af6205a"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method
